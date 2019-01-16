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
#import "GoodsDetailsView.h"
#import "GoodAttributesView.h"
// Models
#import "GoodsDetailsModel.h"
// Vendors
#import "FGGAutoScrollView.h" //无限轮播

static NSArray *globalArray;
@interface GoodsDetailsViewController ()<GoodsDetailsViewDelegate>
/* 通知 */
@property (weak ,nonatomic) id dcObj;
// 数据源
@property (nonatomic, strong) GoodsDetailsModel *model;
// 自动循环滚动视图
@property (nonatomic, strong) FGGAutoScrollView *bannerView;
@end

@implementation GoodsDetailsViewController
#pragma mark —— 懒加载
- (GoodsDetailsModel *)model{
    if (!_model) {
        _model = [GoodsDetailsModel new];
    }
    return _model;
}
#pragma mark —— 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // 得到数据
    [self getData];
}

- (void) getData{
    [NetWorkHelper POST:URL_goods_details parameters:@{@"goodsId":_index} success:^(id  _Nonnull responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic= dic[@"data"];
        NSDictionary *goodsDetailsDic = dataDic[@"goodsDetails"];
        self.model = [GoodsDetailsModel modelWithDictionary:goodsDetailsDic];
        
        // Model 有了数据在加载UI
        [self setupChildUI];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

-(void)setupChildUI{
    // 设置Navagation
    [self setupNavagation];
    
    GoodsDetailsView *goodsView = [[GoodsDetailsView alloc] initWithFrame:CGRectMake(0, kTopHeight, KScreenW, KScreenH-kTopHeight) andDataSourse:self.model];
    goodsView.delegate = self;
    [self.view addSubview:goodsView];
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
#pragma mark —— GoodsDetailsView 代理
-(void)allCommentsAction{
    AllCommentsViewController *commentsVC = [AllCommentsViewController new];
    [self.navigationController pushViewController:commentsVC animated:NO];
}
- (void)chooseBabyAction{
    GoodAttributesView *attributesView = [[GoodAttributesView alloc] initWithFrame:(CGRect){0, 0, KScreenW, KScreenH}];
    [attributesView showInView:self.navigationController.view];
    
    kWeakSelf(self);
        attributesView.goodsAttributesBlock = ^(NSArray *array) {
//            [weakself.goodsInfoView setUpGoodsFeature:array];
            globalArray = array;
        };
}
- (void)buyBtnAction{
   [self.navigationController pushViewController:[[BuyNowViewController alloc] init] animated:NO];
}

@end
