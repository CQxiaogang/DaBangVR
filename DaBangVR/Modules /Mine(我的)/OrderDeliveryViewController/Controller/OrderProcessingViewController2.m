//
//  OrderDeliveryViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/10.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "OrderProcessingViewController2.h"
//Views
#import "OrderProcessingView.h"
#import "OrderProcessingTableViewCell.h"
#import "OrderProcessingHeaderView.h"
#import "OrderProcessingFooterView.h"
// Models
#import "OrderDeptGoodsModel.h"

@interface OrderProcessingViewController2 ()

@property (nonatomic, strong) OrderDeptGoodsModel *model;
/** 退款Button */
@property (nonatomic, strong) UIButton *refundBtn;

@end

@implementation OrderProcessingViewController2
static NSString *CellID = @"CellID";
static NSString *HeaderID = @"HeaderID";
static NSString *FooterID = @"FooterID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"海风暴";
    
    [self setupNavagationBar];
    
    [self loadingData];
}

-(void)setupUI{
    [super setupUI];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderProcessingTableViewCell" bundle:nil] forCellReuseIdentifier:CellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderProcessingHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:HeaderID];
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderProcessingFooterView" bundle:nil] forHeaderFooterViewReuseIdentifier:FooterID];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(kTopHeight);
        make.bottom.equalTo(kFit(-40));
    }];
    
    OrderProcessingView *orderDeliveryV = [[[NSBundle mainBundle] loadNibNamed:@"OrderProcessingView" owner:nil options:nil] firstObject];
    self.tableView.tableHeaderView = orderDeliveryV;
    [orderDeliveryV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(0);
        make.height.equalTo(kFit(244));
        make.width.equalTo(KScreenW);
    }];
    // 设置底部UI
    [self setupBottonUI];
}
-(void)setupNavagationBar{
    UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [phoneBtn.widthAnchor constraintEqualToConstant:25].active = YES;
    [phoneBtn.heightAnchor constraintEqualToConstant:25].active = YES;
    [phoneBtn setImage:[UIImage imageNamed:@"o_delivey"] forState:UIControlStateNormal];
    UIBarButtonItem *phoneItem = [[UIBarButtonItem alloc] initWithCustomView:phoneBtn];
    self.navigationItem.rightBarButtonItem = phoneItem;
}
- (void)setupBottonUI{
    // 退款
    UIButton *refundBtn         = [[UIButton alloc] init];
    _refundBtn                  = refundBtn;
    refundBtn.backgroundColor   = KRedColor;
    refundBtn.adaptiveFontSize  = 12;
    [refundBtn setTitle:@"申请退款" forState:UIControlStateNormal];
    [refundBtn addTarget:self action:@selector(refundButOfAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:refundBtn];
    [refundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(kFit(80), kFit(30)));
        make.bottom.right.equalTo(kFit(-10));
    }];
}
- (void)refundButOfAction{
    // 退款
    kWeakSelf(self);
    [self AlertWithTitle:@"确认退款" preferredStyle:UIAlertControllerStyleAlert message:@"是否确认退款" andOthers:@[@"取消",@"确定"] animated:YES action:^(NSInteger index) {
        if (index == 1) {
            [NetWorkHelper POST:URl_refundRequest parameters:@{@"orderId":weakself.orderId} success:^(id  _Nonnull responseObject) {
                [weakself.refundBtn setTitle:@"退款中" forState:UIControlStateNormal];
            } failure:nil];
        }
    }];
}
#pragma mark —— 加载数据
-(void)loadingData{
    kWeakSelf(self);
    [NetWorkHelper POST:URl_getOrderDetails parameters:@{@"orderId":_orderId} success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = KJSONSerialization(responseObject)[@"data"];
        weakself.model = [OrderDeptGoodsModel mj_objectWithKeyValues:dic[@"orderDetails"]];
        [weakself.tableView reloadData];
    } failure:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _model.orderGoodslist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderProcessingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.model = _model.orderGoodslist[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(120);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OrderProcessingHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderID];
    headerView.model = _model;
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kFit(30);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    OrderProcessingFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FooterID];
    footerView.model = _model;
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kFit(200);
}

@end
