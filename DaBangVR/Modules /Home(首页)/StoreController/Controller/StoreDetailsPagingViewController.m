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

@interface StoreDetailsPagingViewController ()<JXCategoryViewDelegate, JXPagerMainTableViewGestureDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray <NSString *> *titles;

@property (nonatomic, strong) StoreDetailsBottomView *bottomView;


@end

@implementation StoreDetailsPagingViewController

#pragma mark —— 懒加载

-(StoreDetailsBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[[NSBundle mainBundle] loadNibNamed:@"StoreDetailsBottomView" owner:nil options:nil] firstObject];
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
    
    [self.view addSubview:self.bottomView];
}

-(void)loadingData{
    [NetWorkHelper POST:URl_getDeptGoodsList parameters:@{@"deptId":@"1"} success:^(id  _Nonnull responseObject) {
        NSDictionary *data   = KJSONSerialization(responseObject)[@"data"];
        NSDictionary *deptVo = data[@"deptVo"];
        DeptDetailsModel *deptDetailsModel = [DeptDetailsModel mj_objectWithKeyValues:deptVo];
        self.storeDetailsTopView.deptDetailsModel = deptDetailsModel;
        
        NSArray *list = [DeptDetailsGoodsCategoryModel mj_objectArrayWithKeyValuesArray:data[@"deliveryGoodsTypeVos"]];
        
    } failure:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (JXPagerView *)preferredPagingView {
    return [[JXPagerView alloc] initWithDelegate:self];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.pagerView.frame = self.view.bounds;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(kTabBarHeight);
    }];
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
    tableView.deptId = @"180";
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

@end
