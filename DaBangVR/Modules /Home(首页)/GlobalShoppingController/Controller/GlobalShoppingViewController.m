//
//  GlobalShoppingViewController.m
//  DaBangVR
//
//  Created by mac on 2019/2/25.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "GlobalShoppingViewController.h"
#import "GoodsDetailsViewController.h"
// Views;
#import "ShufflingView.h"
#import "HorizontalCollectionView.h"
// Models
#import "CountryListModel.h"
#import "GoodsDetailsModel.h"
@interface GlobalShoppingViewController ()<HorizontalCollectionViewDelegate, ShufflingViewDelegate>
@property (nonatomic, strong) ShufflingView *shufflingView;
// 国家
@property (nonatomic, strong) HorizontalCollectionView *countryCollectionView;
// 国家下的商品
@property (nonatomic, strong) HorizontalCollectionView *goodsCollectionView;
// 推荐
@property (nonatomic, strong) HorizontalCollectionView *recommendGoodsCollectionView;
@property (nonatomic, strong) UIView *collectionHeaderView;
// 国家数据
@property (nonatomic, strong) NSMutableArray *countryData;
// 国家的商品数据
@property (nonatomic, strong) NSMutableArray *countryGoodsData;
// 推荐商品数据
@property (nonatomic, strong) NSMutableArray *recommendGoodsData;

@property (nonatomic, assign) NSInteger high;

@end

@implementation GlobalShoppingViewController
static NSString *CellID = @"CellID";
static NSString *HeaerCollectionViewCellID = @"HeaerCollectionViewCellID";
#pragma mark —— 懒加载
-(HorizontalCollectionView *)countryCollectionView{
    if (!_countryCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置UICollectionView为横向滚动
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 每一行cell之间的间距
        layout.minimumLineSpacing = KMargin;
        // 设置第一个cell和最后一个cell,与父控件之间的间距
        layout.sectionInset = UIEdgeInsetsMake(0, KMargin, 0, KMargin);
        layout.itemSize = CGSizeMake(kFit(70), kFit(90));
        _countryCollectionView = [[HorizontalCollectionView alloc] initWithFrame:CGRectMake(0, KMargin, KScreenW, kFit(90)) collectionViewLayout:layout nibWithNibName:@"CountryCollectionViewCell" collectionViewCellType:CountryCollectionViewCellType];
        _countryCollectionView.aDelegate = self;
        // 解决tableview 和 collectionview 手势冲突问题
        /*意思是：如果手势A失败，手势B才起作用 eg:先让tableView滚在让scrollView滚*/
        [self.tableView.panGestureRecognizer requireGestureRecognizerToFail:_countryCollectionView.panGestureRecognizer];
    }
    return _countryCollectionView;
}

-(HorizontalCollectionView *)goodsCollectionView{
    if (!_goodsCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置UICollectionView为横向滚动
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 每一行cell之间的间距
        layout.minimumLineSpacing = kFit(10);
        // 设置第一个cell和最后一个cell,与父控件之间的间距
        layout.sectionInset = UIEdgeInsetsMake(0, KMargin, 0, KMargin);
        layout.itemSize = CGSizeMake(kFit(173), kFit(90));
        _goodsCollectionView = [[HorizontalCollectionView alloc] initWithFrame:CGRectMake(0, KMargin, KScreenW, kFit(90)) collectionViewLayout:layout nibWithNibName:@"CountryGoodsCollectionViewCell" collectionViewCellType:CountryGoodsCollectionViewCellllType];
        _goodsCollectionView.aDelegate = self;
    }
    return _goodsCollectionView;
}

