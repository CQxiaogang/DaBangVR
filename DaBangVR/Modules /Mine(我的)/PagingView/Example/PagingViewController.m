//
//  OCExampleViewController.m
//  JXPagingView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "PagingViewController.h"
#import "JXPagerView.h"
#import "JXCategoryView.h"
#import "PagingViewTableHeaderView.h"
#import "TestListBaseView.h"

static const CGFloat JXTableHeaderViewHeight = 250;
static const CGFloat JXheightForHeaderInSection = 50;

@interface PagingViewController () <JXPagerViewDelegate, JXCategoryViewDelegate>
@property (nonatomic, strong) JXPagerView *pagingView;
@property (nonatomic, strong) PagingViewTableHeaderView *userHeaderView;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray <TestListBaseView *> *listViewArray;
@property (nonatomic, strong) NSArray <NSString *> *titles;
@end

@implementation PagingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"个人中心";
    _titles = @[@"我的",@"喜欢",@"动态",@"作品"];

    TestListBaseView *powerListView = [[TestListBaseView alloc] init];
    powerListView.dataSource = @[@"橡胶火箭", @"橡胶火箭炮", @"橡胶机关枪", @"橡胶子弹", @"橡胶攻城炮", @"橡胶象枪", @"橡胶象枪乱打", @"橡胶灰熊铳", @"橡胶雷神象枪", @"橡胶猿王枪"].mutableCopy;

    TestListBaseView *hobbyListView = [[TestListBaseView alloc] init];
    hobbyListView.dataSource = @[@"吃烤肉", @"吃鸡腿肉", @"吃牛肉", @"各种肉"].mutableCopy;

    TestListBaseView *partnerListView = [[TestListBaseView alloc] init];
    partnerListView.dataSource = @[@"【剑士】罗罗诺亚·索隆", @"【航海士】娜美", @"【狙击手】乌索普", @"【厨师】香吉士", @"【船医】托尼托尼·乔巴", @"【船匠】 弗兰奇",@"【考古学家】妮可·罗宾"].mutableCopy;
    
    TestListBaseView *hobbyListView2 = [[TestListBaseView alloc] init];
    hobbyListView.dataSource = @[@"吃烤肉", @"吃鸡腿肉", @"吃牛肉", @"各种肉"].mutableCopy;

    _listViewArray = @[powerListView, hobbyListView, partnerListView,hobbyListView2];

    _userHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"PagingViewTableHeaderView" owner:nil options:nil] firstObject];
    _userHeaderView.frame = CGRectMake(0, kTopHeight, [UIScreen mainScreen].bounds.size.width, JXTableHeaderViewHeight);

    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, Adapt(JXheightForHeaderInSection))];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
    self.categoryView.titleColor = [UIColor blackColor];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;

    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = [UIColor colorWithRed:105/255.0 green:144/255.0 blue:239/255.0 alpha:1];
    lineView.indicatorLineWidth = 30;
    self.categoryView.indicators = @[lineView];

    _pagingView = [[JXPagerView alloc] initWithDelegate:self];
    [self.view addSubview:self.pagingView];

    self.categoryView.contentScrollView = self.pagingView.listContainerView.collectionView;

    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.pagingView.frame = self.view.bounds;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏navigationBar
    [self.navigationController setNavigationBarHidden:YES];
}
#pragma mark - JXPagingViewDelegate

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.userHeaderView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return JXTableHeaderViewHeight;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return JXheightForHeaderInSection;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}

- (NSArray<UIView<JXPagerViewListViewDelegate> *> *)listViewsInPagerView:(JXPagerView *)pagerView {
    return self.listViewArray;
}

- (void)mainTableViewDidScroll:(UIScrollView *)scrollView {
//    [self.userHeaderView scrollViewDidScroll:scrollView.contentOffset.y];
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
}

@end


