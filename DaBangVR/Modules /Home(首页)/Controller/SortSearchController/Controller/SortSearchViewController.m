//
//  SortSearchViewController.m
//  DaBangVR
//
//  Created by mac on 2019/2/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "SortSearchViewController.h"
#import "SortSearchCollectionViewController.h"
// Vendors
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"

@interface SortSearchViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@end

@implementation SortSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadingData];
    
}
-(void)loadingData{
    
}
- (void)setupUI{
    [super setupUI];
    
    [self setupNavagationBar];
    
    CGFloat categoryViewHeight = kFit(50);
    CGFloat width = KScreenW;
    CGFloat height = KScreenH - kNavBarHeight -categoryViewHeight;
    
    self.categoryView = [[JXCategoryTitleView alloc] init];
    self.categoryView.frame = CGRectMake(0, kTopHeight, KScreenW, categoryViewHeight);
    self.categoryView.delegate = self;
    self.categoryView.titles = @[@"全部",@"双11活动",@"拼团优惠",@"其他"];
//    self.categoryView.defaultSelectedIndex = 0;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithParentVC:self delegate:self];
    self.listContainerView.frame = CGRectMake(0, categoryViewHeight+kTopHeight, width, height);
    self.listContainerView.defaultSelectedIndex = 0;
    [self.view addSubview:self.listContainerView];
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
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
    // 搜索框右边按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn.widthAnchor constraintEqualToConstant:25].active = YES;
    [btn.heightAnchor constraintEqualToConstant:25].active = YES;
    [btn addTarget:self action:@selector(shoppingCarOfAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"c-More"] forState:UIControlStateNormal];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = btnItem;
}
// 搜索
- (void)searchOfAction{
    
}
// 更多功能
- (void)shoppingCarOfAction{
    
}

#pragma mark —— JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}

#pragma mark —— JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    SortSearchCollectionViewController *vc = [[SortSearchCollectionViewController alloc] init];
    vc.view.backgroundColor = KRandomColor;
    return vc;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 4;
}

@end
