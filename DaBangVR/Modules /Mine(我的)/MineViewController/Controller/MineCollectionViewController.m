//
//  MineCollectionViewController.m
//  DaBangVR
//
//  Created by mac on 2019/2/12.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "MineCollectionViewController.h"
// Cells
#import "MineCollectionTableViewCell.h"
// Models
#import "MineCollectionModel.h"

@interface MineCollectionViewController ()

@property (nonatomic, strong) NSArray <NSString *> *titles;

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation MineCollectionViewController

static NSString *CellID = @"CellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏";
    kWeakSelf(self);
    [NetWorkHelper POST:URl_getGoodsCollectList parameters:nil success:^(id  _Nonnull responseObject) {
        NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
        NSDictionary *goodsCollectVoList = data[@"goodsCollectVoList"];
        weakself.dataSource = [MineCollectionModel mj_objectArrayWithKeyValuesArray:goodsCollectVoList];
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)setupUI{
    [super setupUI];
    [self.tableView registerNib:[UINib nibWithNibName:@"MineCollectionTableViewCell" bundle:nil] forCellReuseIdentifier:CellID];
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, .5)];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(kTopHeight);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.model = _dataSource[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(91);
}

@end
