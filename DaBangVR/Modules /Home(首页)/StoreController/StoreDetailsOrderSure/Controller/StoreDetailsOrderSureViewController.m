//
//  StoreDetailsOrderViewController.m
//  DaBangVR
//
//  Created by mac on 2019/6/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "StoreDetailsOrderSureViewController.h"
#import "StoreDetailsOrderAdressView.h"
#import "StoreDetailsOrderAdressView2.h"

static NSString *cellID = @"cellID";

@interface StoreDetailsOrderSureViewController ()

@property (nonatomic, strong) StoreDetailsOrderAdressView  *adressView;
@property (nonatomic, strong) StoreDetailsOrderAdressView2 *adressView2;

@end

@implementation StoreDetailsOrderSureViewController

#pragma mark —— 懒加载
-(StoreDetailsOrderAdressView *)adressView{
    if (!_adressView) {
        _adressView = [[[NSBundle mainBundle] loadNibNamed:@"StoreDetailsOrderAdressView" owner:nil options:nil] firstObject];
    }
    return _adressView;
}

-(StoreDetailsOrderAdressView2 *)adressView2{
    if (!_adressView2) {
        _adressView2 = [[[NSBundle mainBundle] loadNibNamed:@"StoreDetailsOrderAdressView2" owner:nil options:nil] firstObject];
    }
    return _adressView2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单确认";
    //加载数据
    [self loadingData];
}

-(void)setupUI{
    [super setupUI];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.top.equalTo(kTopHeight);
        make.bottom.equalTo(-kNavBarHeight);
    }];
}

-(void)loadingData{
    kWeakSelf(self);
    [NetWorkHelper POST:URl_getConfirmGoods2Delivery parameters:nil success:^(id  _Nonnull responseObject) {
        NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
        DLog(@"");
    } failure:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2 ;
    }else if (section == 1){
        return 6;
    }else if (section == 2){
        return 4;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 定义唯一标识
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    // 通过indexPath创建cell实例 每一个cell都是单独的
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                [cell.contentView addSubview:self.adressView];
            }else{
                [cell.contentView addSubview:self.adressView2];
            }
            break;
            
        default:
            break;
    }
    
    cell.backgroundColor = KRandomColor;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                return kFit(100);
            }else{
                return kFit(45);
            }
            break;
            
        default:
            break;
    }
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return .1f;
    }
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

@end
