//
//  SpellGroupViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "SpellGroupViewController.h"
#import "SpellGroupTableViewController.h"
#import "GoodsDetailsViewController.h"
// 第三方
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"
// Models
#import "SpellGroupModel.h"
#import "GoodsShowTitleModel.h"

@interface SpellGroupViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate, SpellGroupTableViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView         *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

// 标题 ID
@property (nonatomic, strong) NSMutableArray *goodsIDs;
// 标题数据
@property (nonatomic, strong) NSMutableArray *goodsNames;
@property (nonatomic, strong) SpellGroupModel *model;
@end

@implementation SpellGroupViewController

#pragma mark —— 懒加载
- (NSMutableArray *)goodsIDs{
    if (!_goodsIDs) {
        _goodsIDs = [NSMutableArray new];
    }
    return _goodsIDs;
}

- (NSMutableArray *)goodsNames{
    if (!_goodsNames) {
        _goodsNames = [NSMutableArray new];
    }
    return _goodsNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拼团";
    
    [self loadingData];
}

-(void)loadingData{
    kWeakSelf(self);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    NSDictionary *dic = @{@"parentId":@"1"};
    [NetWorkHelper POST:URL_getGoodsCategoryList parameters:dic success:^(id  _Nonnull responseObject) {
        NSDictionary *dataDic= KJSONSerialization(responseObject)[@"data"];
        NSArray *list = dataDic[@"goodsCategoryList"];
        for (NSDictionary *dic in list) {
            GoodsShowTitleModel *model = [GoodsShowTitleModel modelWithDictionary:dic];
            [weakself.goodsNames addObject:model.name];
            [weakself.goodsIDs addObject:model.id];
        }
        dispatch_group_leave(group);
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self creatUI];
    });
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
    self.categoryView.titles = self.goodsNames;
    self.categoryView.defaultSelectedIndex = 0;
    self.categoryView.delegate = self;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithParentVC:self delegate:self];
    self.listContainerView.frame = CGRectMake(0, categoryVHeight+kTopHeight, KScreenW, KScreenH - categoryVHeight - kTopHeight - kNavBarHeight);
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
    NSArray *titles = @[@"正在团购",@"热卖排行",@"我的团购"];
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
    spellGroupVC.aDelegate = self;
    switch (listContainerView.tag) {
        case 0:
            spellGroupVC.currentView = @"leftView";
            spellGroupVC.index = _goodsIDs[index];
            break;
        case 1:
            spellGroupVC.currentView = @"centerView";
            break;
        case 2:
            spellGroupVC.currentView = @"rightView";
            break;
        default:
            break;
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

#pragma mark —— 拼团类别 协议
-(void)didSelectGoodsShowDetails:(NSString *)index{
    GoodsDetailsViewController *vc = [[GoodsDetailsViewController alloc] init];
    vc.index = index;
    vc.identifier = @"拼团";
    vc.interfaceState = self;
    vc.submitType = @"group1";
    vc.orderSnTotal = kOrderSnTotal;
    [self.navigationController pushViewController:vc animated:NO];
}

@end
