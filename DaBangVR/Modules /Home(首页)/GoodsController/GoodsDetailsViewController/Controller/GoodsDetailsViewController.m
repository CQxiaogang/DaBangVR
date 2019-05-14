//
//  GoodsDetailsViewController.m
//  DaBangVR
//
//  Created by mac on 2018/12/25.
//  Copyright © 2018 DaBangVR. All rights reserved.
//
// Controllers
#import "GoodsDetailsViewController.h"
#import "AllCommentsViewController.h"    //查看所以评论
#import "OrderSureViewController.h"      //立即购买
#import "ShoppingCartViewController.h"   //购物车
#import "SecondsKillViewController.h"    //秒杀
#import "SpellGroupViewController.h"     //拼团
#import "GoodsShowViewController.h"      //海鲜
// ViewS
#import "GoodsDetailsView.h"
#import "GoodAttributesView.h"
#import "NewCommentCell.h"
// Models
#import "GoodsDetailsModel.h"
#import "CommentsListModel.h"
// Vendors
#import "FGGAutoScrollView.h" //无限轮播

static NSArray *globalArray;
@interface GoodsDetailsViewController ()<GoodsDetailsViewDelegate, UIWebViewDelegate>{
    NSInteger _tablewVierwFooterHight;
    
    dispatch_source_t _timer;
}
/* 通知 */
@property (weak ,nonatomic) id dcObj;
// 数据源
@property (nonatomic, strong) GoodsDetailsModel *model;
// 自动循环滚动视图
@property (nonatomic, strong) FGGAutoScrollView *bannerView;
// 商品详情 view
@property (nonatomic, strong)GoodsDetailsView *goodsView;
// 回传数据,商品的属性
@property (nonatomic, copy)   NSArray      *goodsAttributesArr;
// 网页加载
@property (nonatomic, strong) UIWebView    *webView;
// 商品详情
@property (nonatomic, strong) NSDictionary *goodsDetails;
// 评论数据
@property (nonatomic, strong) NSMutableArray *commentsData;
@property (nonatomic, strong) NSArray *goodsImgsAndVideo;
@end

@implementation GoodsDetailsViewController{
    
    CGFloat webContentHeight;
}
static NSString *CellID = @"CellID";
#pragma mark —— 懒加载
-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        _webView.userInteractionEnabled = NO;
    }
    return _webView;
}
-(NSMutableArray *)commentsData{
    if (!_commentsData) {
        _commentsData = [[NSMutableArray alloc] init];
    }
    return _commentsData;
}
#pragma mark —— 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // 得到数据
    [self loadingData];
    self.tableView.backgroundColor = KWhiteColor;
}
#pragma mark —— 数据
- (void)loadingData{
    kWeakSelf(self);
    _model = [GoodsDetailsModel new];
    // 商品详情
    [NetWorkHelper POST:URL_getGoodsDetails parameters:@{@"goodsId":self.index} success:^(id  _Nonnull responseObject) {
        
        NSDictionary *dataDic= KJSONSerialization(responseObject)[@"data"];
        // 商品详情
        NSDictionary *goodsDetails = dataDic[@"goodsDetails"];
        weakself.goodsDetails = goodsDetails;
        weakself.model = [GoodsDetailsModel modelWithDictionary:goodsDetails];
        // 评论
        NSDictionary *commentVoList = dataDic[@"commentVoList"];
        self.commentsData = [CommentsListModel mj_objectArrayWithKeyValuesArray:commentVoList];
        // html加载
        [self.webView loadHTMLString:goodsDetails[@"goodsDesc"] baseURL:nil];
        [self setupOtherUI];
        
        [weakself.tableView reloadData];
    
    } failure:^(NSError * _Nonnull error) {}];
    
//    [NetWorkHelper POST:URl_getInitiateGroupUserList parameters:@{@"goodsId":self.index} success:^(id  _Nonnull responseObject) {
//        NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
//        DLog(@"");
//    } failure:nil];
}

