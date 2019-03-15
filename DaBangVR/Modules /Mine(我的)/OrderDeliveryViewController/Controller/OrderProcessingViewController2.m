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
// Models
#import "OrderDeptGoodsModel.h"

@interface OrderProcessingViewController2 ()

@property (nonatomic, strong) OrderDeptGoodsModel *model;

@end

@implementation OrderProcessingViewController2
static NSString *CellID = @"CellID";
static NSString *HeaderID = @"HeaderID";

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
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(kTopHeight);
    }];
    
    OrderProcessingView *orderDeliveryV = [[[NSBundle mainBundle] loadNibNamed:@"OrderProcessingView" owner:nil options:nil] firstObject];
    self.tableView.tableHeaderView = orderDeliveryV;
    [orderDeliveryV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(0);
        make.height.equalTo(kFit(244));
        make.width.equalTo(KScreenW);
    }];
}
-(void)setupNavagationBar{
    UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [phoneBtn.widthAnchor constraintEqualToConstant:25].active = YES;
    [phoneBtn.heightAnchor constraintEqualToConstant:25].active = YES;
    [phoneBtn setImage:[UIImage imageNamed:@"o_delivey"] forState:UIControlStateNormal];
    UIBarButtonItem *phoneItem = [[UIBarButtonItem alloc] initWithCustomView:phoneBtn];
    self.navigationItem.rightBarButtonItem = phoneItem;
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderProcessingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(120);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OrderProcessingHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderID];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kFit(30);
}
@end
