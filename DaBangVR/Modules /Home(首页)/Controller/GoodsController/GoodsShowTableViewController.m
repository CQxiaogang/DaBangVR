//
//  LoadDataListContainerListViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/12/19.
//  Copyright © 2018 jiaxin. All rights reserved.
//

#import "GoodsShowTableViewController.h"
#import "GoodsShowTableViewCell.h"

@interface GoodsShowTableViewController ()
// 数据源
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) BOOL isDataLoaded;
// 储存当前所以商品的 id，用来商品详情页面请求
@property (nonatomic, strong) NSMutableArray *IDs;
@end

@implementation GoodsShowTableViewController

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsShowTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headerRefresh];
    }];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    [self.tableView.mj_header beginRefreshing];
}

- (void)headerRefresh {
    kWeakSelf(self);
    [self.dataSource removeAllObjects];
    NSDictionary *dic = @{
                          @"categoryId":weakself.index,
                          @"page"      :@"1",
                          @"limit"     :@"10"
                          };
    [NetWorkHelper POST:URL_getGoodsList parameters:dic success:^(id  _Nonnull responseObject) {
        NSDictionary *data= KJSONSerialization(responseObject)[@"data"];
        NSArray *goodsList = data[@"goodsList"];
        self.dataSource = [GoodsShowListModel mj_objectArrayWithKeyValuesArray:goodsList];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        DLog(@"error%@",error);
    }];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsShowListModel *model = self.dataSource[indexPath.row];
    NSString *ID = [NSString stringWithFormat:@"%ld",(long)model.id];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectGoodsShowDetails:)]) {
        [self.delegate didSelectGoodsShowDetails:ID];
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
