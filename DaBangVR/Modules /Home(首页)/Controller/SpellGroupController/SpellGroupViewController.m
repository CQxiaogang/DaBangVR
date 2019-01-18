//
//  SpellGroupViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "SpellGroupViewController.h"
#import "SpellGroupTableViewController.h"
// 第三方
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"

@interface SpellGroupViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView         *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@end

@implementation SpellGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拼团";
    [self creatUI];
}
- (void)creatUI{
    
    [self creatLeftView];
    // 底部 view
    [self creatBottomUI];
}

- (void)creatLeftView{
    if (self.categoryView && self.listContainerView) {
        [self.categoryView removeFromSuperview];
        [self.listContainerView removeFromSuperview];
    }
    CGFloat categoryVHeight = Adapt(40);
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, kTopHeight, KScreenW, categoryVHeight)];
    self.categoryView.titles = @[@"全部",@"大闸蟹",@"鲍鱼",@"帝王蟹",@"大龙虾"];
    self.categoryView.defaultSelectedIndex = 0;
    self.categoryView.delegate = self;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithParentVC:self delegate:self];
    self.listContainerView.frame = CGRectMake(0, categoryVHeight + kTopHeight, KScreenW, KScreenH - categoryVHeight - kTopHeight - kNavBarHeight);
    self.listContainerView.defaultSelectedIndex = 0;
    self.listContainerView.tag = 0;
    [self.view addSubview:self.listContainerView];
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
}

- (void)creatCenterView{
    if (self.categoryView && self.listContainerView) {
        [self.categoryView removeFromSuperview];
        [self.listContainerView removeFromSuperview];
    }
    CGFloat categoryVHeight = Adapt(40);
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, kTopHeight, KScreenW, categoryVHeight)];
    self.categoryView.titles = @[@"全部",@"大闸蟹",@"鲍鱼",@"帝王蟹",@"大龙虾"];
    self.categoryView.defaultSelectedIndex = 0;
    self.categoryView.delegate = self;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
//    [self.view addSubview:self.categoryView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithParentVC:self delegate:self];
    self.listContainerView.frame = CGRectMake(0, categoryVHeight + kTopHeight, KScreenW, KScreenH - categoryVHeight - kTopHeight - kNavBarHeight);
    self.listContainerView.defaultSelectedIndex = 0;
    self.listContainerView.tag = 1;
//    [self.view addSubview:self.listContainerView];
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
}

- (void)creatRightView{
    if (self.categoryView && self.listContainerView) {
        [self.categoryView removeFromSuperview];
        [self.listContainerView removeFromSuperview];
    }
    CGFloat categoryVHeight = Adapt(40);
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, kTopHeight, KScreenW, categoryVHeight)];
    self.categoryView.titles = @[@"全部",@"待付款",@"拼团中",@"待发货",@"待收货",@"已完成"];
    self.categoryView.defaultSelectedIndex = 0;
    self.categoryView.delegate = self;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithParentVC:self delegate:self];
    self.listContainerView.frame = CGRectMake(0, categoryVHeight + kTopHeight, KScreenW, KScreenH - categoryVHeight - kTopHeight - kNavBarHeight);
    self.listContainerView.defaultSelectedIndex = 0;
    self.listContainerView.tag = 2;
    [self.view addSubview:self.listContainerView];
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
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
    NSArray *titles = @[@"正在拼单",@"热卖排行",@"我的拼单"];
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

// 底部 button 的点击事件
- (void)buttonClickOfAciton:(UIButton *)sender{
    if (sender.tag == 0) {
        [self creatLeftView];
    }else if (sender.tag == 1){
        [self creatCenterView];
    }else{
        [self creatRightView];
    }
}

#pragma mark —— JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}

#pragma mark —— JXCategoryListContainerViewDelegate
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    SpellGroupTableViewController *spellGroupVC = [[SpellGroupTableViewController alloc] init];
    if (listContainerView.tag == 0) {
        spellGroupVC.currentView = @"leftView";
    }else if (listContainerView.tag == 1)
    {
        spellGroupVC.currentView = @"centerView";
    }else if (listContainerView.tag == 2)
    {
        spellGroupVC.currentView = @"rightView";
    }
    
    return spellGroupVC;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    if (listContainerView.tag == 0) {
        return 5;
    }else if (listContainerView.tag == 1){
        return 1;
    }else{
        return 6;
    }
}

@end
