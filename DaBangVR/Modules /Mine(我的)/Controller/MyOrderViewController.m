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
// views
#import "PageView.h"
#import "AllOrderTableView.h"

@interface MyOrderViewController ()<allOrderTableViewDelegate>
// 分页显示view
@property (nonatomic, strong) PageView *pageView;
// 全部订单
@property (nonatomic, strong) AllOrderTableView *orderTableView;

@end

@implementation MyOrderViewController

#pragma mark —— 懒加载
- (AllOrderTableView *)orderTableView{
    if (!_orderTableView) {
        _orderTableView = [[AllOrderTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _orderTableView.allDelegate = self;
    }
    return _orderTableView;
}
-(PageView *)pageView{
    if (!_pageView) {
        NSArray *titles = @[@"全部",@"待付款",@"待收货",@"待评价",@"退款/售后"];
        NSMutableArray *contentViews = [NSMutableArray new];

        [contentViews addObject:self.orderTableView];
        for (int i=0; i<4; i++) {
            UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
            view.backgroundColor = KRandomColor;
            [contentViews addObject:view];
        }
        
        
        _pageView = [[PageView alloc] initWithFrame:CGRectMake(0, kTopHeight, self.view.mj_w, self.view.mj_h-kTopHeight) Titles:titles ContentViews:contentViews];
    }
    return _pageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    
    [self.view addSubview:self.pageView];
   
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

@end
