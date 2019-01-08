//
//  modifyAddressViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "modifyAddressViewController.h"
// views
#import "modifyAddressViewCell.h"

@interface modifyAddressViewController ()
<
 UITableViewDelegate,
 UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *array;

@end

@implementation modifyAddressViewController
static NSString *const CellID = @"CellID";
#pragma mark —— 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"modifyAddressViewCell" bundle:nil] forCellReuseIdentifier:CellID];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑地址";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kTopHeight);
        make.left.right.equalTo(@(0));
        make.bottom.equalTo(-kTabBarHeight);
    }];
    [self setUpTableViewofFooterView];
    [self setUpFooterView];
    
    self.array = @[@"收货人:",
                   @"联系方式:",
                   @"所在地区:",
                   @"选择街道:",
                   @"详细地址",];
    
}

// 设置 tableView 的尾部视图
- (void)setUpTableViewofFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 50)];
    footerView.layer.masksToBounds = YES;
    footerView.layer.borderWidth = 1;
    footerView.layer.borderColor = [[UIColor lightGreen] CGColor];
    self.tableView.tableFooterView = footerView;
    
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.text = @"设为默认地址";
    leftLabel.textColor = KFontColor;
    leftLabel.font = [UIFont systemFontOfSize:14];
    [footerView addSubview:leftLabel];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(14);
        make.top.equalTo(5);
        make.size.equalTo(CGSizeMake(100, 40));
    }];
    
    UISwitch *rightSwitch = [[UISwitch alloc] init];
    rightSwitch.onTintColor = [UIColor lightGreen];
    [footerView addSubview:rightSwitch];
    [rightSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.top.equalTo(10);
        make.size.equalTo(CGSizeMake(50, 40));
    }];
    
}

- (void)setUpFooterView{
    UIButton *sureBtn = [[UIButton alloc] init];
    [sureBtn setTitle:@"保存" forState:UIControlStateNormal];
    sureBtn.titleLabel.textColor = KWhiteColor;
    sureBtn.backgroundColor = [UIColor lightGreen];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [sureBtn addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(kTabBarHeight);
    }];
}

- (void)saveInfo{
    DLog(@"保存");
}
#pragma mark —— tableView delegate/dataSource;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    modifyAddressViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    if (cell == nil) {
        cell = [[modifyAddressViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    cell.titleLabel = self.array[indexPath.row];
    return cell;
}
@end
