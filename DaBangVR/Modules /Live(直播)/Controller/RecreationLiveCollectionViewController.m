//
//  RecreationLiveCollectionViewController.m
//  DaBangVR
//
//  Created by mac on 2019/3/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "RecreationLiveCollectionViewController.h"
#import "DBLayout.h"
/** Cell */
#import "LiveCollectionViewCell.h"
/** 放直播 */
#import "PLPlayViewController.h"
@interface RecreationLiveCollectionViewController ()

/** 娱乐数据源 */
@property (nonatomic, copy) NSArray *recreationLiveData;
@property (nonatomic, strong) DBLayout *layout;

@end

@implementation RecreationLiveCollectionViewController

static NSString * const cellID = @"cellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadingData];
    }];
    // 上拉刷新
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadingData)];
}
//数据加载
- (void)loadingData{
    [super loadingData];
    kWeakSelf(self);
    /**
     *streamName标识符确定当前是什么直播
     *recreation表示购物
     */
    NSDictionary *parameters = @{@"streamName":@"recreation",
                                 @"limit"     :@"10",
                                 @"marker"    :@""
                                 };
    [NetWorkHelper POST:URl_getLiveStreamsList parameters:parameters success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = KJSONSerialization(responseObject)[@"data"];
        weakself.recreationLiveData = [LiveModel mj_objectArrayWithKeyValuesArray:dic[@"playList"]];
        weakself.layout = [[DBLayout alloc] init];
        weakself.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        weakself.layout.itemCount = (int)weakself.recreationLiveData.count;
        [self setupUI];
    } failure:nil];
 
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
  
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)setupUI{
    if (self.collectionView) {
        [self.collectionView removeFromSuperview];
    }
    [self.collectionView registerNib:[UINib nibWithNibName:@"LiveCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    self.collectionView.collectionViewLayout = _layout;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(0);
    }];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _recreationLiveData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = _recreationLiveData[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LiveModel *model = _recreationLiveData[indexPath.row];
    [self.MDelegate collectionViewSelectItemAtIndexPathForModel:model];
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}
@end
