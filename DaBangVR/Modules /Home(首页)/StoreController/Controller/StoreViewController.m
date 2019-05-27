//
//  StoreViewController.m
//  DaBangVR
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "StoreViewController.h"
#import "ShufflingView.h"
#import "CategoryChooseView.h"
#import "StoreGoodsTableView.h"
#import "DeptModel.h"
#import "StoreViewController.h"
#import "StoreBaseTableView.h"
#import "StoreGoodsTableViewHeaderView.h"
#import "StoreGoodsTableViewCell.h"
#import "StoreBaseTopTableViewCell.h"
#import "StoreDetailsViewController.h"

@interface StoreViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray <DeptModel*>*data;
@property (nonatomic, strong) StoreBaseTableView *baseTableView;
@property (nonatomic, strong) StoreGoodsTableViewHeaderView *titleView;
@end

@implementation StoreViewController
#pragma mark —— 懒加载

-(StoreBaseTableView *)baseTableView{
    if (!_baseTableView) {
        _baseTableView            = [[StoreBaseTableView alloc] init];
        _baseTableView.delegate   = self;
        _baseTableView.dataSource = self;
        _baseTableView.showsVerticalScrollIndicator = NO;
        [_baseTableView registerNib:[UINib nibWithNibName:@"StoreGoodsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
        [self.view addSubview:_baseTableView];
    }
    return _baseTableView;
}

#pragma mark —— 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.baseTableView.backgroundColor = KWhiteColor;

    //加载数据
    [self loadingData];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.baseTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kTopHeight);
        make.left.right.bottom.equalTo(0);
    }];
}

-(void)loadingData{
    kWeakSelf(self);
    NSDictionary *parameters = @{
                                 @"longitude":@"22",//经度
                                 @"latitude" :@"108" //纬度
                                 };
    [NetWorkHelper POST:URl_getNearbyDeptList parameters:parameters success:^(id  _Nonnull responseObject) {
        NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
        NSDictionary *deptCategory = data[@"DeptCategoryVos"];
        weakself.data = [DeptModel mj_objectArrayWithKeyValuesArray:deptCategory];
        [self.baseTableView reloadData];
    } failure:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return 300;
    }
    return 103;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.titleView = [[[NSBundle mainBundle] loadNibNamed:@"StoreGoodsTableViewHeaderView" owner:nil options:nil] firstObject];
    return self.titleView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *FSBaseTopTableViewCellIdentifier = @"FSBaseTopTableViewCellIdentifier";
    if (indexPath.section == 1) {
        StoreGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
        if (!cell) {
            cell = [[StoreGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        }
        cell.model = _data[indexPath.row];
        return cell;
    }
    if (indexPath.row == 0) {
        StoreBaseTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FSBaseTopTableViewCellIdentifier];
        if (!cell) {
            cell = [[StoreBaseTopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FSBaseTopTableViewCellIdentifier];
        }
        return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreDetailsViewController *vc = [[StoreDetailsViewController alloc] init];
    vc.title = _data[indexPath.row].name;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
