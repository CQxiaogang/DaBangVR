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
#import "ShoppingCarViewController.h" //购物车
// ViewS
#import "GoodsDetailsView.h"
#import "GoodAttributesView.h"
#import "NewCommentCell.h"
// Models
#import "GoodsDetailsModel.h"
#import "AllCommentsModel.h"
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
// 数据源
@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong)GoodsDetailsView *goodsView;

@end

@implementation GoodsDetailsViewController
static NSString *CellID = @"CellID";
#pragma mark —— 懒加载
- (GoodsDetailsModel *)model{
    if (!_model) {
        _model = [GoodsDetailsModel new];
    }
    return _model;
}
-(NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray new];
    }
    return _data;
}
#pragma mark —— 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // 得到数据
    [self getData];
}
#pragma mark —— 数据
- (void) getData{
    // 商品详情
    [NetWorkHelper POST:URL_goods_details parameters:@{@"goodsId":_index} success:^(id  _Nonnull responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic= dic[@"data"];
        NSDictionary *goodsDetailsDic = dataDic[@"goodsDetails"];
        self.model = [GoodsDetailsModel modelWithDictionary:goodsDetailsDic];
        
        [self setupChildUI];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
    // 三条评论
    [NetWorkHelper POST:URl_comment_list parameters:@{@"goodsId":_index} success:^(id  _Nonnull responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic = dic[@"data"];
        NSArray *commentArr = dataDic[@"commentVoList"];
        for (NSDictionary *dic in commentArr) {
            AllCommentsModel *model = [AllCommentsModel modelWithDictionary:dic];
            [self.data addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

-(void)setupUI{
    [super setupUI];
}

-(void)setupChildUI{
    // 设置Navagation
    [self setupNavagation];
    // 设置头部 view
    _goodsView = [[GoodsDetailsView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, Adapt(184+250)) andDataSourse:self.model];
    _goodsView.delegate = self;
    self.tableView.tableHeaderView = _goodsView;
    
    // 设置tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"NewCommentCell" bundle:nil] forCellReuseIdentifier:CellID];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kTopHeight);
        make.left.right.equalTo(0);
        make.bottom.equalTo(-kTabBarHeight);
    }];
    
    // 底部 view
    UIView *bottomView = [[UIView alloc] init];
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
        [bottomView addSubview:otherBtn];
        [otherBtnArr addObject:otherBtn];
    }
    [otherBtnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:140];
    [otherBtnArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(0));
        make.height.equalTo(kTabBarHeight);
    }];
    for (UIButton *button in otherBtnArr) {
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.mj_h ,-button.imageView.mj_w, -5,0)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(-12, 0,0, -button.titleLabel.mj_w)];
    }
}

#pragma mark —— UI设置
- (void)setupNavagation{
    UIButton *shoppingCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shoppingCarBtn.widthAnchor constraintEqualToConstant:25].active = YES;
    [shoppingCarBtn.heightAnchor constraintEqualToConstant:25].active = YES;
    [shoppingCarBtn addTarget:self action:@selector(shoppingCarOfAction) forControlEvents:UIControlEventTouchUpInside];
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
// 选择商品规格
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
        [NetWorkHelper POST:URl_confirm_buy_goods parameters:dic success:^(id  _Nonnull responseObject) {
            
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[NewCommentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    cell.model = self.data[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 39;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return Adapt(184);
//}

#pragma mark —— 购物车
- (void)shoppingCarOfAction{
    ShoppingCarViewController *vc = [[ShoppingCarViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}

@end
