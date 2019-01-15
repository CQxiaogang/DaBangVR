//
//  informationModificationViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019 DaBangVR. All rights reserved.
//
// controller
#import "ModifyAddressViewController.h"
#import "InformationModificationViewController.h"
// views
#import "informationModificationHeaderView.h"
#import "informationModificationCell.h"

@interface InformationModificationViewController ()
<
 informationModificationHeaderDelegate
>

@property (nonatomic, strong) informationModificationHeaderView *headerView;

@end

@implementation InformationModificationViewController

static NSString *const CellID = @"CellID";

#pragma mark —— 懒加载

- (informationModificationHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"informationModificationHeaderView" owner:nil options:nil] firstObject];
        _headerView.delegate = self;
    }
    return _headerView;
}
#pragma mark —— 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址";
}

- (void)setupUI{
    [super setupUI];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"informationModificationCell" bundle:nil] forCellReuseIdentifier:CellID];
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
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    informationModificationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (cell == nil) {
        cell = [[informationModificationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
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
    return 170;
}

#pragma mark —— 新增地址 Delegate
-(void)addNewAddress{
    ModifyAddressViewController *modifiAddressVC = [[ModifyAddressViewController alloc] init];
    [self.navigationController pushViewController:modifiAddressVC animated:NO];
}
@end
