//
//  MyOrderViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/8.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

// controllers
#import "MyOrderViewController.h"
#import "EvaluationViewController.h" // 评价
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
    CGFloat categoryVHeight                     = kFit(40);
    self.categoryView                           = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, kTopHeight, KScreenW, categoryVHeight)];
    self.categoryView.titles                    = @[@"全部", @"待付款",@"待发货", @"待收货", @"待评价", @"退款/售后"];
    self.categoryView.defaultSelectedIndex      = 0;
    self.categoryView.delegate                  = self;
    self.categoryView.titleSelectedColor        = KLightGreen;
    self.categoryView.titleColor                = KGrayColor;
    self.categoryView.titleFont                 = [UIFont systemFontOfSize:kFit(14)];
    self.categoryView.titleColorGradientEnabled = YES;
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators          = @[lineView];
    lineView.indicatorLineViewColor       = KLightGreen;
    [self.view addSubview:self.categoryView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithDelegate:self];
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
    NSArray *number  = @[@"" ,@"0", @"201", @"300", @"301", @"400"];
    myOrderVC.index = number[index];
    return myOrderVC;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 6;
}

#pragma mark —— MyOrderTableViewController 代理
-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath OrderDeptGoodsModel:(nonnull OrderDeptGoodsModel *)model{
    NSInteger state = [model.orderState integerValue];
    switch (state) {
        case 0: // 待付款
        {
            OrderSureViewController *vc = [[OrderSureViewController alloc] init];
            vc.orderID      = model.id;
            vc.submitType   = kBuy;
            vc.orderSnTotal = kOrderSn;
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case 201: //待发货
        {
            OrderProcessingViewController2 *vc = [[OrderProcessingViewController2 alloc] init];
            vc.orderId = model.id;
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case 300: //已发货
        {
            // 订单物流界面
            OrderProcessingViewController2 *vc = [[OrderProcessingViewController2 alloc] init];
            vc.orderId = model.id;
            [self.navigationController pushViewController:vc animated:NO];
        }
            break;
        case 301:
        {
            EvaluationViewController *vc = [[EvaluationViewController alloc] init];
            vc.model = model.orderGoodslist[indexPath.row];
            [self.navigationController pushViewController:vc animated:NO];
        }
           break;
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
