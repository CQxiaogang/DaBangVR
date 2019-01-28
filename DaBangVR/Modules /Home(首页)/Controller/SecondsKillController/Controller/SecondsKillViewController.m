//
//  SecondsKillViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "SecondsKillViewController.h"
// TableView
#import "SecondsKillTableView.h"
#import "MySecondKillTableView.h"

@interface SecondsKillViewController ()

@property (nonatomic, strong) SecondsKillTableView  *leftTableView;
@property (nonatomic, strong) MySecondKillTableView *rightTableView;

@end

@implementation SecondsKillViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"限时秒杀";
    
    
}

- (void)setupUI{
    [super setupUI];
    
    
    
    // 设置 底部切换 button
    [self creatBottomUI];
    
    [self creatLeftOfTableView];
}

- (void)setupNavagation{
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
        make.left.right.bottom.equalTo(0);
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
        make.top.bottom.equalTo(@(0));
    }];
    for (UIButton *button in btns) {
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.mj_h ,-button.imageView.mj_w, -5,0)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(-12, 0,0, -button.titleLabel.mj_w)];
    }
}

- (void)creatLeftOfTableView{
    // 设置 navagtionBar
    [self setupNavagation];
    
    _leftTableView = [[SecondsKillTableView alloc] init];
    [self.view addSubview:_leftTableView];
    [_leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.left.right.equalTo(0);
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

@end
