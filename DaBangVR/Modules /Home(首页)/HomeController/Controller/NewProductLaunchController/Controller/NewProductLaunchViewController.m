//
//  NewProductLaunchViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/29.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "NewProductLaunchViewController.h"
#import "GoodsDetailsViewController.h"
// Views
#import "NewProductLaunchCell.h"
#import "ShufflingView.h"
// Models
#import "NewGoodsModel.h"

@interface NewProductLaunchViewController ()

@property (nonatomic, copy) NSArray *goodsData;

@end

@implementation NewProductLaunchViewController
static NSString *CellID = @"CellID";

#pragma mark —— 懒加载

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新品首发";
    [self loadingData];
}

- (void)setupUI{
    [super setupUI];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewProductLaunchCell" bundle:nil] forCellReuseIdentifier:CellID];
    // tableViw 的header轮播图
    self.tableView.tableHeaderView = [[ShufflingView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.mj_w, kFit(180)) andIndex:@"1"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kTopHeight);
        make.left.right.bottom.equalTo(0);
    }];
}

-(void)loadingData{
    kWeakSelf(self);
    NSDictionary *dic = @{
                          @"page":@"1",
                          @"limit":@"5",
                          @"goodsPage":@"1",
                          @"goodsLimit":@"5",
                          @"categoryId":@"1",
                          @"type":@"0",
                          };
    [NetWorkHelper POST:URL_newGoodsList parameters:dic success:^(id  _Nonnull responseObject) {
        NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
        weakself.goodsData = [NewGoodsModel mj_objectArrayWithKeyValuesArray:data[@"GoodsCategoryList"]];
        [weakself.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _goodsData.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NewProductLaunchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[NewProductLaunchCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    if (_goodsData.count!=0) {
        cell.model = _goodsData[indexPath.row];
    }
    // block回调
    kWeakSelf(self);
    cell.cellBlock = ^(NewProductLaunchCell * _Nonnull cell, NSIndexPath * _Nonnull indexPath) {
        // 得到当前cell的indexPath.
        NSIndexPath *tableIndexPath = [self.tableView indexPathForCell:cell];
        NewGoodsModel *model = weakself.goodsData[tableIndexPath.row];
        GoodsDetailsViewController *vc = [[GoodsDetailsViewController alloc] init];
        GoodsDetailsModel *goodsModel = model.goodsVoList[indexPath.row];
        vc.index = goodsModel.id;
        [weakself.navigationController pushViewController:vc animated:NO];
    };
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //358 根据控件所组合成的长度而来
    return kFit(358);
}

@end

