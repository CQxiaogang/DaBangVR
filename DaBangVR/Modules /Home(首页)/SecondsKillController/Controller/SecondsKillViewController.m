//
//  SecondsKillViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "SecondsKillViewController.h"
#import "GoodsDetailsViewController.h"
#import "GoodsShowTableViewController.h"
// Vendors
#import "JXCategoryTitleAttributeView.h"
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
#import "SecondsKillMenuView.h"



@interface SecondsKillViewController ()<SecondsKillTableViewDelegate, TimeChooseViewDelegate, ShufflingViewDelegate>{
}

@property (nonatomic, strong) SecondsKillTableView  *leftTableView;
@property (nonatomic, strong) MySecondKillTableView *rightTableView;
// 轮播图
@property (nonatomic, strong) ShufflingView *shufflingView;

@property (nonatomic, strong) JXCategoryTitleAttributeView *myCategoryView;
@property (nonatomic, strong) NSMutableArray <NSAttributedString *> *attributeTitles;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation SecondsKillViewController
#pragma mark —— 懒加载
-(SecondsKillTableView *)leftTableView{
    if (!_leftTableView) {
        // 轮播图
        _shufflingView = [[ShufflingView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, kSecondsKillShufflingViewHight) andIndex:@"4"];
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

#pragma mark —— 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"限时秒杀";
   
    // 轮播图
    _shufflingView = [[ShufflingView alloc] initWithFrame:CGRectMake(0, kTopHeight, KScreenW, kSecondsKillShufflingViewHight) andIndex:@"4"];
    _shufflingView.delegate = self;
    [self.view addSubview:_shufflingView];
    _attributeTitles = [NSMutableArray new];
    
    for (int i = 0; i<=23; i++) {
        NSString *string = [NSString stringWithFormat:@"%d:00\n海鲜粉",i];
        if (i < 9) {
            string = [NSString stringWithFormat:@"0%d:00\n海鲜粉",i];
        }
        NSMutableAttributedString *timeTitle = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor grayColor]}];
        [timeTitle addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 2)];
        [_attributeTitles addObject:timeTitle];
    }
    NSMutableArray *titles = [NSMutableArray array];
    for (NSMutableAttributedString *attriString in self.attributeTitles) {
        [titles addObject:attriString.string];
    }
    self.titles                         = titles;
    self.myCategoryView.attributeTitles = self.attributeTitles;
    self.myCategoryView.backgroundColor = RGBCOLOR(52, 52, 52);

    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.backgroundViewHeight               = kPreferredCategoryViewHeight;
    backgroundView.backgroundViewCornerRadius         = 0;
    backgroundView.backgroundViewColor                = KLightGreen;
    self.myCategoryView.indicators                    = @[backgroundView];
    
}
-(JXCategoryTitleAttributeView *)myCategoryView {
    return (JXCategoryTitleAttributeView *)self.categoryView;
}
-(JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleAttributeView alloc] init];
}
-(void)setupUI{
    [super setupUI];
    //设置navagtionBar
    [self setupNavagationBar];
    //底部UI
     [self creatBottomUI];
    //左边的view
    [self creatLeftOfTableView];
    
//    [self setupSecondsKillMennView];
    
}
//限时秒杀菜单
-(void)setupSecondsKillMennView{
    kWeakSelf(self);
    CGFloat secondsKillMenuVieWidth = 56;
    CGFloat secondsKillMenuVieHight = 41;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *timeArray = @[@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00",@"24:00"];
    NSArray *titleArray = @[@"即将开始",@"马上开始",@"已经开始",@"疯狂抢购中",@"马上开始",@"已经停止",@"已经停止"];
    
    SecondsKillMenuView *sec = [[SecondsKillMenuView alloc] initWithFrame:CGRectMake(0, kTopHeight + 145, SCW, secondsKillMenuVieHight)];
    [sec setMenuTimeArray:timeArray andTitleArray:titleArray andNumOfShow:5];
    
    [sec setPageContentScrollViewFrame:CGRectMake(0, 64 + secondsKillMenuVieHight, SCW, SCH)];
    [self.view addSubview:sec.pageContentScrollView];
    [self.view addSubview:sec];
    [sec.pageContentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(KScreenW);
        make.top.equalTo(sec.mas_bottom).offset(0);
        make.bottom.equalTo(weakself.bottomView.mas_top).offset(0);
    }];
    [sec.pageContentScrollView layoutIfNeeded];
    for (int i = 0; i < timeArray.count; i++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(SCW * i, 0, KScreenW, sec.pageContentScrollView.mj_h)];
        view.backgroundColor = KRandomColor;
        [sec.pageContentScrollView addSubview:view];
    }
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
    _bottomView = bottomView;
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

-(void)didSelectRowAtIndexPath:(NSString *)index{
    GoodsDetailsViewController *vc = [[GoodsDetailsViewController alloc] init];
    vc.index = index;
    vc.interfaceState = self;
    vc.orderSnTotal = kOrderSnTotal;
    vc.submitType = kSeconds;
    [self.navigationController pushViewController:vc animated:NO];
}

@end
