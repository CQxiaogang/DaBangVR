//
//  MyOrderTableViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/29.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "MyOrderTableViewController.h"
//Cells
#import "AllOrdersCell.h"
#import "OrderSureHeaderView.h"
// Models
#import "MyOrderModel.h"
#import "MyOrderDeptModel.h"

@interface MyOrderTableViewController ()

@property (nonatomic, strong) NSMutableArray <MyOrderDeptModel *> *deptData;
@property (nonatomic, strong) NSMutableArray <MyOrderModel *> *orderData;

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
-(NSMutableArray<MyOrderModel *> *)orderData{
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
    NSDictionary *dic = @{
                          @"orderState":self.index,
                          @"page"      :@"1",
                          @"limit"     :@"10"
                          };
    [NetWorkHelper POST:URl_getOrderList parameters:dic success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic= dic[@"data"];
        NSArray *goodsList = dataDic[@"orderList"];
        self.deptData = [MyOrderDeptModel mj_objectArrayWithKeyValuesArray:goodsList];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        DLog(@"error%@",error);
    }];
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
    
    if (cell == nil) {
        cell = [[AllOrdersCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    cell.model = self.deptData[indexPath.section].orderGoodslist[indexPath.row];
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

@end