-(void)setupUI{
    [super setupUI];
    // 设置Navagation
    [self setupNavagation];
    
    // 设置tableView
    [self.tableView registerNib:[UINib nibWithNibName:@"NewCommentCell" bundle:nil] forCellReuseIdentifier:CellID];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(kTopHeight, kFit(10), kTabBarHeight, kFit(10)));
    }];
    
    // 底部 view
    UIView *bottomView = [[UIView alloc] init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.bottom.equalTo(0);
        make.size.equalTo(CGSizeMake(KScreenW, kTabBarHeight));
    }];
    
    NSMutableArray *names  = [NSMutableArray arrayWithObjects:kShoppingCar, kNowBuy, nil];
    NSMutableArray *colors = [NSMutableArray arrayWithObjects:KOrangeColor, KRedColor, nil];
    if ([_interfaceState isKindOfClass:[SecondsKillViewController class]]) {
        // 替换字符串
        [names replaceObjectAtIndex:1 withObject:kNowSecondsBuy];
    }else if ([_interfaceState isKindOfClass:[SpellGroupViewController class]]){
        [names replaceObjectAtIndex:0 withObject:kSpellGroup];
    }
    
    NSMutableArray *buyOrCarBtnArr = [NSMutableArray new];
    UIButton *buyOrCarBtn;
    for (int i = 0; i<2; i++) {
        buyOrCarBtn                             = [[UIButton alloc] init];
        buyOrCarBtn.tag                         = i;
        buyOrCarBtn.backgroundColor             = colors[i];
        buyOrCarBtn.titleLabel.adaptiveFontSize = 14;
        [buyOrCarBtn setTitle:names[i] forState:UIControlStateNormal];
        [buyOrCarBtn addTarget:self action:@selector(goodsBuyOfActon:) forControlEvents:UIControlEventTouchUpInside];
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
    // 调整Button图片和文字的位置,上图片下文字。
    for (UIButton *button in otherBtnArr) {
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.mj_h ,-button.imageView.mj_w, -5,0)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(-12, 0,0, -button.titleLabel.mj_w)];
    }
}
#pragma mark —— 设置其他 UI
- (void)setupOtherUI{
    // 设置headerView
    _goodsView = [[GoodsDetailsView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, kFit(184+250+40)) andDataSourse:_model];
    // 进入团购和秒杀界面的时候,做倒计时操作
    if ([_interfaceState isKindOfClass:[SecondsKillViewController class]] || [_interfaceState isKindOfClass:[SpellGroupViewController class]]) {
        UILabel *label = [[UILabel alloc] init];
        label.adaptiveFontSize = 17;
        label.textColor = KRedColor;
        label.textAlignment = NSTextAlignmentCenter;
        [_goodsView.goodsInfoView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(kFit(-10));
            make.top.equalTo(kFit(50));
            make.size.equalTo(CGSizeMake(kFit(150), kFit(30)));
        }];
        /**********倒计时***********/
        NSString *endTime;
        if ([_interfaceState isKindOfClass:[SecondsKillViewController class]]) {
            endTime = self.model.secondsEndTime;
        }else if ([_interfaceState isKindOfClass:[SpellGroupViewController class]]){
            endTime = self.model.endTime;
        }
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *endDate = [dateFormatter dateFromString:[self timeWithTimeIntervalString:endTime]]; //结束时间
        NSDate *endDate_tomorrow = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([endDate timeIntervalSinceReferenceDate])];
        NSDate *startDate = [NSDate date];
        NSTimeInterval timeInterval =[endDate_tomorrow timeIntervalSinceDate:startDate];
        
        __block int timeout = timeInterval;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);//每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if (timeout<=0) {//倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    label.text = @"活动结束";
                });
            }else{
                int days = (int)(timeout/(3600*24));
                int hours = (int)((timeout-days*24*3600)/3600);
                int minutes = (int)(timeout-days*24*3600-hours*3600)/60;
                int second = timeout-days*24*3600-hours*3600-minutes*60;
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *day;      // 天
                    NSString *hour;     // 时
                    NSString *minute;   // 分
                    NSString *secondS;  // 秒
                    if (days == 0) {
                        day = @"0";
                    }else{
                        day = [NSString stringWithFormat:@"%d",days];
                    }
                    if (hours<10) {
                        hour = [NSString stringWithFormat:@"0%d",hours];
                    }else{
                        hour = [NSString stringWithFormat:@"%d",hours];
                    }
                    if (minutes<10) {
                        minute = [NSString stringWithFormat:@"0%d",minutes];
                    }else{
                        minute = [NSString stringWithFormat:@"%d",minutes];
                    }
                    if (second<10) {
                        secondS = [NSString stringWithFormat:@"0%d",second];
                    }else{
                        secondS = [NSString stringWithFormat:@"%d",second];
                    }
                    label.text = [NSString stringWithFormat:@"%@天%@时%@分%@秒",day,hour,minute,secondS];
                });
                timeout--;
            }
        });
        dispatch_resume(_timer);
    }
    _goodsView.delegate = self;
    self.tableView.tableHeaderView = _goodsView;
    // 设置footerView
    self.tableView.tableFooterView = self.webView;
}
// 时间戳转换为日期格式(毫秒的时间戳)
- (NSString *)timeWithTimeIntervalString:(NSString *)timeString{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    NSLog(@"时间 === %@",dateString);
    return dateString;
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

#pragma mark —— GoodsDetailsView（商品细节代理）
- (void)allCommentsAction{
    AllCommentsViewController *vc = [AllCommentsViewController new];
    [vc getData:self.model.id];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)chooseAttributesOfClickAction:(UIButton *)sender{
    
    [self creatAttributesView:nil];
}

- (void)creatAttributesView:(NSString *)identifier{
    // 弹出商品规格 view
    GoodAttributesView *attributesView = [[GoodAttributesView alloc] initWithFrame:(CGRect){0, 0, KScreenW, KScreenH}];
    attributesView.model = self.model;
    attributesView.submitType = self.submitType;
    [attributesView showInView:self.navigationController.view];
    
    // 确认Button数据回掉
    kWeakSelf(self);
    attributesView.goodsAttributesBlock = ^(NSArray *array) {
        weakself.goodsAttributesArr = array;
        if ([identifier isEqualToString:kNowBuy] || identifier.length == 0) {
            [self goodsBuyOfRightButton:array];
        }else if ([identifier isEqualToString:kShoppingCar]){
            [self goodsBuyOfLeftButton:array];
        }
    };
}
// 商品购买左边的Button操作
- (void)goodsBuyOfLeftButton:(NSArray *)array{
    NSDictionary *dic;
    if (array.count == 3) {
        dic = @{
                @"productId":array[0],
                @"goodsId"  :array[1],
                @"number"   :array[2]
                };
        
    }else{
        dic = @{
                @"goodsId":array[0],
                @"number" :array[1],
                @"deptId" :self.model.deptId
                };
    }
    
    [NetWorkHelper POST:URl_addToCar parameters:dic success:^(id  _Nonnull responseObject) {
        [SVProgressHUD showInfoWithStatus:KJSONSerialization(responseObject)[@"errmsg"]];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:1.0];
    } failure:^(NSError * _Nonnull error) {}];
}
// 商品购买右边的Button操作
- (void)goodsBuyOfRightButton:(NSArray *)array{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    if (array.count == 3) {
        [dic setObject:array[0] forKey:@"productId"];
        [dic setObject:array[1] forKey:@"goodsId"];
        [dic setObject:array[2] forKey:@"number"];
    }else{
        [dic setObject:array[0] forKey:@"goodsId"];
        [dic setObject:array[1] forKey:@"number"];
    }
    NSString *URLString;
    if ([_interfaceState isKindOfClass:[SecondsKillViewController class]]) {
        //秒杀请求
        URLString = URl_confirmGoods2seconds;
    }else if ([_interfaceState isKindOfClass:[SpellGroupViewController class]]){
        /*拼团类型：301直接购买，302发起拼团，303参加拼团*/
        [dic setObject:@"302" forKey:@"initiateType"];
        //拼团
        URLString = URl_confirmGoods2groupbuy;
    }else{
        //直接购买接口
        URLString = URl_confirmGoods2Buy;
    }
    [NetWorkHelper POST:URLString parameters:dic success:^(id  _Nonnull responseObject) {
        DLog(@"errmsg is %@",KJSONSerialization(responseObject)[@"errmsg"]);
        // 直接跳转确认订单界面
        OrderSureViewController *vc = [[OrderSureViewController alloc] init];
        // 提交订单所需参数
        /**submitType除了这几个功能需要传不同的参数,其他就是后面的参数从不同页面传过buy立即购买，cart购物车，group1单独成团，group2发起拼团，group3参与拼团，seconds秒杀
         **orderSnTotal除了重我的订单重新付款,所需参数不一样，其他都一样。
         **/
        vc.submitType = self.submitType?self.submitType:@"buy";
        vc.orderSnTotal = self.orderSnTotal?self.orderSnTotal:kOrderSnTotal;
        [self.navigationController pushViewController:vc animated:NO];
    } failure:^(NSError * _Nonnull error) {}];
}