-(HorizontalCollectionView *)recommendGoodsCollectionView{
    if (!_recommendGoodsCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(kFit(172), kFit(234));
        layout.minimumInteritemSpacing = KMargin;
        layout.sectionInset = UIEdgeInsetsMake(0, KMargin, 0, KMargin);
        _recommendGoodsCollectionView = [[HorizontalCollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH) collectionViewLayout:layout nibWithNibName:@"RecommendGoodsCollectionViewCell" collectionViewCellType:RecommendGoodsCollectionViewCellllType];
        // 禁止滑动
        _recommendGoodsCollectionView.scrollEnabled = NO;
        _recommendGoodsCollectionView.aDelegate = self;
    }
    return _recommendGoodsCollectionView;
}
-(NSMutableArray *)countryData{
    if (!_countryData) {
        _countryData = [[NSMutableArray alloc] init];
    }
    return _countryData;
}
- (NSMutableArray *)countryGoodsData{
    if (!_countryGoodsData) {
        _countryGoodsData = [[NSMutableArray alloc] init];
    }
    return _countryGoodsData;
}
- (NSMutableArray *)recommendGoodsData{
    if (!_recommendGoodsData) {
        _recommendGoodsData = [[NSMutableArray alloc] init];
    }
    return _recommendGoodsData;
}
#pragma mark —— 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全球购";
    
    [self loadingData];
}

- (void)loadingData{
    kWeakSelf(self);
    NSDictionary *parameters = @{
                                 @"parentId":@"2",
                                 @"categoryId":@"1036112",
                                 @"page":@"1",
                                 @"limit":@"10"
                                 };
    [NetWorkHelper POST:URl_getGlobalList parameters:parameters success:^(id  _Nonnull responseObject) {
        NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
        // 国家
        self.countryData = [CountryListModel mj_objectArrayWithKeyValuesArray:data[@"goodsCategoryList"]];
        self.countryCollectionView.data = self.countryData;
        // 国家商品
        self.countryGoodsData = [GoodsDetailsModel mj_objectArrayWithKeyValuesArray:data[@"goodsList"]];
        self.goodsCollectionView.data = self.countryGoodsData;
        // 推荐商品
        self.recommendGoodsData = [GoodsDetailsModel mj_objectArrayWithKeyValuesArray:data[@"goodsLists"]];
        self.recommendGoodsCollectionView.data = self.recommendGoodsData;
        // 得到有了数据后的collectinView的内容高度，在重设tableViewCell的高度。不然显示不了数据
        CGSize size = self.recommendGoodsCollectionView.collectionViewLayout.collectionViewContentSize;
        weakself.high = size.height;
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}

- (void)setupUI{
    [super setupUI];
    // 加载数据
   
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(kTopHeight);
    }];
    // 设置顶部的搜索框
//    [self setupNavagationBar];
    // 轮播
    _shufflingView = [[ShufflingView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, kFit(180)) andIndex:@"5"];
    _shufflingView.delegate = self;
    self.tableView.tableHeaderView = _shufflingView;
}

-(void)setupNavagationBar{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kFit(260), kFit(30))];
    view.layer.cornerRadius = view.mj_h/2;
    view.backgroundColor = KWhiteColor;
    self.navigationItem.titleView = view;
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(KMargin, 0, kFit(200), view.mj_h)];
    [searchBtn setTitle:@"搜索关键字" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor lightGreen] forState:UIControlStateNormal];
    // 文字居左
    searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    searchBtn.adaptiveFontSize = 14;
    [searchBtn addTarget:self action:@selector(searchOfAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:searchBtn];
    
    UIImageView *searchImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kFit(view.mj_w-view.mj_h-5), kFit(5), kFit(20), kFit(20))];
    searchImgView.image = [UIImage imageNamed:@"h_Search"];
    [view addSubview:searchImgView];
}

