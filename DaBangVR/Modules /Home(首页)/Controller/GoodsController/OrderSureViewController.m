//
//  BuyNowViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

// Contrillers
#import "OrderSureViewController.h"
#import "UserInfoChangeViewController.h"
#import "LeaveMessageViewController.h"
// Views
#import "OrderSureTopView.h"
#import "OrderSureHeaderView.h"
#import "OrderSureTableViewCell.h"
#import "DBDetailFooterView.h"
// Models
#import "OrderSureModel.h"
#import "OrderSureDeptGoodsModel.h"

@interface OrderSureViewController ()
<
 UITableViewDelegate,
 UITableViewDataSource,
 OrderSureTopViewDelegate,
 DetailFooterViewDelegate
>

@property (nonatomic, strong) UITableView         *tableView;
@property (nonatomic, strong) OrderSureTopView    *topView;
@property (nonatomic, strong) DBDetailFooterView  *footerView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray <OrderSureDeptGoodsModel *> *deptModels;
@property (nonatomic, strong) NSMutableArray <OrderSureGoodsModel *>     *goodsModels;
@property (nonatomic, strong) OrderSureModel *model;


@end

@implementation OrderSureViewController
static NSString *const DBDetailViewCellID = @"DBDetailViewCell";
static NSString *const HeaderViewCellID = @"HeaderViewCellID";
static NSString *leaveMessage;
#pragma mark —— 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"OrderSureTableViewCell" bundle:nil] forCellReuseIdentifier:DBDetailViewCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"OrderSureHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:HeaderViewCellID];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

-(OrderSureTopView *)topView{
    if (!_topView) {
        _topView = [[[NSBundle mainBundle] loadNibNamed:@"OrderSureTopView" owner:nil options:nil]firstObject];
        _topView.model = _model;
        _topView.delegate = self;
    }
    return _topView;
}

- (DBDetailFooterView *)footerView{
    if (!_footerView) {
        _footerView = [[DBDetailFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.mj_w, 120) style:UITableViewStylePlain];
        _footerView.model = _model;
        _footerView.aDelegate = self;
    }
    return _footerView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

-(NSMutableArray<OrderSureDeptGoodsModel *> *)deptModels{
    if (!_deptModels) {
        _deptModels = [[NSMutableArray alloc] init];
    }
    return _deptModels;
}

- (NSMutableArray<OrderSureGoodsModel *> *)goodsModels{
    if (_goodsModels) {
        _goodsModels = [[NSMutableArray alloc] init];
    }
    return _goodsModels;
}

#pragma mark —— 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单确认";
    [self data];
}

- (void)creatUI{
    kWeakSelf(self);
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kTopHeight);
        make.left.right.equalTo(@(0));
        make.height.equalTo(kFit(100));
    }];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = self.footerView;
    
    UIButton *submitOrdersBtn = [[UIButton alloc] init];
    [submitOrdersBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    submitOrdersBtn.titleLabel.adaptiveFontSize = 16;
    [submitOrdersBtn setTintColor:KWhiteColor];
    submitOrdersBtn.backgroundColor = KRedColor;
    [submitOrdersBtn addTarget:self action:@selector(submitOrdersBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitOrdersBtn];
    
    UILabel *thePrice = [[UILabel alloc] init];
    thePrice.adaptiveFontSize = 14;
    thePrice.textColor = KRedColor;
    thePrice.text = [NSString stringWithFormat:@"￥%@ 元",_model.orderTotalPrice];
    thePrice.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:thePrice];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.topView.mas_bottom).offset(0);
        make.left.right.equalTo(@(0));
        make.bottom.equalTo(submitOrdersBtn.mas_top).offset(0);
    }];
    
    [submitOrdersBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(-10);
        make.size.equalTo(CGSizeMake(80, 40));
    }];
    
    [thePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(submitOrdersBtn.mas_left).offset(0);
        make.bottom.equalTo(-10);
        make.size.equalTo(CGSizeMake(80, 40));
    }];
}

- (void)data{
    kWeakSelf(self);
    [NetWorkHelper POST:URl_getConfirmGoods parameters:@{@"token" :kToken} success:^(id  _Nonnull responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *data = dic[@"data"];
        weakself.model = [OrderSureModel modelWithDictionary:data];
        weakself.deptModels = [OrderSureDeptGoodsModel mj_objectArrayWithKeyValuesArray:weakself.model.deptGoodsList];
        // 得到数据,创建UI
        [self creatUI];
    } failure:^(NSError * _Nonnull error) {
    }];
}

#pragma mark —— tableView 代理，数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _deptModels.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _deptModels[section].goodsList.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    OrderSureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DBDetailViewCellID];
    
    if (cell == nil) {
        cell = [[OrderSureTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:DBDetailViewCellID];
    }
    cell.model = _deptModels[indexPath.section].goodsList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    OrderSureHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderViewCellID];
    headerView.model = self.deptModels[section];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kFit(30);
}

#pragma mark —— DBDetailHeaderView delegate
// 地址修改
- (void)informationModification{
    UserInfoChangeViewController *informationModificationVC = [[UserInfoChangeViewController alloc] init];
    [self.navigationController pushViewController:informationModificationVC animated:NO];
}

#pragma mark —— 底部 View 协议
-(void)leaveMessageBtnClickAction{
    LeaveMessageViewController *vc = [[LeaveMessageViewController alloc] init];
    vc.textViewBlock = ^(NSString * _Nonnull string) {
        leaveMessage = string;
    };
    [self.navigationController pushViewController:vc animated:NO];
}
#pragma mark —— 提交订单
- (void)submitOrdersBtnAction{
    leaveMessage = leaveMessage? leaveMessage:@"";
    NSDictionary *dic = @{
                          @"submitType" : @"buy",
                          @"addressId" : _model.receivingAddress.id,
                          @"addressId" : leaveMessage,
                          @"token" :kToken
                          };
    [NetWorkHelper POST:URl_submitOrder parameters:dic success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        [SVProgressHUD showInfoWithStatus:dic[@"errmsg"]];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:1.0];
    } failure:^(NSError * _Nonnull error) {

    }];
}

@end
