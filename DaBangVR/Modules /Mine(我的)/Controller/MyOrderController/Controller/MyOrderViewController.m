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
#import "OrderDeliveryViewController.h"
#import "MyOrderTableViewController.h"
// views
// 第三方
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"

@interface MyOrderViewController ()< JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView         *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@end

@implementation MyOrderViewController

#pragma mark —— 懒加载

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
}

- (void)setupUI{
    [super setupUI];
    
    CGFloat categoryVHeight = kFit(40);
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, kTopHeight, KScreenW, categoryVHeight)];
    self.categoryView.titles = @[@"全部", @"待付款", @"待收货", @"待评价", @"退款/售后"];
    self.categoryView.defaultSelectedIndex = 0;
    self.categoryView.delegate = self;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithParentVC:self delegate:self];
    self.listContainerView.frame = CGRectMake(0, categoryVHeight + kTopHeight, KScreenW, KScreenH - categoryVHeight - kTopHeight - kNavBarHeight);
    self.listContainerView.defaultSelectedIndex = 0;
    self.listContainerView.tag = 0;
    [self.view addSubview:self.listContainerView];
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
}

#pragma mark —— allOrderTableView Delegate
// 右下角按钮的点击事件
-(void)allOrderTableViewButtonOfAction:(NSString *)string{
    if ([string isEqualToString:@"确认收货"]) {
        DLog(@"确认收货");
    }else if ([string isEqualToString:@"立即付款"]){
        DLog(@"立即付款");
    }else if ([string isEqualToString:@"删除订单"]){
        DLog(@"删除订单");
    }else if ([string isEqualToString:@"去评价"]){
        DLog(@"去评价");
        [self pushEvaluationVC];
    }
}
// 评价界面
- (void) pushEvaluationVC{
    EvaluationViewController *vc = [[EvaluationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}
// cell 的点击事件
- (void)didSelectRowAtIndexPath{
    OrderDeliveryViewController *vc = [[OrderDeliveryViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
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
    MyOrderTableViewController *myOrderVC = [[MyOrderTableViewController alloc] init];
    myOrderVC.index = @"0";
    return myOrderVC;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 5;
}

@end
