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
#import "OrderSureViewController.h"      //立即购买
#import "HBK_ShoppingCartViewController.h" //购物车
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
// 回传数据,商品的属性
@property (nonatomic, copy) NSArray *goodsAttributesArr;

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
    [NetWorkHelper POST:URL_getGoodsDetails parameters:@{@"goodsId":_index,  @"token" :curUser.openId} success:^(id  _Nonnull responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic= dic[@"data"];
        NSDictionary *goodsDetailsDic = dataDic[@"goodsDetails"];
        self.model = [GoodsDetailsModel modelWithDictionary:goodsDetailsDic];
        
        [self.tableView reloadData];
    
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
    // 三条评论
    [NetWorkHelper POST:URl_comment_list parameters:@{@"goodsId":_index, @"token" :curUser.openId} success:^(id  _Nonnull responseObject) {
        
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
    
    NSMutableArray *names  = [NSMutableArray arrayWithObjects:@"购物车", @"立即购买", nil];
    NSMutableArray *colors = [NSMutableArray arrayWithObjects:KOrangeColor, KRedColor, nil];
    
    if ([self.identifier isEqualToString:@"拼团"]) {
        [names replaceObjectAtIndex:0 withObject:@"拼  团"];
    }
    
    NSMutableArray *buyOrCarBtnArr = [NSMutableArray new];
    UIButton *buyOrCarBtn;
    for (int i = 0; i<2; i++) {
        buyOrCarBtn = [[UIButton alloc] init];
        buyOrCarBtn.tag = i;
        buyOrCarBtn.backgroundColor = colors[i];
        buyOrCarBtn.titleLabel.adaptiveFontSize = 14;
        [buyOrCarBtn setTitle:names[i] forState:UIControlStateNormal];
        [buyOrCarBtn addTarget:self action:@selector(buyNowOfCarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [buyOrCarBtnArr addObject:buyOrCarBtn];
        [bottomView addSubview:buyOrCarBtn];
    }
    [buyOrCarBtnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:180 tailSpacing:0];
    [buyOrCarBtnArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(0));
        make.height.equalTo(kTabBarHeight);
    }];
    
    NSArray *imgArr =@[@"c-collection",@"c-service"];
    NSArray *nameArr = @[@"收藏",@"客服"];
    NSMutableArray *otherBtnArr = [NSMutableArray new];
    UIButton *otherBtn;
    for (int i=0; i<nameArr.count; i++) {
        otherBtn = [[UIButton alloc] init];
        otherBtn.tag = i;
        otherBtn.titleLabel.adaptiveFontSize = 12;
        [otherBtn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [otherBtn setTitle:nameArr[i] forState:UIControlStateNormal];
        [otherBtn setTitleColor:KGrayColor forState:UIControlStateNormal];
        [otherBtn addTarget:self action:@selector(otherBtnClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:otherBtn];
        [otherBtnArr addObject:otherBtn];
    }
    [otherBtnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:220];
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
    [shareBtn.widthAnchor constraintEqualToConstant:25].active  = YES;
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

- (void)chooseAttributesOfClickAction:(UIButton *)sender{
    
    [self creatAttributesView:nil];
}

- (void)creatAttributesView:(NSString *)identifier{
    // 弹出商品规格选择 view
    GoodAttributesView *attributesView = [[GoodAttributesView alloc] initWithFrame:(CGRect){0, 0, KScreenW, KScreenH}];
    
    attributesView.model = self.model;
    
    [attributesView showInView:self.navigationController.view];
    
    // 确认 btn 数据回掉
    kWeakSelf(self);
    attributesView.goodsAttributesBlock = ^(NSArray *array) {
        weakself.goodsAttributesArr = array;
        if ([identifier isEqualToString:@"立即购买"] || identifier.length == 0) {
            [self buyNow:array];
        }else if ([identifier isEqualToString:@"购物车"]){
            [self addToShoppingCar:array];
        }
    };
}

- (void)addToShoppingCar:(NSArray *)array{
    NSDictionary *dic;
    if (array.count == 3) {
        dic = @{
                @"productId":array[0],
                @"goodsId"  :array[1],
                @"number"   :array[2],
                @"deptId"   : self.model.deptId
                };
        
    }else{
        dic = @{
                @"goodsId":array[0],
                @"number" :array[1],
                @"deptId" : self.model.deptId,
                @"token"  :curUser.openId
                };
        
    }
    
    [NetWorkHelper POST:URl_addToCar parameters:dic success:^(id  _Nonnull responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [SVProgressHUD showInfoWithStatus:dic[@"errmsg"]];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:1.0];
    } failure:^(NSError * _Nonnull error) {
        DLog(@"error is %@",error);
    }];
}

- (void)buyNow:(NSArray *)array{
    NSDictionary *dic;
    if (array.count == 3) {
        dic = @{
              @"productId":array[0],
              @"goodsId":array[1],
              @"number":array[2]
              };
    }else{
        dic = @{
                @"goodsId":array[0],
                @"number" :array[1],
                @"token"  :curUser.openId
                };
        
    }
    
    [NetWorkHelper POST:URl_confirmGoods2Buy parameters:dic success:^(id  _Nonnull responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        DLog(@"%@",dic[@"errmsg"]);
        // 直接跳转确认订单界面
        [self.navigationController pushViewController:[[OrderSureViewController alloc] init] animated:NO];
    } failure:^(NSError * _Nonnull error) {
        DLog(@"error is %@",error);
    }];
}

// 立即购买和购物车 btn
- (void)buyNowOfCarBtnAction:(UIButton *)sender{
    if (sender.tag == 1) {
        if (_goodsAttributesArr.count == 0) {
            [self creatAttributesView:@"立即购买"];
        }else{
            [self.navigationController pushViewController:[[OrderSureViewController alloc] init] animated:NO];
        }
    }else{
        [self addToShoppingCarBtnOfAction];
    }
    
}

// 加购
- (void)addToShoppingCarBtnOfAction{
    [self creatAttributesView:@"购物车"];
}

- (void)otherBtnClickAction:(UIButton *)sender{
    if (sender.tag == 0) {
        [self collectionBtnOfAction];
    }else if (sender.tag == 1){
        [self customerServiceBtnOfAction];
    }
}
// 收藏
- (void)collectionBtnOfAction{}
// 客服
- (void)customerServiceBtnOfAction{
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
    HBK_ShoppingCartViewController *vc = [[HBK_ShoppingCartViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}

@end
