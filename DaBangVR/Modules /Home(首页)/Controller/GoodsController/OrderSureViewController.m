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
// Views
#import "OrderSureTopView.h"
#import "OrderSureHeaderView.h"
#import "OrderSureTableViewCell.h"
#import "OrderSureFooterView.h"
// Models
#import "OrderSureModel.h"
#import "OrderSureDeptGoodsModel.h"
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
        _topView.model = _model.receivingAddress;
        _topView.delegate = self;
    }
    return _topView;
}

- (OrderSureFooterView *)footerView{
    if (!_footerView) {
        _footerView = [[OrderSureFooterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.mj_w, 120) style:UITableViewStylePlain];
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
    
    // 判断 用户是否安装微信
    //如果判断结果一直为NO,可能appid无效,这里的是无效的
    if ([WXApi isWXAppInstalled]) {
        {
            // 监听一个通知
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"ORDER_PAY_NOTIFICATION" object:nil];
        }
    }
    
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
    thePrice.text = [NSString stringWithFormat:@"￥%.f 元",[_model.orderTotalPrice floatValue]];
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

- (void)data{
    kWeakSelf(self);
    [NetWorkHelper POST:URl_getConfirmGoods parameters:nil success:^(id  _Nonnull responseObject) {
        NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
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
            [self wechatPay];
        }else{
            DLog(@"支付宝");
        }
        // 确认支付，调用后台
        leaveMessage = leaveMessage? leaveMessage:@"";
        NSDictionary *dic = @{
                              @"submitType" : @"buy",
                              @"addressId" : weakself.model.receivingAddress.id,
                              @"addressId" : leaveMessage
                              };
        [NetWorkHelper POST:URl_submitOrder parameters:dic success:^(id  _Nonnull responseObject) {
            [SVProgressHUD showInfoWithStatus:KJSONSerialization(responseObject)[@"errmsg"]];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD dismissWithDelay:1.0];
        } failure:^(NSError * _Nonnull error) {
            
        }];
    } cancelBlock:^{
        
    }];
    
    [self.navigationController.view addSubview:optionsView];
}

- (void)wechatPay{
    
    [self easyPay];
}

-(void)easyPay{
    NSDictionary *dic = @{@"orderSn"       :@"",
                          @"payOrderSnType":@""
                          };
    [NetWorkHelper POST:@"http://www.vrzbgw.com/dabang/api/payorder/prepayOrder?" parameters:dic success:^(id  _Nonnull responseObject) {
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        //配置调起微信支付所需要的参数
        
        PayReq *req  = [[PayReq alloc] init];
        req.package = @"Sign=WXPay";
        
        //调起微信支付
        if ([WXApi sendReq:req]) {
            NSLog(@"吊起成功");
        }
        
    } failure:^(NSError * _Nonnull error) {
         NSLog(@"%@",error);
    }];
}

#pragma mark - 收到支付成功的消息后作相应的处理
- (void)getOrderPayResult:(NSNotification *)notification
{
    if ([notification.object isEqualToString:@"success"]) {
        NSLog(@"支付成功");
    } else {
        NSLog(@"支付失败");
    }
    
}

@end
