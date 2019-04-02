//
//  OCExampleViewController.m
//  JXPagerView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//
/** Controlles */
#import "PagingViewController.h"
#import "SettingViewController.h"
#import "MyOrderViewController.h"
#import "ShoppingCartViewController.h"
#import "MineCollectionViewController.h"
#import "MerchantsSettledViewController.h"
#import "SeasonAuthenticationViewController.h"
/** 第三方 */
#import "JXCategoryView.h"


@interface PagingViewController () <JXCategoryViewDelegate, JXPagerMainTableViewGestureDelegate, headerViewDelegate, TestListBaseViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray <NSString *> *titles;

@end

@implementation PagingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titles = @[@"我的", @"喜欢", @"动态", @"作品"];

    _userHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"MineHeaderView" owner:nil options:nil] firstObject];
    _userHeaderView.delegate = self;
    
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, kFit(JXheightForHeaderInSection))];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.titleColorGradientEnabled = YES;

    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];

    _pagerView = [self preferredPagingView];
    self.pagerView.mainTableView.gestureDelegate = self;
    [self.view addSubview:self.pagerView];

    self.categoryView.contentScrollView = self.pagerView.listContainerView.collectionView;
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
}

#pragma mark - JXPagerViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.userHeaderView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return kFit(JXTableHeaderViewHeight - JXheightForHeaderInSection);
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

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    if (index==0) {
        TestListBaseView *listView = [[TestListBaseView alloc] init];
        listView.delegate = self;
        listView.naviController = self.navigationController;
        listView.isNeedHeader = self.isNeedHeader;
        listView.isNeedFooter = self.isNeedFooter;
        [listView beginFirstRefresh];
        return listView;
    }else{
        TestListBaseView2 *listView = [[TestListBaseView2 alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
        return listView;
    }
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickedItemContentScrollViewTransitionToIndex:(NSInteger)index {
    //请务必实现该方法
    //因为底层触发列表加载是在代理方法：`- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath`回调里面
    //所以，如果当前有5个item，当前在第1个，用于点击了第5个。categoryView默认是通过设置contentOffset.x滚动到指定的位置，这个时候有个问题，就会触发中间2、3、4的cellForItemAtIndexPath方法。
    //如此一来就丧失了延迟加载的功能
    //所以，如果你想规避这样的情况发生，那么务必按照这里的方法处理滚动。
    [self.pagerView.listContainerView.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];

    //如果你想相邻的两个item切换时，通过有动画滚动实现。未相邻的两个item直接切换，可以用下面这段代码
    /*
    NSInteger diffIndex = labs(categoryView.selectedIndex - index);
     if (diffIndex > 1) {
         [self.pagerView.listContainerView.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
     }else {
         [self.pagerView.listContainerView.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
     }
     */
}

#pragma mark - JXPagerMainTableViewGestureDelegate

- (BOOL)mainTableViewGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //禁止categoryView左右滑动的时候，上下和左右都可以滚动
    if (otherGestureRecognizer == self.categoryView.collectionView.panGestureRecognizer) {
        return NO;
    }
    return [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]];
}

#pragma mark —— 头部视图控件 delegate
// 昵称点击事件
-(void)nickNameViewClick{
    if (!isLogin) {
        KPostNotification(KNotificationLoginStateChange, @NO);
    }
}
// 设置点击事件
-(void)setupButtonClick{
    
    SettingViewController *vc = [[SettingViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:NO];
}
// 积分商城
-(void)integralMallAction{
    DLog(@"哎呦喂");
}
// 我的订单
-(void)myOrderAction{
    MyOrderViewController *vc = [[MyOrderViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:NO];
}
// 购物车
-(void)shoppingCarAction{
    ShoppingCartViewController *vc = [[ShoppingCartViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark —— TestListBaseView 协议
-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1) {
        [self myCollection];
    }else if (indexPath.row == 2){
        [self pushMerchantsSettledViewController];
    }else if (indexPath.row == 3){
        [self pushSeasonAuthenticationViewController];
    }
}
//收藏
- (void)myCollection{
    [self pushViewController:[MineCollectionViewController new]];
}
//商家入驻
- (void)pushMerchantsSettledViewController{
    [self pushViewController:[MerchantsSettledViewController new]];
}
//主播认证
- (void)pushSeasonAuthenticationViewController{
    [self pushViewController:[SeasonAuthenticationViewController new]];
}

- (void)pushViewController:(UIViewController *)vc{
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:NO];
}

@end


