//
//  DBMySetupViewController.m
//  DaBangVR
//
//  Created by mac on 2018/12/3.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "MineTableViewCell.h"
// controllers
#import "LoginViewController.h"
#import "MainTabBarController.h"
#import "SettingViewController.h"
#import "UserGoodsAdressViewController.h"
#import "UIAlertController+TapGesAlertController.h"

static NSString *cellID = @"cellID";

@interface SettingViewController ()

@property (nonatomic, strong)NSArray            *arrayImage;
@property (nonatomic, strong)NSArray            *arrayTitle;
@property (nonatomic, strong)NSMutableArray     *arrayContent;
@property (nonatomic, strong)UIButton           *LogOutBtn;
@property (nonatomic, strong)MineTableViewCell  *cell;
@property (nonatomic, strong)UIAlertController  *alert;
@end

@implementation SettingViewController
#pragma mark —— 懒加载
-(NSArray *)arrayImage{
    if (!_arrayImage) {
        _arrayImage = @[@"S_Nickname",@"S_Gender",@"S_Permanent_residence",@"S_Cell_phone",@"S_Password",@"S_address",@"S_Eliminate",@"S_To_update",@"S_Praise",];
    }
    return _arrayImage;
}

-(NSArray *)arrayTitle{
    if (!_arrayTitle) {
        _arrayTitle = @[@"昵称",@"性别",@"常住地",@"绑定手机号",@"修改密码",@"我的地址",@"清除缓存",@"检查更新",@"给个好评",];
    }
    return _arrayTitle;
}
- (NSMutableArray *)arrayContent{
    if (!_arrayContent) {
        NSArray *arr = @[@"微微一笑",@"女",@"广西南宁",@"",@"",@"",@"5.6M",@"",@""];
        _arrayContent = [NSMutableArray arrayWithArray:arr];
    }
    return _arrayContent;
}

-(UIButton *)LogOutBtn{
    if (!_LogOutBtn) {
        _LogOutBtn = [[UIButton alloc] init];
        _LogOutBtn.backgroundColor = [UIColor lightGreen];
        [_LogOutBtn setTitle:@"退出登陆" forState:UIControlStateNormal];
        _LogOutBtn.titleLabel.adaptiveFontSize = 17;
        [_LogOutBtn addTarget:self action:@selector(LogOutAction) forControlEvents:UIControlEventTouchDown];
    }
    return _LogOutBtn;
}

#pragma mark —— 系统回掉
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
}
// 父类 UI
-(void)setupUI{
    
    [super setupUI];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.LogOutBtn];
    // 添加约束
    __weak typeof(self) weakSelf = self;
    [self.LogOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(335, 40));
        make.bottom.equalTo(-20);
        make.centerX.equalTo(weakSelf.view);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.right.equalTo(0);
        make.bottom.equalTo(weakSelf.LogOutBtn.mas_top).offset(0);
    }];
}

