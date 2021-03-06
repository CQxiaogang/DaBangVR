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
#import "UserAddressModel.h"

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
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //加载数据
    [self loadingData];
}

-(void)loadingData{
    kWeakSelf(self)
    [NetWorkHelper POST:URl_addressList parameters:nil success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *data = dic[@"data"];
        NSArray *receivingAddressVoList = data[@"receivingAddressVoList"];
        weakself.userData = [UserAddressModel mj_objectArrayWithKeyValuesArray:receivingAddressVoList];
        [weakself.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {}];
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.userData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 通过唯一标识创建cell实例
    UserAdressCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.delegate = self;
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
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
    UserAddressModel *model = self.userData[indexPath.row];
    self.ClickAdressBlock(model);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark —— 新增地址 Delegate
-(void)addNewAddress{
    ModifyAddressViewController *modifiAddressVC = [[ModifyAddressViewController alloc] init];
    [self.navigationController pushViewController:modifiAddressVC animated:NO];
}

#pragma mark —— UserInfoChangeCell 协议
-(void)changeAdressClick:(UIButton *)button{
    ModifyAddressViewController *vc = [[ModifyAddressViewController alloc] init];
    //得到当前的indexPath
    UserAdressCell *cell = (UserAdressCell *)[[button superview] superview];
    NSIndexPath *indexPath  = [self.tableView indexPathForCell:cell];
    NSInteger i = indexPath.row;
    UserInfoChangeModel *userInfoModel = self.userData[i];
    vc.adressID = userInfoModel.id;
    [self.navigationController pushViewController:vc animated:NO];
}

-(void)deleteAdress{
    [self AlertWithTitle:@"确定删除" preferredStyle:UIAlertControllerStyleAlert message:@"" andOthers:@[@"取消",@"确认"] animated:YES action:^(NSInteger index) {
        if (index == 0) {
            [NetWorkHelper POST:URl_addressDelete parameters:nil success:nil failure:nil];
        }
    }];
}

@end
