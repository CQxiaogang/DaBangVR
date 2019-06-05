//
//  BuyNowViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

// Contrillers
#import "OrderSureViewController.h"
#import "UserGoodsAdressViewController.h"
#import "LeaveMessageViewController.h"
#import "PaymentSuccessViewController.h"
// Views
#import "OrderSureTopView.h"
#import "OrderSureHeaderView.h"
#import "OrderSureTableViewCell.h"
#import "OrderSureFooterView.h"
// Models
#import "OrderSureModel.h"
#import "OrderDeptGoodsModel.h"
#import "SureCustomActionSheet.h"
#import "WXApi.h"
#import "PaymentManager.h"

@interface OrderSureViewController ()
<
 UITableViewDelegate,
 UITableViewDataSource,
 OrderSureTopViewDelegate,
 OrderSureFooterViewDelegate    
>

@property (nonatomic, strong) UITableView         *tableView;
@property (nonatomic, strong) OrderSureTopView    *topView;

@property (nonatomic, strong) NSMutableArray *dataSource;
//@property (nonatomic, strong) NSMutableArray <OrderDeptGoodsModel *> *deptModels;
@property (nonatomic, strong) NSMutableArray <OrderGoodsModel *>     *goodsModels;
@property (nonatomic, strong) OrderSureModel *model;
// 订单号
@property (nonatomic, copy) NSString *orderSn;

@end

@implementation OrderSureViewController
static NSString *const DBDetailViewCellID = @"DBDetailViewCell";
static NSString *const HeaderID = @"HeaderID";
static NSString *const FooterID = @"FooterID";
static NSString *leaveMessage;
#pragma mark —— 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"OrderSureTableViewCell" bundle:nil] forCellReuseIdentifier:DBDetailViewCellID];
        [_tableView registerNib:[UINib nibWithNibName:@"OrderSureHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:HeaderID];
        [_tableView registerNib:[UINib nibWithNibName:@"OrderSureFooterView" bundle:nil] forHeaderFooterViewReuseIdentifier:FooterID];
        
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
        _topView.model = _model.receivingAddress;
        _topView.delegate = self;
    }
    return _topView;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

//-(NSMutableArray<OrderDeptGoodsModel *> *)deptModels{
//    if (!_deptModels) {
//        _deptModels = [[NSMutableArray alloc] init];
//    }
//    return _deptModels;
//}

- (NSMutableArray<OrderGoodsModel *> *)goodsModels{
    if (_goodsModels) {
        _goodsModels = [[NSMutableArray alloc] init];
    }
    return _goodsModels;
}

#pragma mark —— 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单确认";
    [self loadingData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(successPay:) name:@"successPay" object:nil];
    
    _submitType   = _submitType?_submitType:@"buy";
    _orderSnTotal = _orderSnTotal?_orderSnTotal:kOrderSnTotal;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

//视图即将消失、被覆盖或是隐藏时调用
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
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
    
    UIButton *submitOrdersBtn = [[UIButton alloc] init];
    [submitOrdersBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    submitOrdersBtn.titleLabel.adaptiveFontSize = 16;
    [submitOrdersBtn setTintColor:KWhiteColor];
    submitOrdersBtn.backgroundColor = KRedColor;
    [submitOrdersBtn addTarget:self action:@selector(submitOrdersBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitOrdersBtn];
    //总价格
    UILabel *thePrice = [[UILabel alloc] init];
    thePrice.adaptiveFontSize = 14;
    thePrice.textColor = RGBCOLOR(247, 26, 31);
    thePrice.text = [NSString stringWithFormat:@"￥%.2f 元",[_model.orderTotalPrice floatValue]];
    thePrice.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:thePrice];
    //合计标签
    UILabel *totalLabel         = [[UILabel alloc] init];
    totalLabel.text             = @"合计:";
    totalLabel.textColor        = RGBCOLOR(78, 79, 79);
    totalLabel.textAlignment      = NSTextAlignmentRight;
    totalLabel.adaptiveFontSize = 10;
    [self.view addSubview:totalLabel];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.topView.mas_bottom).offset(0);
        make.left.right.equalTo(@(0));
        make.bottom.equalTo(submitOrdersBtn.mas_top).offset(0);
    }];
    
    [submitOrdersBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(-10);
        make.size.equalTo(CGSizeMake(77, 35));
    }];
    
    [thePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(submitOrdersBtn.mas_left).offset(5);
        make.bottom.equalTo(-10);
        make.size.equalTo(CGSizeMake(80, 40));
    }];
    
    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(thePrice.mas_left).equalTo(0);
        make.centerY.equalTo(thePrice.mas_centerY);
        make.height.equalTo(40);
    }];
}
// 加载数据
-(void)loadingData{
    kWeakSelf(self);
    NSDictionary *parameters;
    if (_orderID) {
        parameters = @{@"orderId":_orderID};
    }
    [NetWorkHelper POST:URl_getConfirmGoods parameters:parameters success:^(id  _Nonnull responseObject) {
        NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
        // 字典转模型
        weakself.model = [OrderSureModel mj_objectWithKeyValues:data];
        // 得到数据,创建UI
        [self creatUI];
    } failure:^(NSError * _Nonnull error) {
    }];
}

