//
//  SearchGoodsViewController.m
//  DaBangVR
//
//  Created by mac on 2019/3/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "SearchGoodsViewController.h"
#import "GoodsShowTableViewCell.h"
#import "GoodsShowListModel.h"
#import "GoodsDetailsViewController.h"

@interface SearchGoodsViewController (){
    int page;
    BOOL isNull;
}

// 数据源
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation SearchGoodsViewController

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
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(kTopHeight);
    }];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsShowListModel *model = self.dataSource[indexPath.row];
    GoodsDetailsViewController *vc = [[GoodsDetailsViewController alloc] init];
    vc.index = [NSString stringWithFormat:@"%ld",(long)model.id];
    [self.navigationController pushViewController:vc animated:NO];
}

@end
