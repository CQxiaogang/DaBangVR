//
//  informationModificationViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019 DaBangVR. All rights reserved.
//
// controller
#import "modifyAddressViewController.h"
#import "informationModificationViewController.h"
// views
#import "informationModificationHeaderView.h"

@interface informationModificationViewController ()
<
 UITableViewDelegate,
 UITableViewDataSource,
 informationModificationHeaderDelegate
>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) informationModificationHeaderView *headerView;

@end

@implementation informationModificationViewController
static NSString *const DBCellID = @"DBCellID";
#pragma mark —— 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"informationModificationCell" bundle:nil] forCellReuseIdentifier:DBCellID];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DBCellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:DBCellID];
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
    modifyAddressViewController *modifiAddressVC = [[modifyAddressViewController alloc] init];
    [self.navigationController pushViewController:modifiAddressVC animated:NO];
}
@end
