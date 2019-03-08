//
//  LoadDataListContainerListViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/12/19.
//  Copyright © 2018 jiaxin. All rights reserved.
//

#import "GoodsShowTableViewController.h"
#import "GoodsShowTableViewCell.h"

@interface GoodsShowTableViewController (){
    int page;
    BOOL isNull;
}
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
    page=1;
    isNull = YES;
    [self loadingData];
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsShowTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self->page = 1;
        [self.dataSource removeAllObjects];
        [self loadingData];
    }];
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadingData)];
}
- (void)loadingData {
    kWeakSelf(self);
    if (isNull) {
        NSDictionary *dic = @{
                              @"categoryId":weakself.index,
                              @"page"      :[NSString stringWithFormat:@"%d",page],
                              @"limit"     :@"10"
                              };
        [NetWorkHelper POST:URL_getGoodsList parameters:dic success:^(id  _Nonnull responseObject) {
            NSDictionary *data= KJSONSerialization(responseObject)[@"data"];
            NSArray *goodsList = data[@"goodsList"];
            NSArray *list = [GoodsShowListModel mj_objectArrayWithKeyValuesArray:goodsList];
            [self.dataSource addObjectsFromArray:list];
            [self.tableView reloadData];
            if (list.count != 0) {
                self->page++;
                self->isNull = YES;
            }
        } failure:^(NSError * _Nonnull error) {}];
    }
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.dataSource.count != 0) {
        cell.model = self.dataSource[indexPath.row];
    }
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
