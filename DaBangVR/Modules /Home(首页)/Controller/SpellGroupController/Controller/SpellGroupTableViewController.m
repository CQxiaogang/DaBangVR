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

@interface SpellGroupTableViewController ()

@property (nonatomic, strong) NSMutableArray *data;

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
    NSDictionary *dic = @{
                          @"categoryId":self.index,
                          @"page"      :@"1",
                          @"limit"     :@"10"
                          };
    [NetWorkHelper POST:URL_getGoodsList parameters:dic success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic= dic[@"data"];
        NSArray *goodsList = dataDic[@"goodsList"];
        for (NSDictionary *dic in goodsList) {
            SpellGroupModel *model = [SpellGroupModel modelWithDictionary:dic];
            [self.data addObject:model];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        DLog(@"error%@",error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if ([_currentView isEqualToString:@"leftView"]) {
        SpellGroupCell *leftCell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
        leftCell.model = self.data[indexPath.row];
        cell = leftCell;
    }else if ([_currentView isEqualToString:@"centerView"])
    {
    }else if ([_currentView isEqualToString:@"rightView"]){
        cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
        cell = (MySpellGroupCell *)cell;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_currentView isEqualToString:@"leftView"]) {
        return 218;
    }else if ([_currentView isEqualToString:@"centerView"])
    {
        
    }else if ([_currentView isEqualToString:@"rightView"]){
        return 130;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SpellGroupModel *model = self.data[indexPath.row];
    if (self.aDelegate && [self.aDelegate respondsToSelector:@selector(didSelectGoodsShowDetails:)]) {
        
        [self.aDelegate didSelectGoodsShowDetails:model.id];
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
