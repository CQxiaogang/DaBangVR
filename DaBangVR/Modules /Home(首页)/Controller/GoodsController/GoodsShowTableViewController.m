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
//    //实际开发，建议使用MJRefresh
//    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
//    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"loading..." attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
//    [refreshControl addTarget:self action:@selector(headerRefresh) forControlEvents:UIControlEventValueChanged];
//    self.refreshControl = refreshControl;
//
//    [self.tableView reloadData];
//
//    //因为列表延迟加载了，所以在初始化的时候加载数据即可
//    [self loadDataForFirst];
}

- (void)loadDataForFirst {
    //第一次才加载，后续触发的不处理
    if (!self.isDataLoaded) {
        //为什么要手动设置contentoffset：https://stackoverflow.com/questions/14718850/uirefreshcontrol-beginrefreshing-not-working-when-uitableviewcontroller-is-ins
        [self.tableView setContentOffset:CGPointMake(0, -self.refreshControl.bounds.size.height) animated:YES];
        [self headerRefresh];
        self.isDataLoaded = YES;
    }
}

- (void)headerRefresh {
    kWeakSelf(self);
    [self.dataSource removeAllObjects];
    NSDictionary *dic = @{
                          @"categoryId":weakself.index,
                          @"page"      :@"1",
                          @"limit"     :@"10",
                          @"token"     :kToken
                          };
    [NetWorkHelper POST:URL_getGoodsList parameters:dic success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic= dic[@"data"];
        NSArray *goodsList = dataDic[@"goodsList"];
        for (NSDictionary *dic in goodsList) {
            GoodsShowListModel *model = [GoodsShowListModel modelWithDictionary:dic];
            [self.dataSource addObject:model];
        }
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
