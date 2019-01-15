//
//  LoadDataListBaseViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/28.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "LoadDataListBaseViewController.h"
#import "GoodsShowTableViewCell.h"

@interface LoadDataListBaseViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) BOOL isDataLoaded;
@end

@implementation LoadDataListBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataSource = [NSMutableArray array];

    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsShowTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    //实际开发，建议使用MJRefresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"loading..." attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    [refreshControl addTarget:self action:@selector(headerRefresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;

    [self.tableView reloadData];
}

- (void)headerRefresh {
    [self.refreshControl beginRefreshing];
    kWeakSelf(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.dataSource removeAllObjects];
        
        [NetWorkHelper POST:URL_goods_list parameters:@{@"categoryId":weakself.ID} success:^(id  _Nonnull responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dataDic= dic[@"data"];
            NSArray *goodsList = dataDic[@"goodsList"];
            for (NSDictionary *dic in goodsList) {
                SeafoodShowListModel *model = [SeafoodShowListModel modelWithDictionary:dic];
                [self.dataSource addObject:model];
            }
            [self.tableView reloadData];
        } failure:^(NSError * _Nonnull error) {
            DLog(@"error%@",error);
        }];
        
        [self.refreshControl endRefreshing];
    });
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
    
}

@end
