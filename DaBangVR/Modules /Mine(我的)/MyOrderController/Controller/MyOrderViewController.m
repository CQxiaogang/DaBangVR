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
#import "OrderSureViewController.h"  // 订单确认
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
    self.categoryView.titles = @[@"全部", @"待付款",@"待发货", @"待收货", @"待评价", @"退款/售后"];
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
    NSArray *number  = @[@"" ,@"0", @"201", @"300", @"301", @"401"];
    myOrderVC.index = number[index];
    return myOrderVC;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 6;
}

#pragma mark —— MyOrderTableViewController 代理
-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath orderState:(NSInteger)state{
    switch (state) {
        case 0: // 待付款
        {
            OrderSureViewController *vc = [[OrderSureViewController alloc] init];
            vc.submitType = @"buy";
            vc.orderSnTotal = @"orderSn";
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case 201: // 待发货
        
            break;
        case 300: // 已发货
        {
            // 订单物流界面
            OrderProcessingViewController2 *vc = [[OrderProcessingViewController2 alloc] init];
            [self.navigationController pushViewController:vc animated:NO];
        }
        default:
            break;
    }
    
}

-(void)lowerRightCornerClickEvent:(NSString *)string{
    if ([string isEqualToString:kOrderState_forThePayment]) {
        // 待付款
        
    }else if ([string isEqualToString:kOrderState_ToEvaluate]){
        DLog(@"去评价");
    }
}

@end
