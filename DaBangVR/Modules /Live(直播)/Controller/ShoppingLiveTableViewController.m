//
//  ShoppingLiveTableViewController.m
//  DaBangVR
//
//  Created by mac on 2019/3/29.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "ShoppingLiveTableViewController.h"
/** Cells */
#import "ShoppingLiveTableViewCell.h"
/** 放直播 */
#import "PLPlayViewController.h"

@interface ShoppingLiveTableViewController ()

/** 购物数据源 */
@property (nonatomic, copy) NSArray *shoppngLiveData;

@end

@implementation ShoppingLiveTableViewController

static NSString * const cellID = @"cellID";

- (void)viewDidLoad {
    [super viewDidLoad];
//    //加载数据
    [self loadingData];
    //设置界面
    [self setupUI];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadingData];
    }];
    self.navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
    self.navigationController.definesPresentationContext = YES;
}

- (void)loadingData{
    kWeakSelf(self);
    /**
     *streamName标识符确定当前是什么直播
     *shopping表示购物
     */
    NSDictionary *parameters = @{@"streamName":@"shopping",
                                 @"limit"     :@"10",
                                 @"marker"    :@""
                                 };
    [NetWorkHelper POST:URl_getLiveStreamsList parameters:parameters success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = KJSONSerialization(responseObject)[@"data"];
        weakself.shoppngLiveData = [LiveModel mj_objectArrayWithKeyValuesArray:dic[@"playList"]];
        [weakself.tableView reloadData];
    } failure:nil];
    [self.tableView.mj_header endRefreshing];
}

- (void)setupUI{
    [self.tableView registerNib:[UINib nibWithNibName:@"ShoppingLiveTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _shoppngLiveData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingLiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.model = _shoppngLiveData[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(220);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveModel *model = _shoppngLiveData[indexPath.row];
    [self.MDelegate tableViewDidSelectRowAtIndexPathForModel:model];
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}
@end
