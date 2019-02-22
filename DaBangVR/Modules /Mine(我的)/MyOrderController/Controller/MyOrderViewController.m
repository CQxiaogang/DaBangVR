//
//  MyOrderViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/8.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

// controllers
#import "MyOrderViewController.h"
#import "EvaluationViewController.h"
#import "OrderProcessingViewController2.h"
#import "MyOrderTableViewController.h"
// views
// 第三方
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"

@interface MyOrderViewController ()< JXCategoryViewDelegate, JXCategoryListContainerViewDelegate, MyOrderTableVCDelegate>

@property (nonatomic, strong) JXCategoryTitleView         *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@end

@implementation MyOrderViewController

#pragma mark —— 懒加载

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    
    [self setupUI];
}

- (void)setupUI{
    CGFloat categoryVHeight = kFit(40);
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, kTopHeight, KScreenW, categoryVHeight)];
    self.categoryView.titles = @[@"全部", @"待付款", @"待收货", @"待评价", @"退款/售后"];
    self.categoryView.defaultSelectedIndex = 0;
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = [UIColor lightGreen];
    self.categoryView.titleColor = KGrayColor;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleFont = [UIFont systemFontOfSize:kFit(14)];
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
    lineView.indicatorLineViewColor = [UIColor lightGreen];
    [self.view addSubview:self.categoryView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithParentVC:self delegate:self];
    self.listContainerView.frame = CGRectMake(0, categoryVHeight + kTopHeight, KScreenW, KScreenH - categoryVHeight - kTopHeight);
    self.listContainerView.defaultSelectedIndex = 0;
    self.listContainerView.tag = 0;
    [self.view addSubview:self.listContainerView];
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
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
    MyOrderTableViewController *myOrderVC = [[MyOrderTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    myOrderVC.aDelegate = self;
    NSArray *number  = @[@"" ,@"0", @"201", @"301", @"401"];
    myOrderVC.index = number[index];
    return myOrderVC;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 5;
}

#pragma mark —— MyOrderVC 代理
-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderProcessingViewController2 *vc = [[OrderProcessingViewController2 alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}

@end
