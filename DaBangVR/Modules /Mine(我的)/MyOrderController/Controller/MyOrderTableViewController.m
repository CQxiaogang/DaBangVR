//
//  MyOrderTableViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/29.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "MyOrderTableViewController.h"
#import "EvaluationViewController.h"
#import "OrderProcessingViewController2.h"
//Cells
#import "AllOrdersCell.h"
#import "OrderSureHeaderView.h"
// Models
//#import "MyOrderModel.h"
//#import "MyOrderDeptModel.h"
#import "OrderDeptGoodsModel.h"
#import "OrderGoodsModel.h"

@interface MyOrderTableViewController ()<allOrdersCellDelegate>

@property (nonatomic, strong) NSMutableArray <OrderDeptGoodsModel *> *deptData;
@property (nonatomic, strong) NSMutableArray <OrderGoodsModel *> *orderData;

@end

@implementation MyOrderTableViewController
static NSString *CellID = @"CellID";
static NSString *HeaderCellID = @"HeaderCellID";
#pragma mark —— 懒加载
- (NSMutableArray *)deptData{
    if (!_deptData) {
        _deptData = [[NSMutableArray alloc] init];
    }
    return _deptData;
}
-(NSMutableArray<OrderGoodsModel *> *)orderData{
    if (!_orderData) {
        _orderData = [[NSMutableArray alloc] init];
    }
    return _orderData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"AllOrdersCell" bundle:nil] forCellReuseIdentifier:CellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderSureHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:HeaderCellID];
    self.tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData{
    [self.deptData removeAllObjects];
    NSDictionary *parameters = @{
                          @"orderState":self.index,
                          @"page"      :@"1",
                          @"limit"     :@"10"
                          };
    [NetWorkHelper POST:URl_getOrderList parameters:parameters success:^(id  _Nonnull responseObject) {
        NSDictionary *dataDic= KJSONSerialization(responseObject)[@"data"];
        NSArray *goodsList = dataDic[@"orderList"];
        self.deptData = [OrderDeptGoodsModel mj_objectArrayWithKeyValuesArray:goodsList];
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {}];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.deptData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.deptData[section].orderGoodslist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AllOrdersCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.delegate = self;
    if (cell == nil) {
        cell = [[AllOrdersCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    cell.model = self.deptData[indexPath.section].orderGoodslist[indexPath.row];
    cell.depModel = self.deptData[indexPath.section];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(140);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    OrderSureHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderCellID];
    if (self.deptData) {
      headerView.model = self.deptData[section];
    }
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kFit(30);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 1)];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.aDelegate && [self.aDelegate respondsToSelector:@selector(didSelectRowAtIndexPath:OrderDeptGoodsModel:)]) {
        [self.aDelegate didSelectRowAtIndexPath:indexPath OrderDeptGoodsModel:self.deptData[indexPath.section]];
    }
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

- (void)listDidAppear {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)listDidDisappear {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark —— allOrderTableView Delegate
// 右下角按钮的点击事件
- (void)lowerRightCornerClickEvent:(NSString *)string{
    if (self.aDelegate && [self.aDelegate respondsToSelector:@selector(lowerRightCornerClickEvent:)]) {
        [self.aDelegate lowerRightCornerClickEvent:string];
    }
}
// 评价界面
- (void) pushEvaluationVC{
    EvaluationViewController *vc = [[EvaluationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}
// cell 的点击事件
- (void)didSelectRowAtIndexPath{
    OrderProcessingViewController2 *vc = [[OrderProcessingViewController2 alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}

@end