// 搜索事件
- (void)searchOfAction{}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
        [cell addSubview:self.countryCollectionView];
            break;
        case 1:
        [cell addSubview:self.goodsCollectionView];
            break;
        case 2:
        {
            //collection顶部UI
            kWeakSelf(self);
            //重复添加UI
            if (_collectionHeaderView) {
                [_collectionHeaderView removeFromSuperview];
            }
            _collectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, kFit(80))];
            UIView *searchView = [[UIView alloc] init];
            CGFloat searchH = kFit(30);
            searchView.layer.cornerRadius = searchH/2;
            searchView.layer.borderColor = [[UIColor lightGreen] CGColor];
            searchView.layer.borderWidth = .5f;
            searchView.layer.masksToBounds = YES;
            [_collectionHeaderView addSubview:searchView];
            [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(weakself.collectionHeaderView.mas_centerY);
                make.left.equalTo(KMargin);
                make.size.equalTo(CGSizeMake(searchH*4, searchH));
            }];
            UIImageView *searchImgView = [[UIImageView alloc] init];
            searchImgView.image = [UIImage imageNamed:@"h_Search"];
            [searchView addSubview:searchImgView];
            [searchImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.equalTo(CGSizeMake(kFit(20), kFit(20)));
                make.centerY.equalTo(searchView.mas_centerY);
                make.left.equalTo(KMargin);
            }];
            
            UIImageView *changerImgView = [[UIImageView alloc] init];
            changerImgView.image = [UIImage imageNamed:@"s-switch"];
            [_collectionHeaderView addSubview:changerImgView];
            [changerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(weakself.collectionHeaderView.mas_centerY);
                make.right.equalTo(-KMargin);
                make.size.equalTo(CGSizeMake(kFit(40), kFit(40)));
            }];
            [cell addSubview:_collectionHeaderView];
            [self.recommendGoodsCollectionView setOrigin:CGPointMake(0, _collectionHeaderView.mj_y+_collectionHeaderView.mj_h)];
            [cell addSubview:self.recommendGoodsCollectionView];
        }
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        // 根据collectionView内容得到高度
//        CGSize size = self.recommendGoodsCollectionView.collectionViewLayout.collectionViewContentSize;
        // 重新计算collectionView的大小
        [self.recommendGoodsCollectionView setSize:CGSizeMake(KScreenW, _high)];
        return _high + _collectionHeaderView.mj_h;
    }
   return kFit(100);
}

#pragma mark —— HorizontalCollectionView 协议
-(void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath collectionViewCellType:(CollectionViewCellType)type{
    switch (type) {
        case CountryCollectionViewCellType:
        {
            CountryListModel *model = self.countryData[indexPath.row];
            NSDictionary *parameters = @{
                                         @"categoryId":model.id,
                                         @"page":@"1",
                                         @"limit":@"10"
                                         };
            
            [NetWorkHelper POST:URl_getGlobalLists parameters:parameters success:^(id  _Nonnull responseObject) {
                NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
                self.countryGoodsData = [GoodsDetailsModel mj_objectArrayWithKeyValuesArray:data[@"goodsList"]];
                self.goodsCollectionView.data = self.countryGoodsData;
            } failure:^(NSError * _Nonnull error) {
                
            }];
        }
            break;
        case CountryGoodsCollectionViewCellllType:
        {
            GoodsDetailsModel *model = self.countryGoodsData[indexPath.row];
            GoodsDetailsViewController *vc = [[GoodsDetailsViewController alloc] init];
            vc.index = model.id;
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case RecommendGoodsCollectionViewCellllType:
        {
            GoodsDetailsModel *model = self.recommendGoodsData[indexPath.row];
            GoodsDetailsViewController *vc = [[GoodsDetailsViewController alloc] init];
            vc.index = model.id;
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        default:
            break;
    }
}

-(void)addShoppingCar:(UIButton *)sender didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NSDictionary *dic;
    if (sender.tag == 100) {
        // 国家商品加入购物车
        GoodsDetailsModel *model = self.countryGoodsData[indexPath.row];
        dic = @{@"goodsId":model.id,
                @"number":@"1"
                };
    }else{
        // 推荐商品加入购物车
        GoodsDetailsModel *model = self.recommendGoodsData[indexPath.row];
        dic = @{@"goodsId":model.id,
                @"number":@"1"
                };
    }
    //添加w购物车
    [NetWorkHelper POST:URl_addToCar parameters:dic success:^(id  _Nonnull responseObject) {
        
        [SVProgressHUD showInfoWithStatus:KJSONSerialization(responseObject)[@"errmsg"]];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:1.0];
    } failure:^(NSError * _Nonnull error) {
        DLog(@"error is %@",error);
    }];
}

#pragma mark —— ShufflingView 代理
-(void)imgDidSelected:(NSString *)goodsID{
    GoodsDetailsViewController *vc = [[GoodsDetailsViewController alloc] init];
    vc.index = goodsID;
    [self.navigationController pushViewController:vc  animated:NO];
}

@end
