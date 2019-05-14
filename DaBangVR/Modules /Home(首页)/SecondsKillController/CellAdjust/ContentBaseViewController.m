//
//  BaseViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/9.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "ContentBaseViewController.h"
#import "ListViewController.h"
#import "NestViewController.h"
#import "NaviSegmentedControlViewController.h"

@interface ContentBaseViewController () <JXCategoryViewDelegate, JXCategoryListContainerViewDelegate, ListViewControllerDelegate>
{
    BOOL noIsFrist;
}
@end

@implementation ContentBaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _shouldHandleScreenEdgeGesture = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.defaultSelectedIndex = [[self getCurrentTimes] integerValue];
    [self.view addSubview:self.categoryView];

    self.listContainerView.didAppearPercent = 0.01; //滚动一点就触发加载
    [self.view addSubview:self.listContainerView];
    self.categoryView.contentScrollView = self.listContainerView.scrollView;

    if (self.isNeedIndicatorPositionChangeItem) {
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"指示器位置切换" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClicked)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

-(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"HH"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    return currentTimeString;
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    if (![self isKindOfClass:[NaviSegmentedControlViewController class]]) {
        self.categoryView.frame = CGRectMake(0, kTopHeight+kSecondsKillShufflingViewHight, KScreenW, [self preferredCategoryViewHeight]);
    }
    self.listContainerView.frame = CGRectMake(0, [self preferredCategoryViewHeight] + kTopHeight+kSecondsKillShufflingViewHight, KScreenW, KScreenH-kTopHeight-kSecondsKillShufflingViewHight-kTabBarHeight-self.categoryView.mj_h);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    //处于第一个item的时候，才允许屏幕边缘手势返回
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    //离开页面的时候，需要恢复屏幕边缘手势，不能影响其他页面
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryBaseView alloc] init];
}

- (CGFloat)preferredCategoryViewHeight {
    return kPreferredCategoryViewHeight;
}

- (id<JXCategoryListContentViewDelegate>)preferredListAtIndex:(NSInteger)index {
    ListViewController *listView = [[ListViewController alloc] init];
    listView.aDelegate = self;
    if (noIsFrist) {
        listView.timeIndex = index;
    }else{
        listView.timeIndex = [[self getCurrentTimes] integerValue];
        noIsFrist = YES;
    }
    return listView;
}

- (JXCategoryBaseView *)categoryView {
    if (_categoryView == nil) {
        _categoryView = [self preferredCategoryView];
    }
    return _categoryView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (_listContainerView == nil) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithDelegate:self];
    }
    return _listContainerView;
}

- (void)rightItemClicked {
    JXCategoryIndicatorView *componentView = (JXCategoryIndicatorView *)self.categoryView;
    for (JXCategoryIndicatorComponentView *view in componentView.indicators) {
        if (view.componentPosition == JXCategoryComponentPosition_Top) {
            view.componentPosition = JXCategoryComponentPosition_Bottom;
        }else {
            view.componentPosition = JXCategoryComponentPosition_Top;
        }
    }
    [componentView reloadData];
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    //侧滑手势处理
    if (_shouldHandleScreenEdgeGesture) {
        self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    }
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}

#pragma mark - JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    id<JXCategoryListContentViewDelegate> list = [self preferredListAtIndex:index];
    return list;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

#pragma mark —— ListViewController 代理
-(void)didSelectRowAtIndexPath:(NSString *)index{
    [self didSelectRowAtIndexPath:index];
}

@end
