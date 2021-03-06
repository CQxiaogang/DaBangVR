//
//  StoreDetailsViewController.m
//  DaBangVR
//
//  Created by mac on 2019/5/27.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "StoreDetailsPagingViewController.h"
#import "JXCategoryView.h"
#import "TestListBaseView2.h"
#import "StoreDetailsTableView.h"
#import "GoodsShowTableViewController.h"
#import "DeptDetailsModel.h"
#import "DeptDetailsGoodsCategoryModel.h"
#import "StoreDetailsBottomView.h"
#import "StoreDetailsShoppingCarList.h"
#import "StoreDetailsOrderSureViewController.h"

@interface StoreDetailsPagingViewController ()<JXCategoryViewDelegate, JXPagerMainTableViewGestureDelegate, StoreDetailsBottomViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray <NSString *> *titles;

@property (nonatomic, strong) StoreDetailsBottomView *bottomView;
/** 接收回传数据 */
@property (nonatomic, copy) NSArray  *data;
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) DeptDetailsModel *deptModel;
@end

@implementation StoreDetailsPagingViewController

#pragma mark —— 懒加载

-(StoreDetailsBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[[NSBundle mainBundle] loadNibNamed:@"StoreDetailsBottomView" owner:nil options:nil] firstObject];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _titles = @[@"外卖",@"评价",@"详情"];
    _storeDetailsTopView = [[[NSBundle mainBundle] loadNibNamed:@"StoreDetailsTopView" owner:nil options:nil] firstObject];
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, kFit(JXheightForHeaderInSection))];
    self.categoryView.titles          = self.titles;
    self.categoryView.delegate        = self;
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.titleColorGradientEnabled = YES;
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators          = @[lineView];
    lineView.indicatorLineViewColor       = KLightGreen;
    
    self.pagerView = [self preferredPagingView];
    self.pagerView.mainTableView.gestureDelegate = self;
    [self.view addSubview:self.pagerView];
    
    self.categoryView.contentScrollView = self.pagerView.listContainerView.collectionView;
    
    [self loadingData];
}

-(void)loadingData{
    kWeakSelf(self);
    [NetWorkHelper POST:URl_getDeptGoodsList parameters:@{@"deptId":_deptId} success:^(id  _Nonnull responseObject) {
        NSDictionary *data    = KJSONSerialization(responseObject)[@"data"];
        weakself.deptModel = [DeptDetailsModel mj_objectWithKeyValues:data[@"deptVo"]];
        weakself.storeDetailsTopView.deptDetailsModel = weakself.deptModel;
        weakself.bottomView.deptModel = weakself.deptModel;
    } failure:nil];
}

//view将出现
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [kAppWindow addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(kTabBarHeight);
    }];
}

//view已经出现
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

//view将消失
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    [self.bottomView removeFromSuperview];
}

//view重新布局
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.pagerView.frame = self.view.bounds;
}

- (JXPagerView *)preferredPagingView {
    return [[JXPagerView alloc] initWithDelegate:self];
}

#pragma mark - JXPagerViewDelegate
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.storeDetailsTopView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return kFit(JXTableHeaderViewHeight - JXheightForHeaderInSection + kTopHeight);
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return kFit(JXheightForHeaderInSection);
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    //和categoryView的item数量一致
    return self.titles.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index{
    StoreDetailsTableView *tableView = [[StoreDetailsTableView alloc] initWithFrame:self.view.bounds];
    kWeakSelf(self);
    tableView.shoppingCarInfo = ^(NSArray * _Nonnull dataSource, NSInteger count) {
        weakself.data = dataSource;
        //选择的商品给底部view进行展示
        NSArray *goodsData = [StoreDetailsShoppingCarModel mj_objectArrayWithKeyValuesArray:dataSource];
        self.bottomView.goodsData = goodsData;
        self.bottomView.count = count;
    };
    
    tableView.animationBlock = ^(CABasicAnimation * _Nonnull animation) {
        [self.bottomView.imgView.layer addAnimation:animation forKey:nil];
    };
    
    tableView.deptId = self.deptId;
    
    return tableView;
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickedItemContentScrollViewTransitionToIndex:(NSInteger)index {
    
    [self.pagerView.listContainerView.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

#pragma mark - JXPagerMainTableViewGestureDelegate

- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //禁止categoryView左右滑动的时候，上下和左右都可以滚动
    if (otherGestureRecognizer == self.categoryView.collectionView.panGestureRecognizer) {
        return NO;
    }
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

#pragma mark —— StoreDetailsBottomViewDelegate
-(void)shoppingCarButtonClick:(UIButton *)button{
    StoreDetailsShoppingCarList *shoppingCarView = [[StoreDetailsShoppingCarList alloc] initWithFrame:(CGRect){0, 0, KScreenW, KScreenH}];
    if (_data) {
        NSArray *data = [StoreDetailsShoppingCarModel mj_objectArrayWithKeyValuesArray:_data];
        shoppingCarView.data = data;
    }
    [shoppingCarView showInView:self.navigationController.view];
}

-(void)totalPriceButtonClick:(UIButton *)button{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.data options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{
                                 @"goodsList":jsonString,
                                 @"deptId"   :_deptId
                                 };
    kWeakSelf(self);
    [NetWorkHelper POST:URl_confirmGoods2Delivery parameters:parameters success:^(id  _Nonnull responseObject) {
        StoreDetailsOrderSureViewController *vc = [[StoreDetailsOrderSureViewController alloc] init];
        [weakself.navigationController pushViewController:vc animated:NO];
    } failure:nil];
}

@end
