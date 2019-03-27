//
//  LiveCollectionView.m
//  DaBangVR
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "LiveCollectionView.h"
#import "DBLayout.h"
// Models
#import "LiveModel.h"
/** Views */
#import "LiveCollectionViewCell.h"

@interface LiveCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>;
@property (nonatomic, strong)DBLayout *layout;
/** 数据源 */
@property (nonatomic, copy) NSArray *liveDataSource;
@end

@implementation LiveCollectionView
static NSString *const CellID = @"CellID";
#pragma mark —— 懒加载

-(instancetype)init{
    self = [super initWithFrame:self.frame collectionViewLayout:self.layout];
    if (self) {
        _layout = [[DBLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self = [[LiveCollectionView alloc] initWithFrame:self.frame collectionViewLayout:_layout];
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"LiveCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellID];
        self.backgroundColor = KWhiteColor;
        // 不显示滚动条
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        //加载数据
        [self loadingData];
        
    }
    return self;
}

- (void)loadingData{
    kWeakSelf(self);
    [NetWorkHelper POST:URl_getLiveStreamsList parameters:nil success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = KJSONSerialization(responseObject)[@"data"];
        weakself.liveDataSource = [LiveModel mj_objectArrayWithKeyValuesArray:dic[@"playList"]];
        weakself.layout.itemCount = (int)weakself.liveDataSource.count;
        [weakself reloadData];
    } failure:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _liveDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    cell.model = _liveDataSource[indexPath.row];
    return cell;
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self ;
}
@end
