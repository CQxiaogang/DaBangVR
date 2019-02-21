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

@interface OrderProcessingViewController2 ()

@end

@implementation OrderProcessingViewController2
static NSString *CellID = @"CellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"海风暴";
    
    [self setupNavagationBar];
}

-(void)setupUI{
    [super setupUI];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderProcessingTableViewCell" bundle:nil] forCellReuseIdentifier:CellID];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(kTopHeight);
    }];
    
    OrderProcessingView *orderDeliveryV = [[[NSBundle mainBundle] loadNibNamed:@"OrderProcessingView" owner:nil options:nil] firstObject];
    self.tableView.tableHeaderView = orderDeliveryV;
    [orderDeliveryV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(0);
        make.height.equalTo(kFit(295));
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderProcessingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(120);
}

@end
