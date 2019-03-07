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

@interface OrderSureViewController ()
<
 UITableViewDelegate,
 UITableViewDataSource,
 OrderSureTopViewDelegate,
 DetailFooterViewDelegate
>

@property (nonatomic, strong) UITableView         *tableView;
@property (nonatomic, strong) OrderSureTopView    *topView;
@property (nonatomic, strong) OrderSureFooterView  *footerView;

@property (nonatomic, strong) NSMutableArray *dataSource;
//@property (nonatomic, strong) NSMutableArray <OrderDeptGoodsModel *> *deptModels;
@property (nonatomic, strong) NSMutableArray <OrderGoodsModel *>     *goodsModels;
@property (nonatomic, strong) OrderSureModel *model;
// 订单号
@property (nonatomic, copy) NSString *orderSn;

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
        _topView.model = _model.receivingAddress;
        _topView.delegate = self;
    }
    return _topView;
}

- (OrderSureFooterView *)footerView{
    if (!_footerView) {
        _footerView = [[OrderSureFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.mj_w, kFit(120)) style:UITableViewStylePlain];
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
    
    UILabel *thePrice = [[UILabel alloc] init];
    thePrice.adaptiveFontSize = 14;
    thePrice.textColor = KRedColor;
    thePrice.text = [NSString stringWithFormat:@"￥%.2f 元",[_model.orderTotalPrice floatValue]];
    thePrice.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:thePrice];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.topView.mas_bottom).offset(0);
        make.left.right.equalTo(@(0));
        make.bottom.equalTo(submitOrdersBtn.mas_top).offset(0);
    }];
    
    [submitOrdersBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(-15);
        make.size.equalTo(CGSizeMake(80, 38));
    }];
    
    [thePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(submitOrdersBtn.mas_left).offset(0);
        make.bottom.equalTo(-10);
        make.size.equalTo(CGSizeMake(80, 40));
    }];
}

-(void)loadingData{
    kWeakSelf(self);
    [NetWorkHelper POST:URl_getConfirmGoods parameters:nil success:^(id  _Nonnull responseObject) {
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
    OrderSureHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderViewCellID];
    headerView.model = _model.deptGoodsList[section];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kFit(30);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return self.footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kFit(120);
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

#pragma mark —— 底部 View 协议
-(void)leaveMessageBtnClickAction:(UIButton *)sender{
    LeaveMessageViewController *vc = [[LeaveMessageViewController alloc] init];
    vc.textViewBlock = ^(NSString * _Nonnull string) {
        if (string.length != 0) {
            sender.titleLabel.text = string;
        }
        leaveMessage = string;
    };
    [self.navigationController pushViewController:vc animated:NO];
}
#pragma mark —— 提交订单
- (void)submitOrdersBtnAction{
    kWeakSelf(self);
    // 确认支付，调用后台
    leaveMessage = leaveMessage? leaveMessage:@"无";
    if (weakself.model.receivingAddress.id.length != 0) {
        NSDictionary *dic = @{
                              @"submitType"    : _submitType,
                              @"addressId"     : weakself.model.receivingAddress.id,
                              @"leaveMessage"  : leaveMessage
                              };
        [NetWorkHelper POST:URl_submitOrder parameters:dic success:^(id  _Nonnull responseObject) {
            NSDictionary *orderVo = KJSONSerialization(responseObject)[@"orderVo"];
            NSString *orderSn = orderVo[@"orderSn"];
            weakself.orderSn = orderSn;
            [weakself orderSn:orderSn];
        } failure:^(NSError * _Nonnull error) {}];
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
        
        if (index == 0) {
            [self wechatPay:orderSn];
        }else{
            
        }
        
    } cancelBlock:^{
    }];
    
    [self.navigationController.view addSubview:optionsView];
}

- (void)wechatPay:(NSString *)orderSn{
    
    NSDictionary *dic = @{@"orderSn"       :orderSn,
                          @"payOrderSnType":@"orderSnTotal"
                          };
    [NetWorkHelper POST:URl_prepayOrder parameters:dic success:^(id  _Nonnull responseObject) {
        
        NSDictionary * dic = KJSONSerialization(responseObject)[@"data"];
        //配置调起微信支付所需要的参数
        PayReq *req   = [[PayReq alloc] init];
        req.openID    = [dic objectForKey:@"appid"];
        req.partnerId = [dic objectForKey:@"partnerid"];
        req.prepayId  = [dic objectForKey:@"prepayid"];
        req.package   = [dic objectForKey:@"package"];
        req.nonceStr  = [dic objectForKey:@"noncestr"];
        req.timeStamp = [dic[@"timestamp"] intValue];
        req.sign      = [dic objectForKey:@"sign"];
        //调起微信支付
        [WXApi sendReq:req];
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
// 付款成功跳转
- (void)successPay:(NSNotification *)notification{
    NSString *errCode = notification.object;// 支付成功或失败
    NSDictionary *dic = @{
                          @"orderSn"  : _orderSn,
                          @"payState" : errCode,
                          @"payOrderSnType":@"orderSnTotal"
                          };
    [NetWorkHelper POST:URl_notifyApp parameters:dic success:nil failure:nil];
    // 支付成功才跳转
    if ([errCode isEqualToString:@"0"]) {
        PaymentSuccessViewController *vc = [[PaymentSuccessViewController alloc] init];
        [self.navigationController pushViewController:vc animated:NO];
    }
    
}

@end
