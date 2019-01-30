//
//  informationModificationViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019 DaBangVR. All rights reserved.
//
// controller
#import "ModifyAddressViewController.h"
#import "UserGoodsAdressViewController.h"
// views
#import "AddUserAdressView.h"
#import "UserAdressCell.h"
// Models
#import "UserInfoChangeModel.h"

@interface UserGoodsAdressViewController ()<AddUserAdressViewDelegate, UserAdressCellDelegate>

@property (nonatomic, strong) AddUserAdressView *headerView;

@property (nonatomic, strong) NSMutableArray *userData;

@end

@implementation UserGoodsAdressViewController

static NSString *const CellID = @"CellID";

#pragma mark —— 懒加载

- (AddUserAdressView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"AddUserAdressView" owner:nil options:nil] firstObject];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (NSMutableArray *)userData{
    if (!_userData) {
        _userData = [[NSMutableArray alloc] init];
    }
    return _userData;
}

#pragma mark —— 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址";
    [self data];
}

- (void)data{
    [NetWorkHelper POST:URl_addressList parameters:@{@"token" :kToken} success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *data = dic[@"data"];
        NSArray *receivingAddressVoList = data[@"receivingAddressVoList"];
        self.userData = [UserInfoChangeModel mj_objectArrayWithKeyValuesArray:receivingAddressVoList];
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)setupUI{
    [super setupUI];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"UserAdressCell" bundle:nil] forCellReuseIdentifier:CellID];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kTopHeight);
        make.left.right.bottom.equalTo(@(0));
    }];
}

#pragma mark —— tableView delegate/dataSource;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.delegate = self;
    if (cell == nil) {
        cell = [[UserAdressCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    cell.model = self.userData[indexPath.row];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(170);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *data = self.userData[indexPath.row];
    self.ClickAdressBlock(data);
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark —— 新增地址 Delegate
-(void)addNewAddress{
    ModifyAddressViewController *modifiAddressVC = [[ModifyAddressViewController alloc] init];
    [self.navigationController pushViewController:modifiAddressVC animated:NO];
}

#pragma mark —— UserInfoChangeCell 协议
-(void)changeAdress{
    ModifyAddressViewController *vc = [[ModifyAddressViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}

-(void)deleteAdress{
    [self AlertWithTitle:@"确定删除" message:@"" andOthers:@[@"取消",@"确认"] animated:YES action:^(NSInteger index) {
        if (index == 0) {
            [NetWorkHelper POST:URl_addressDelete parameters:nil success:nil failure:nil];
        }
    }];
}

@end
