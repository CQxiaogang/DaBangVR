//
//  DBMyViewController.m
//  DaBangVR
//
//  Created by mac on 2018/11/17.
//  Copyright © 2018 DaBangVR. All rights reserved.
//
// views
#import "MineHeaderView.h"
#import "MineTableViewCell.h"
// controllers
#import "MineViewController.h"
#import "MainTabBarController.h"
#import "SettingViewController.h"
#import "MyOrderViewController.h"
#import "HBK_ShoppingCartViewController.h"
// 第三方
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"


@interface MineViewController ()
<
headerViewDelegate
>
// 我的
@property (nonatomic, strong) UITableView *myTableView;
// talbleView每一个cell的title
@property (nonatomic, strong) NSArray *titleArray;
// tableView每一个cell的image
@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) MineHeaderView *headerView;
// 储存显示的所有视图
@property (nonatomic, strong) NSMutableArray *childV_Array;
@property (nonatomic, strong) JXCategoryTitleView  *categoryView;
@end

@implementation MineViewController

static NSString *cellID = @"cellID";
#pragma mark —— 懒加载
- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [self setup_tableView:_myTableView];
    }
    return _myTableView;
}
- (UITableView *) setup_tableView:(UITableView *)tableView{
    CGFloat tableV_Y = 0;
    CGFloat tableV_W = self.view.mj_w;
    CGFloat tableV_H = 100;
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableV_Y, tableV_W, tableV_H) style:UITableViewStyleGrouped];
    [tableView registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    tableView.delegate = self;
    tableView.dataSource = self;
    return tableView;
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"MineHeaderView" owner:nil options:nil] firstObject];
        //重新计算宽
        [_headerView setMj_w:self.view.mj_w];
        [_headerView setMj_y:20];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (NSMutableArray *)childV_Array{
    if (!_childV_Array) {
        _childV_Array = [[NSMutableArray alloc] init];
        [_childV_Array addObject:self.myTableView];
        for (int i=0; i<3; i++) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            view.backgroundColor = [UIColor randomColor];
            [_childV_Array addObject:view];
        }
    }
    return _childV_Array;
}
- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"消息",@"收藏",@"余额",@"等级",@"红包/卡包",@"实名认证",@"主播认证",@"反馈"];
    }
    return _titleArray;
}
- (NSArray *)imageArray{
    if (!_imageArray) {
        _imageArray = @[@"p_news",@"p_collections",@"p_balance",@"p_Grade",@"p_Red_envelopes",@"p_Real_name",@"p_Live_broadcast",@"p_feedback"];
    }
    return _imageArray;
}

#pragma mark 系统会调
- (void)viewDidLoad {
    [super viewDidLoad];
    // UI设置
    [self setup_UI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏navigationBar
    [self.navigationController setNavigationBarHidden:YES];
}
#pragma mark —— UI设置
-(void)setup_UI{
    
    [self.view addSubview:self.headerView];
    self.categoryView = [[JXCategoryTitleView alloc] init];
    self.categoryView.titles = @[@"我的",@"喜欢",@"动态",@"作品"];
    self.categoryView.defaultSelectedIndex = 0;
    self.categoryView.delegate = self;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
    kWeakSelf(self);
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.headerView.mas_bottom).offset(0);
        make.left.right.equalTo(0);
        make.height.equalTo(40);
    }];
}

#pragma mark tableView-delegate,dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 3;
            break;
        default:
            break;
    }
    return 0;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }

    if (indexPath.section == 0) {
        cell.titleLabel.text = self.titleArray[indexPath.row];
        cell.titleImageV.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    }else if(indexPath.section ==1){
        cell.titleLabel.text = self.titleArray[indexPath.row + 3];
        cell.titleImageV.image = [UIImage imageNamed:self.imageArray[indexPath.row + 3]];
    }else{
        cell.titleLabel.text = self.titleArray[indexPath.row + 5];
        cell.titleImageV.image = [UIImage imageNamed:self.imageArray[indexPath.row + 5]];
    }
    [cell.contentLabel removeFromSuperview];
    [cell.otherImageV removeFromSuperview];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

///设置header的高和视图,两个方法同时用才生效
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 10;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    return headerView;
}
//////////////////////////////注/////////////////////////////////

#pragma mark —— 头部视图控件 delegate
// 昵称点击事件
-(void)nickNameViewClick{
    if (!isLogin) {
        KPostNotification(KNotificationLoginStateChange, @NO);
    }
}
// 设置点击事件
-(void)setupButtonClick{
    
    SettingViewController *mySetupVC = [[SettingViewController alloc] init];
    mySetupVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mySetupVC animated:NO];
}
// 积分商城
-(void)integralMallAction{
    DLog(@"哎呦喂");
}
// 我的订单
-(void)myOrderAction{
    MyOrderViewController *VC = [[MyOrderViewController alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:NO];
}
// 购物车
-(void)shoppingCarAction{
    HBK_ShoppingCartViewController *vc = [[HBK_ShoppingCartViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:NO];
}
@end
