//
//  GoodsDetailsViewController.m
//  DaBangVR
//
//  Created by mac on 2018/12/25.
//  Copyright © 2018 DaBangVR. All rights reserved.
//
// Controllers
#import "GoodsDetailsViewController.h"
#import "AllCommentsViewController.h" //查看所以评论
#import "BuyNowViewController.h"      //立即购买
// ViewS
#import "GoodsInfoView.h"  //商品详情页面
#import "GoodAttributesView.h"
// Models
// Vendors
#import "ADCarouselView.h" //无限轮播，第三方工具

static NSArray *globalArray;
@interface GoodsDetailsViewController ()
<
 goodsInfoViewDeletage
>
/* 通知 */
@property (weak ,nonatomic) id dcObj;
@property (strong ,nonatomic)GoodsInfoView      *goodsInfoView;
@property (strong ,nonatomic)GoodAttributesView *goodsAttributes;
@end

@implementation GoodsDetailsViewController
#pragma mark —— 懒加载
#pragma mark —— 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置Navagation
    [self setupNavagation];
    //设置内容
    [self setupContentUI];
    // 设置底部
    [self setupBottomUI];
}

#pragma mark —— UI设置
- (void)setupNavagation{
    
    UIButton *shoppingCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shoppingCarBtn.widthAnchor constraintEqualToConstant:25].active = YES;
    [shoppingCarBtn.heightAnchor constraintEqualToConstant:25].active = YES;
    [shoppingCarBtn setImage:[UIImage imageNamed:@"h_Cart"] forState:UIControlStateNormal];
    UIBarButtonItem *shoppingCarItem = [[UIBarButtonItem alloc] initWithCustomView:shoppingCarBtn];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn.widthAnchor constraintEqualToConstant:25].active = YES;
    [shareBtn.heightAnchor constraintEqualToConstant:25].active = YES;
    [shareBtn setImage:[UIImage imageNamed:@"c_share"] forState:UIControlStateNormal];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    
    self.navigationItem.rightBarButtonItems = @[shareItem,shoppingCarItem];
}
- (void)setupBottomUI{
    
    UIView *bottomView = [[UIView alloc] init];
//    bottomView.backgroundColor = KGrayColor;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.bottom.equalTo(0);
        make.size.equalTo(CGSizeMake(KScreenW, kTabBarHeight));
    }];
    
    UIButton *buyBtn = [[UIButton alloc] init];
    buyBtn.backgroundColor = KRedColor;
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    buyBtn.titleLabel.adaptiveFontSize = 14;
    [buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(@(0));
        make.size.equalTo(CGSizeMake(100, kTabBarHeight));
    }];
    
    NSArray *imgArr =@[@"c-collection",@"c-service",@"c-cart"];
    NSArray *nameArr = @[@"收藏",@"客服",@"加购"];
    NSMutableArray *otherBtnArr = [NSMutableArray new];
    UIButton *otherBtn;
    for (int i=0; i<3; i++) {
        otherBtn = [[UIButton alloc] init];
        [otherBtn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [otherBtn setTitle:nameArr[i] forState:UIControlStateNormal];
        otherBtn.titleLabel.adaptiveFontSize = 12;
        [otherBtn setTitleColor:KGrayColor forState:UIControlStateNormal];
//        otherBtn.backgroundColor = KRandomColor;
        [bottomView addSubview:otherBtn];
        [otherBtnArr addObject:otherBtn];
    }
    [otherBtnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:140];
    [otherBtnArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@(0));
    }];
    for (UIButton *button in otherBtnArr) {
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.mj_h ,-button.imageView.mj_w, -5,0)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(-12, 0,0, -button.titleLabel.mj_w)];
    }
}

- (void)setupContentUI{
    ADCarouselView *showImgView = [ADCarouselView carouselViewWithFrame:CGRectMake(0, kTopHeight, KScreenW, Adapt(300))];
    showImgView.loop = YES;
    showImgView.automaticallyScrollDuration = 2;
    showImgView.imgs = @[@"ad11",@"http://d.hiphotos.baidu.com/zhidao/pic/item/3b87e950352ac65c1b6a0042f9f2b21193138a97.jpg",@"ad3",@"ad4",@"ad5"];
    showImgView.placeholderImage = [UIImage imageNamed:@"zhanweifu"];
    [self.view addSubview:showImgView];
    
    _goodsInfoView = [[[NSBundle mainBundle] loadNibNamed:@"GoodsInfoView" owner:nil options:nil] firstObject];
    _goodsInfoView.delegate = self;
    [self.view addSubview:_goodsInfoView];
    [_goodsInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(showImgView.mas_bottom).offset(0);
        make.left.equalTo(@(20));
        make.right.equalTo(@(0));
    }];
}

#pragma mark —— goodsInfoView delegate
// 选择商品规格
-(void)chooseBabyAction{
    [self createAttributesView];
}

- (void)createAttributesView {
    GoodAttributesView *attributesView = [[GoodAttributesView alloc] initWithFrame:(CGRect){0, 0, KScreenW, KScreenH}];
    [attributesView showInView:self.navigationController.view];
    
    kWeakSelf(self);
    attributesView.goodsAttributesBlock = ^(NSArray *array) {
        [weakself.goodsInfoView setUpGoodsFeature:array];
        globalArray = array;
    };
}

// 查看更多评论
- (void)allCommentsAction{
    AllCommentsViewController *commentsVC = [AllCommentsViewController new];
    [self.navigationController pushViewController:commentsVC animated:NO];
}

#pragma mark —— 按钮点击事件
- (void)buyBtnAction{
//    if (globalArray.count == 0) {
//        [self createAttributesView];
//    }else{
        [self.navigationController pushViewController:[[BuyNowViewController alloc] init] animated:NO];
//    }
}

@end