// 商品购买的Buttons
- (void)goodsBuyOfActon:(UIButton *)sender{
    //库存不为0 才能提交订单
    if (![self.model.remainingInventory isEqualToString:@"0"]) {
        if (sender.tag == 1) {
            //立即购买
            [self creatAttributesView:kNowBuy];
        }else{
            if ([self.interfaceState isKindOfClass:[SpellGroupViewController class]]) {
                self.submitType = kGroup2;
                //拼团，执行拼团方法
                [self creatAttributesView:kNowBuy];
            }else if ([self.interfaceState isKindOfClass:[GoodsShowViewController class]]){
                //加入购物车
                [self GoodsBuyleftButtonOfAction];
            }
        }
    }else{
        [SVProgressHUD showInfoWithStatus:@"库存不足"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:1.0];
    }
}

- (void)GoodsBuyleftButtonOfAction{
    [self creatAttributesView:@"购物车"];
}
// 其他Button的操作，如：收藏、客服。
- (void)otherBtnClickAction:(UIButton *)sender{
    if (sender.tag == 0) {
        [self collectionBtnOfAction];
    }else if (sender.tag == 1){
        [self customerServiceBtnOfAction];
    }
}
// 收藏
- (void)collectionBtnOfAction{
    kWeakSelf(self);
    NSDictionary *dic = @{
                          @"goodsId":weakself.index
                          };
    [NetWorkHelper POST:URl_getGoodsCollectSave parameters:dic success:^(id  _Nonnull responseObject) {
        [SVProgressHUD showInfoWithStatus:@"收藏成功"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:1.0];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
// 客服
- (void)customerServiceBtnOfAction{
    
}
#pragma mark —— tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentsData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[NewCommentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    cell.model = self.commentsData[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(39);
}

#pragma mark —— 购物车
- (void)shoppingCarOfAction{
    ShoppingCartViewController *vc = [[ShoppingCartViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark —— UIWebView 代理
// 页面加载完成之后调用
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    for (int i = 0; i<15; i++) {
        NSString *str = [NSString stringWithFormat:@"document.getElementsByTagName('img')[%d].style.width = '100%%'",i];
        [self.webView stringByEvaluatingJavaScriptFromString:str];
    }
    CGFloat webHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    [self.webView setSize:CGSizeMake(KScreenW, webHeight)];
    [self.tableView reloadData];
}

@end