#pragma mark -tableView-delegate,dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 4;
            break;
        case 3:
            return 3;
            break;
        default:
            break;
    }
    return 0;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (_cell == nil) {
        _cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    if (indexPath.section == 0) {
        for (UIView *view in _cell.subviews){
            [view removeFromSuperview];
        }
        UIImageView *userImageV = [[UIImageView alloc] init];
        userImageV.layer.cornerRadius = Adapt(userImageV.mj_h/2);
        // 将多余的部分切掉
        userImageV.layer.masksToBounds = YES;
        userImageV.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:curUser.headUrl]]]?:[UIImage imageNamed:@"theDefaultAvatar"];
        [_cell addSubview:userImageV];
        [userImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(80, 80));
            make.left.equalTo(20);
            make.top.equalTo(10);
            userImageV.layer.cornerRadius = 40;
        }];
        UILabel *userName = [[UILabel alloc] init];
        userName.adaptiveFontSize = 16;
        userName.text = curUser.nickName?:@"未登录";
        [_cell addSubview:userName];
        [userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(20);
            make.left.equalTo(userImageV.mas_right).offset(10);
            make.right.equalTo(0);
            make.size.equalTo(CGSizeMake(self->_cell.mj_w, 30));
        }];
        
        UILabel *userProfile = [[UILabel alloc] init];
        userProfile.text = @"未填写简介";
        userProfile.adaptiveFontSize = 12;
        [_cell addSubview:userProfile];
        [userProfile mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(userName.mas_bottom).offset(0);
            make.left.equalTo(userImageV.mas_right).offset(10);
            make.right.equalTo(0);
            make.size.equalTo(CGSizeMake(self->_cell.mj_w, 40));
        }];
    }

    switch (indexPath.section) {
        case 1:
            _cell.titleImageV.image = [UIImage imageNamed:self.arrayImage[indexPath.row]];
            _cell.titleLabel.text = self.arrayTitle[indexPath.row];
            _cell.contentLabel.text = self.arrayContent[indexPath.row];
            break;
        case 2:
            _cell.titleImageV.image = [UIImage imageNamed:self.arrayImage[indexPath.row + 2]];
            _cell.titleLabel.text = self.arrayTitle[indexPath.row + 2];
            _cell.contentLabel.text = self.arrayContent[indexPath.row + 2];
            break;
        case 3:
            _cell.titleImageV.image = [UIImage imageNamed:self.arrayImage[indexPath.row + 6]];
            _cell.titleLabel.text = self.arrayTitle[indexPath.row + 6];
            _cell.contentLabel.text = self.arrayContent[indexPath.row + 6];
            break;
        default:
            break;
    }
    
    return _cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
        
    }else{
        
        return 5;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 100;
    }
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                // 昵称修改
                [self nicknameChange];
                break;
            case 1:
                // 性别选择
                [self sexSelection];
                break;
            default:
                break;
        }
    }else if (indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
                // 常住地
                break;
            case 1:
                // 绑定手机号
                break;
            case 2:
                // 修改密码
                break;
            case 3:
                // 我的地址
                [self myAddress];
                break;
            default:
                break;
        }
    }else if (indexPath.section == 3){
        switch (indexPath.row) {
            case 0:
                // 清除缓存
                break;
            case 1:
                // 检查更新
                break;
            case 2:
                // 更个好评
                break;
            default:
                break;
        }
    }
}
#pragma mark —— 退出登录
-(void)LogOutAction{
   
    [self AlertWithTitle:@"" message:@"确定要退出吗?" andOthers:@[@"取消",@"确定"] animated:YES action:^(NSInteger index) {
        if (index == 1) {
            
            [userManager logout:nil];
        }
    }];
}

// 昵称修改
- (void)nicknameChange{
    // 创建UIAlertController
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改昵称" message:nil preferredStyle:UIAlertControllerStyleAlert];
    // 创建取消Button
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    // 创建确定Button
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 获取修改值
        UITextField *textfield = alert.textFields.firstObject;
        if (textfield.text.length>0) {
            [self.arrayContent replaceObjectAtIndex:0 withObject:textfield.text];
            [self.tableView reloadData];
        }
    }];
    // Button添加
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    // 创建修改昵称输入框
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入修改的昵称";
    }];
    // 解决alertController弹出卡顿问题
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:^{
            // 点击空白alertController消失
            [alert tapGesAlert];
        }];
    });
}

//  性别选择
- (void)sexSelection{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    // 创建button
    [alert addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
        //选择改变值
        [self modifyTheGender:@"男"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
       [self modifyTheGender:@"女"];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"不显示" style:UIAlertActionStyleDefault  handler:^(UIAlertAction * _Nonnull action) {
        [self modifyTheGender:@""];
    }]];
    // 解决alertController弹出卡顿问题
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:^{
            // 点击空白alertController消失
            [alert tapGesAlert];
        }];
    });
}
- (void)modifyTheGender:(NSString *)sex{
    [self.arrayContent replaceObjectAtIndex:1 withObject:sex];
    [self.tableView reloadData];
}
// 我的地址
- (void)myAddress{
    UserGoodsAdressViewController *VC = [[UserGoodsAdressViewController alloc] init];
    [self.navigationController pushViewController:VC animated:NO];
}

@end
