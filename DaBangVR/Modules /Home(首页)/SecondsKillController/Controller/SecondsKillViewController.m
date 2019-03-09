//
//  SecondsKillViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "SecondsKillViewController.h"
#import "GoodsDetailsViewController.h"
// TableView
#import "SecondsKillTableView.h"
#import "MySecondKillTableView.h"
// Views
#import "TimeChooseView.h"
#import "HomeBannerView.h"
#import "ShufflingView.h"
//Models
#import "GoodsRotationListModel.h"
#import "GoodsDetailsModel.h"

@interface SecondsKillViewController ()<SecondsKillTableViewDelegate, TimeChooseViewDelegate, ShufflingViewDelegate>
{
    
}

@property (nonatomic, strong) SecondsKillTableView  *leftTableView;
@property (nonatomic, strong) MySecondKillTableView *rightTableView;
// 轮播图
@property (nonatomic, strong) ShufflingView *shufflingView;

@end

@implementation SecondsKillViewController
#pragma mark —— 懒加载
-(SecondsKillTableView *)leftTableView{
    if (!_leftTableView) {
        // 轮播图
        _shufflingView = [[ShufflingView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, kFit(180)) andIndex:@"4"];
        _shufflingView.delegate = self;
        // 轮播图下面的时间选择 View
        TimeChooseView *timeChooseView = [[[NSBundle mainBundle] loadNibNamed:@"TimeChooseView" owner:nil options:nil] firstObject];
        timeChooseView.frame = CGRectMake(0, _shufflingView.mj_h, KScreenW, kFit(50));
        timeChooseView.delegate = self;
        // tableViewHeaderView
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, _shufflingView.mj_h+timeChooseView.mj_h)];
        [tableHeaderView addSubview:_shufflingView];
        [tableHeaderView addSubview:timeChooseView];
        _leftTableView = [[SecondsKillTableView alloc] init];
        _leftTableView.tableHeaderView = tableHeaderView;
        _leftTableView.aDelegate = self;
    }
    return _leftTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"限时秒杀";
}

- (void)setupUI{
    [super setupUI];
    // 设置 navagtionBar
    [self setupNavagationBar];
    // 底部 UI
    [self creatBottomUI];
    // 左边的 view
    [self creatLeftOfTableView];
}
- (void)setupNavagationBar{
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn.widthAnchor constraintEqualToConstant:25].active = YES;
    [shareBtn.heightAnchor constraintEqualToConstant:25].active = YES;
    [shareBtn setImage:[UIImage imageNamed:@"c_share"] forState:UIControlStateNormal];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    self.navigationItem.rightBarButtonItem = shareItem;
}

- (void)creatBottomUI{
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = KWhiteColor;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(kTabBarHeight);
    }];
    NSMutableArray *btns = [NSMutableArray new];
    NSArray *titles = @[@"正在秒杀",@"热卖排行",@"我的秒杀"];
    NSArray *images = @[@"mr-assembling",@"mr-hotSales",@"mr-myList"];
    
    UIButton *Btn;
    for (int i=0; i<3; i++) {
        Btn = [[UIButton alloc] init];
        Btn.titleLabel.adaptiveFontSize = 10;
        Btn.tag = i;
        [Btn addTarget:self action:@selector(buttonClickOfAciton:) forControlEvents:UIControlEventTouchUpInside];
        [Btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [Btn setTitle:titles[i] forState:UIControlStateNormal];
        [Btn setTitleColor:KGrayColor forState:UIControlStateNormal];
        [bottomView addSubview:Btn];
        [btns addObject:Btn];
    }
    [btns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:30 leadSpacing:30 tailSpacing:30];
    [btns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@0);
    }];
    for (UIButton *button in btns) {
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.mj_h ,-button.imageView.mj_w, -5,0)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(-12, 0,0, -button.titleLabel.mj_w)];
    }
}

- (void)creatLeftOfTableView{
    // 左边 tableView
    [self.view addSubview:self.leftTableView];
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(kTopHeight);
        make.bottom.equalTo(-kTabBarHeight);
    }];
}

- (void)creatRightOfTableView{
    self.navigationItem.rightBarButtonItem = nil;
    _rightTableView = [[MySecondKillTableView alloc] init];
    [self.view addSubview:_rightTableView];
    [_rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(kTopHeight);
        make.bottom.equalTo(-kTabBarHeight);
    }];
}

- (void)buttonClickOfAciton:(UIButton *)sender{
    if (sender.tag == 0) {
        [_rightTableView removeFromSuperview];
        self.title = @"限时秒杀";
        [self creatLeftOfTableView];
    }else if (sender.tag == 1){
        
    }else{
        [_leftTableView removeFromSuperview];
        self.title = @"我的秒杀";
        [self creatRightOfTableView];
    }
}

#pragma mark —— SecondsKillTableView 协议
-(void)curentGooodsID:(NSString *)ID{
    GoodsDetailsViewController *vc = [[GoodsDetailsViewController alloc] init];
    vc.index = ID;
    vc.submitType = @"seconds";
    vc.interfaceState = self;
    vc.orderSnTotal = @"orderTotalSn";
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark —— TimeChooseView 协议
-(void)buttonSelectAction:(UIButton *)btn{
    if (btn.tag == 10) {
        // 结束秒杀
        self.leftTableView.hoursTime = @"-1";
    }else if (btn.tag == 11){
        // 正在秒杀
        self.leftTableView.hoursTime = @"0";
    }else if (btn.tag == 12){
        // 即将秒杀
        self.leftTableView.hoursTime = @"1";
    }
}

#pragma mark —— ShufflingView 代理
-(void)imgDidSelected:(NSString *)goodsID{
    GoodsDetailsViewController *vc = [[GoodsDetailsViewController alloc] init];
    vc.index = goodsID;
    [self.navigationController pushViewController:vc animated:NO];
}

@end
