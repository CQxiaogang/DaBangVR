//
//  BuyNowViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

// Contrillers
#import "BuyNowViewController.h"
#import "InformationModificationViewController.h"
// Views
#import "DBDetailHeaderView.h"
#import "DBDetailContentCell.h"
#import "DBDetailFooterView.h"

@interface BuyNowViewController ()
<
 UITableViewDelegate,
 UITableViewDataSource,
 DBDetailHeaderViewDelegate
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DBDetailHeaderView *headerView;
@property (nonatomic, strong) DBDetailFooterView *footerView;

@end

@implementation BuyNowViewController
static NSString *const DBDetailViewCellID = @"DBDetailViewCell";
#pragma mark —— 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"DBDetailContentCell" bundle:nil] forCellReuseIdentifier:DBDetailViewCellID];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

-(DBDetailHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"DBDetailHeaderView" owner:nil options:nil]firstObject];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (DBDetailFooterView *)footerView{
    if (!_footerView) {
        _footerView = [[DBDetailFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.mj_w, 120) style:UITableViewStylePlain];
    }
    return _footerView;
}

#pragma mark —— 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单确认";
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kTopHeight);
        make.left.right.bottom.equalTo(@(0));
    }];
    // 底部视图
    [self setUpFooderView];
}

#pragma mark —— tableView 代理，数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    DBDetailContentCell *cell = [tableView dequeueReusableCellWithIdentifier:DBDetailViewCellID];
    
    if (cell == nil) {
        cell = [[DBDetailContentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:DBDetailViewCellID];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

#pragma mark —— DBDetailHeaderView delegate
// 地址修改
- (void)informationModification{
    InformationModificationViewController *informationModificationVC = [[InformationModificationViewController alloc] init];
    [self.navigationController pushViewController:informationModificationVC animated:NO];
}

// 底部视图
- (void)setUpFooderView{
    UIButton *submitOrdersBtn = [[UIButton alloc] init];
    [submitOrdersBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    submitOrdersBtn.titleLabel.adaptiveFontSize = 16;
    [submitOrdersBtn setTintColor:KWhiteColor];
    submitOrdersBtn.backgroundColor = KRedColor;
    [self.view addSubview:submitOrdersBtn];
    [submitOrdersBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(-10);
        make.size.equalTo(CGSizeMake(80, 40));
    }];
    
    UILabel *thePrice = [[UILabel alloc] init];
    thePrice.adaptiveFontSize = 14;
    thePrice.textColor = KRedColor;
    NSString *string = @"115";
    thePrice.text = [NSString stringWithFormat:@"￥%@ 元",string];
    thePrice.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:thePrice];
    [thePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(submitOrdersBtn.mas_left).offset(0);
        make.bottom.equalTo(-10);
        make.size.equalTo(CGSizeMake(80, 40));
    }];
}

@end
