//
//  SpellGroupTableViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "SpellGroupTableViewController.h"
// Cell
#import "SpellGroupCell.h"
#import "MySpellGroupCell.h"
// Models
#import "GoodsShowListModel.h"
#import "OrderDeptGoodsModel.h"

@interface SpellGroupTableViewController ()

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, copy) NSArray <OrderDeptGoodsModel *> *goodsData;
@end

@implementation SpellGroupTableViewController
static NSString *CellID = @"CellID";
#pragma mark —— 懒加载
- (NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray new];
    }
    return _data;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([_currentView isEqualToString:@"leftView"]) {
        [self.tableView registerNib:[UINib nibWithNibName:@"SpellGroupCell" bundle:nil] forCellReuseIdentifier:CellID];
    }else if ([_currentView isEqualToString:@"centerView"]){
        
    }else if ([_currentView isEqualToString:@"rightView"]){
        [self.tableView registerNib:[UINib nibWithNibName:@"MySpellGroupCell" bundle:nil] forCellReuseIdentifier:CellID];
    }
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadNewData{
    //判断有没有数据,有数据就删除
    if (self.data) {
        [self.data removeAllObjects];
    }
    if (self.index) {
        NSDictionary *dic = @{
                              @"categoryId":self.index//商品类型
                              };
        [NetWorkHelper POST:URL_getGroupGoodsList parameters:dic success:^(id  _Nonnull responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dataDic= dic[@"data"];
            NSArray *goodsList = dataDic[@"goodsList"];
            for (NSDictionary *dic in goodsList) {
                SpellGroupModel *model = [SpellGroupModel modelWithDictionary:dic];
                [self.data addObject:model];
            }
            [self.tableView reloadData];
        } failure:nil];
    }else{
        
        kWeakSelf(self);
        NSDictionary *dic = @{@"buyType"   :kBuyTypeGroup};
        [NetWorkHelper POST:URl_getOrderList parameters:dic success:^(id  _Nonnull responseObject) {
            NSDictionary *dataDic= KJSONSerialization(responseObject)[@"data"];
            weakself.goodsData = [OrderDeptGoodsModel mj_objectArrayWithKeyValuesArray:dataDic[@"orderList"]];
            [self.tableView reloadData];
        } failure:^(NSError * _Nonnull error) {}];
    }
    // 结束刷新
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (!self.index) {
        return _goodsData.count;
    }
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.index) {
        return self.data.count;
    }
    return self.goodsData[section].orderGoodslist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *baseCell;
    if ([_currentView isEqualToString:@"leftView"]) {
        SpellGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
        cell.model = self.data[indexPath.row];
        baseCell = cell;
    }else if ([_currentView isEqualToString:@"rightView"]){
        MySpellGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
        cell.model = _goodsData[indexPath.section].orderGoodslist[indexPath.row];
        baseCell = cell;
    }
    
    return baseCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_currentView isEqualToString:@"leftView"]) {
        return kFit(242);
    }else if ([_currentView isEqualToString:@"rightView"]){
        return 130;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_currentView isEqualToString:@"leftView"]) {
        if (self.aDelegate && [self.aDelegate respondsToSelector:@selector(didSelectGoodsShowDetails:)]) {
            SpellGroupModel *model = self.data[indexPath.row];
            [self.aDelegate didSelectGoodsShowDetails:model.id];
        }
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


@end
