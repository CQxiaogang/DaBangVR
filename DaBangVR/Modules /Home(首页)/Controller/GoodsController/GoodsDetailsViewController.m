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
#pragma mark —— 数据
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
// 所以评论
-(void)allCommentsAction{
    AllCommentsViewController *vc = [AllCommentsViewController new];
    [vc getData:self.model.id];
    [self.navigationController pushViewController:vc animated:NO];
}
// 选择商品
- (void)chooseBabyAction{
    
    [self creatAttributesView];
}

- (void)creatAttributesView{
    // 弹出商品规格选择 view
    GoodAttributesView *attributesView = [[GoodAttributesView alloc] initWithFrame:(CGRect){0, 0, KScreenW, KScreenH}];
    attributesView.goodsAttributesArray = self.model.goodsSpecVoList;
    attributesView.goodsImgStr = self.model.listUrl;
    attributesView.productInfoVoList = self.model.productInfoVoList;
    attributesView.remainingInventory = self.model.remainingInventory;
    attributesView.sellingPrice = self.model.sellingPrice;
    [attributesView showInView:self.navigationController.view];
    // 数据回掉
    //    kWeakSelf(self);
    attributesView.goodsAttributesBlock = ^(NSArray *array) {
        NSDictionary *dic = @{
                              @"productId":array[0],
                              @"goodsId":array[1],
                              @"number":array[2]
                              };
        [NetWorkHelper POST:@"http://192.168.1.110:8080/api/buygoods/confirmGoods?" parameters:dic success:^(id  _Nonnull responseObject) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dataDic= dic[@"data"];
            
        } failure:^(NSError * _Nonnull error) {
            DLog(@"error is %@",error);
        }];
        
    };
}

// 立即购买 button
- (void)buyBtnAction{
//    [self creatAttributesView];
    [self.navigationController pushViewController:[[BuyNowViewController alloc] init] animated:NO];
}

@end