#pragma mark —— tableView 代理，数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _model.deptGoodsList.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.deptGoodsList[section].goodsList.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    OrderSureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DBDetailViewCellID];
    
    if (cell == nil) {
        cell = [[OrderSureTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:DBDetailViewCellID];
    }
    cell.model = _model.deptGoodsList[indexPath.section].goodsList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //头部店面信息
    OrderSureHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderID];
    headerView.model = _model.deptGoodsList[section];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kFit(30);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    OrderSureFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FooterID];
    footer.delegate = self;
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kFit(190);
}

#pragma mark —— DBDetailHeaderView delegate
// 地址修改
- (void)informationModification{
    UserGoodsAdressViewController *vc = [[UserGoodsAdressViewController alloc] init];
    kWeakSelf(self);
    vc.ClickAdressBlock = ^(id  _Nonnull data) {
        weakself.topView.model = data;
    };
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark —— orderSureFooter 协议
-(void)leaveMessageBtnClickAction:(UIButton *)sender{
//    LeaveMessageViewController *vc = [[LeaveMessageViewController alloc] init];
//    vc.textViewBlock = ^(NSString * _Nonnull string) {
//        if (string.length != 0) {
//            sender.titleLabel.text = string;
//        }
//        leaveMessage = string;
//    };
//    [self.navigationController pushViewController:vc animated:NO];
}

-(void)textViewString:(NSString *)string{
    leaveMessage = string;
}

#pragma mark —— 提交订单
- (void)submitOrdersBtnAction{
    kWeakSelf(self);
    //orderID == nil 第一次支付,orderID != nil 重新支付
    if (_orderID) {
        //订单重新支付
        [NetWorkHelper POST:URl_prepayOrderAgain parameters:@{@"orderId":_orderID} success:^(id  _Nonnull responseObject) {
            NSString *error = [NSString stringWithFormat:@"%@",KJSONSerialization(responseObject)[@"errno"]];
            if ([error isEqualToString:@"1"]) {
                NSString *errmsg = KJSONSerialization(responseObject)[@"errmsg"];
                [SVProgressHUD showInfoWithStatus:errmsg];
                [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                [SVProgressHUD dismissWithDelay:1.0];
            }else{
                [self orderSn:weakself.orderID];
            }
        } failure:nil];
    }else{
        //确认支付，调用后台
        leaveMessage = leaveMessage? leaveMessage:@"";
        if (weakself.model.receivingAddress.id.length != 0 && _submitType.length != 0) {
            NSDictionary *parameters = @{
                                         @"submitType"   : _submitType,
                                         @"addressId"    : weakself.model.receivingAddress.id,
                                         @"leaveMessage" : leaveMessage
                                         };
            [NetWorkHelper POST:URl_submitOrder parameters:parameters success:^(id  _Nonnull responseObject) {
                NSString *error = [NSString stringWithFormat:@"%@",KJSONSerialization(responseObject)[@"errno"]];
                if ([error isEqualToString:@"1"]) {
                    NSString *errmsg = KJSONSerialization(responseObject)[@"errmsg"];
                    [SVProgressHUD showInfoWithStatus:errmsg];
                    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
                    [SVProgressHUD dismissWithDelay:1.0];
                }else{
                    NSDictionary *orderVo = KJSONSerialization(responseObject)[@"orderVo"];
                    NSString *orderSn = orderVo[weakself.orderSnTotal];
                    if (orderSn.length != 0) {
                        weakself.orderSn = orderSn;
                        [weakself orderSn:orderSn];
                    }
                }
            } failure:^(NSError * _Nonnull error) {}];
        }
    }
}

- (void)orderSn:(NSString *)orderSn{
    NSArray *optionsArr = @[@"微信", @"支付宝"];
    NSArray *imgArr = @[@"p-WeChat", @"p-Alipay"];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW - 20, 40)];
    headView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, KScreenW - 20, 30)];
    titleLabel.text = @"支付方式";
    titleLabel.adaptiveFontSize = 15.0;
    titleLabel.textColor = [UIColor colorWithRed:73/255.0 green:75/255.0 blue:90/255.0 alpha:1];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:titleLabel];
    
    SureCustomActionSheet *optionsView = [[SureCustomActionSheet alloc]initWithTitleView:headView optionsArr:optionsArr imgArr:imgArr cancelTitle:@"退出" selectedBlock:^(NSInteger index) {
        kWeakSelf(self);
        if (index == 0) {
            //orderID == nil 第一次支付,orderID != nil 重新支付
            if (weakself.orderID) {
                [[PaymentManager sharedPaymentManager] weiXinPayWithOrderID:weakself.orderID];
            }else{
                [[PaymentManager sharedPaymentManager] weiXinPayWithOrderSn:orderSn andPayOrderSnType:weakself.orderSnTotal];
            }
        }else{}
    } cancelBlock:^{}];
    
    [self.navigationController.view addSubview:optionsView];
}

// 付款成功跳转
- (void)successPay:(NSNotification *)notification{
    NSString *errCode = notification.object;// 支付成功或失败
    NSDictionary *dic = @{
                          @"orderSn"  : _orderSn,
                          @"payState" : errCode,
                          @"payOrderSnType":_orderSnTotal
                          };
    [NetWorkHelper POST:URl_notifyApp parameters:dic success:nil failure:nil];
    // 支付成功才跳转
    if ([errCode isEqualToString:@"0"]) {
        PaymentSuccessViewController *vc = [[PaymentSuccessViewController alloc] init];
        [self.navigationController pushViewController:vc animated:NO];
    }
    
}

@end
