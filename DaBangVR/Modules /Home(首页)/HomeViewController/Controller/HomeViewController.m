//
//  DBHomePageViewController.m
//  DaBangVR
//
//  Created by mac on 2018/11/17.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "DBTopView.h"
#import "JFLocation.h"
#import "HomeNewAndHotGoodsView.h"
#import "JFAreaDataManager.h"
#import "AnchorViewCell.h"
#import "JFCityViewController.h"
#import "HomeViewController.h"
#import "GoodsShowViewController.h"
// Controllers
#import "SpellGroupViewController.h"        //拼团
#import "SecondsKillViewController.h"       //秒杀
#import "ShoppingCartViewController.h"      //购物车
#import "NewProductLaunchViewController.h"  //新品首发
#import "GlobalShoppingViewController.h"    //全球购
#import "SortSearchViewController.h"        //分类搜索
#import "SearchGoodsViewController.h"       //搜索商品
#import "SearchViewController.h"            //搜索商品
#import "GoodsDetailsViewController.h"      //商品详情
#import "StoreViewController.h"             //门店
#import "MerchantsSettledViewController.h"  //商家入驻
#import "ShortVideoViewController.h"        //短视频
// Views
#import "AnchorRecommendView.h" //主播推荐
#import "ChannelMenuListView.h" //频道菜单列表
#import "HomeBannerView.h"      //轮播新上
#import "HomeSecondsKillView.h" //秒杀
#import "HomeTableViewCell.h"
#import "BaseTableView.h"
#import "HomeNewAndHotGoodsView.h"//新品和最热商品展示
#import "ShufflingView.h"
// Models
#import "ChannelModel.h"
#import "GoodsRotationListModel.h"
#import "NewGoodsModel.h"
// 第三方
#import "SureCustomActionSheet.h"
#import "DHGuidePageHUD.h" //APP引导页

static NSString *CellID = @"CellID";
#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]

@interface HomeViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
JFLocationDelegate,
JFCityViewControllerDelegate,
ChannelMenuListViewDelegate,
TopViewDelegate,
HomeNewAndHotGoodsViewDelegate,
ShufflingViewDelegate
>

{
    CGFloat _totalH_anchorRecommendView;  // 推荐直播总高度
    CGFloat _totalH_channelMenuList;      // 更多功能总高度
    CGFloat _totalH_newShang;             // 新上总高度
    CGFloat _totalH_secondsKill;          // 秒杀总高度
    CGFloat _totalH_prefecture;           // 新品/热卖专区总高度
    CGFloat _totalH_hotVideo;             // 最热视频总高度
    CGFloat _totalH_globalShopping;       // 全球购总高度
    CGFloat _totalH_videoAndLocalfeatures;// 视频地方特色总高度
}

@property (nonatomic, strong) DBTopView             *topView;         // 顶部navagationBar

@property (nonatomic, strong) HomeNewAndHotGoodsView      *prefectureView;

@property (nonatomic, strong) UICollectionView      *collectionView;
/** 城市定位管理器*/
@property (nonatomic, strong) JFLocation            *locationManager;
/** 城市数据管理器*/
@property (nonatomic, strong) JFAreaDataManager     *manager;
//频道菜单 view
@property (nonatomic, strong) ChannelMenuListView *channelMenuListView;
//主播推荐 view
@property (nonatomic, strong) AnchorRecommendView *anchorRecommendView;
@property (nonatomic, strong) NSMutableArray *arrayModel;
@property (nonatomic, strong) BaseTableView *recommendGoodsTable;
//推荐商品数据
@property (nonatomic, copy) NSArray <GoodsDetailsModel *>*goodsData;
//新品专区数据
@property (nonatomic, strong) NSMutableArray <NewGoodsModel *>*goodsImgList;
@end

@implementation HomeViewController
#pragma mark —— 懒加载属性
/*
 访问的时候用get方法来访问，用self.的方式。而不能成员变量(_xxx)访问，成员变量访问的是它的指针
 */
- (UIView *)topView{
    if (!_topView) {
        _topView          = [[[NSBundle mainBundle]loadNibNamed:@"DBTopView" owner:nil options:nil] firstObject];
        _topView.delegate = self;
        _topView.searchBox.layer.cornerRadius = kFit(15);
        [_topView.location addTarget:self action:@selector(searchTouchAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topView;
}

-(HomeNewAndHotGoodsView *)prefectureView{
    if (_prefectureView == nil) {
        _prefectureView = [[HomeNewAndHotGoodsView alloc] init];
    }
    return _prefectureView;
}

- (JFAreaDataManager *)manager {
    if (!_manager) {
        _manager = [JFAreaDataManager shareInstance];
        [_manager areaSqliteDBData];
    }
    return _manager;
}
// 频道列表
- (ChannelMenuListView *)channelMenuListView{
    if (!_channelMenuListView) {
        _channelMenuListView = [[ChannelMenuListView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, kFit(159))];
        _channelMenuListView.delegate = self;
    }
    return _channelMenuListView;
}
// 主播推荐 view
- (AnchorRecommendView *)anchorRecommendView{
    if (!_anchorRecommendView) {
        _anchorRecommendView = [[AnchorRecommendView alloc] initWithFrame:CGRectMake(0, 0, self.view.mj_w, Adapt(154))];
    }
    return _anchorRecommendView;
}

- (NSMutableArray *)arrayModel{
    if (!_arrayModel) {
        _arrayModel = [NSMutableArray new];
    }
    return _arrayModel;
}

-(NSMutableArray<NewGoodsModel *> *)goodsImgList{
    if (!_goodsImgList) {
        _goodsImgList = [NSMutableArray new];
    }
    return _goodsImgList;
}

#pragma mark —— 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // App引导页
    if (![[NSUserDefaults standardUserDefaults] boolForKey:BOOLFORKEY]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BOOLFORKEY];
        // 静态引导页
        [self setStaticGuidePage];                                                                                                                                        
    }else{
        self.locationManager = [[JFLocation alloc] init];
        _locationManager.delegate = self;
        [self loadingData];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 隐藏navigationBar
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark - 设置APP静态图片引导页
- (void)setStaticGuidePage {
    NSArray *imageNameArray = @[@"G_img1",@"G_img2",@"G_img3"];
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.view.frame imageNameArray:imageNameArray buttonIsHidden:NO];
    guidePage.slideInto = YES;
    [self.tabBarController.view addSubview:guidePage];
}

#pragma mark —— 设置主页UI
-(void)setupUI{
    [super setupUI];
    // 设置顶部视图
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kStatusBarHeight);
        make.left.right.equalTo(0);
        make.size.equalTo(CGSizeMake(KScreenW, kNavBarHeight));
    }];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(0);
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
}

-(void)loadingData{
    kWeakSelf(self);
    NSDictionary *dic = @{
                          @"page":@"1",
                          @"limit":@"10"
                          };
    [NetWorkHelper POST:URl_getGoodsLists parameters:dic success:^(id  _Nonnull responseObject) {
        NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
        // 推荐商品
        weakself.goodsData = [GoodsDetailsModel mj_objectArrayWithKeyValuesArray:data[@"goodsList"]];
    } failure:^(NSError * _Nonnull error) {}];
}

#pragma mark —— tableView实现
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 9;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //让cell不重用
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    switch (indexPath.section) {
        case 0:
            //主播推荐
            [self setupAnchorRecommendView:cell];
            break;
        case 1:
            //频道菜单
            [self setupChannelMenuListView:cell];
            break;
        case 2:
            //新上
            [self setupNew:cell];
            break;
        case 3:
            //限时秒杀
            [self setupSecondsKillView:cell];
            break;
        case 4:
            //新品/热卖 专区
            [self setupNewAndHotGoodsView:cell];
            break;
        case 5:
            //最热视频
            [self setUp_hotVideo:cell];
            break;
        case 6:
            //全球购
            [self setUp_globalShopping:cell];
            break;
        case 7:
            //视频 地方特色
//            [self setUp_videoAndLocalfeatures:cell];
            break;
        case 8:
            //商品列表
        {
            _recommendGoodsTable = [[BaseTableView alloc] init];
            _recommendGoodsTable.delegate = self;
            _recommendGoodsTable.goodsData = _goodsData;
            [cell addSubview:_recommendGoodsTable];
            [_recommendGoodsTable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(20);
                make.left.right.bottom.equalTo(0);
            }];
        }
            break;
        default:
            break;
    }
    //设置cell不能点击
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
#pragma mark —— 返回每个cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            //直播推荐视图
            return _totalH_anchorRecommendView;
            break;
        case 1:
            //更多功能界面
            return _totalH_channelMenuList;
            break;
        case 2:
            //新上
            return _totalH_newShang;
            break;
        case 3:
            //限时秒杀
            return _totalH_secondsKill;
            break;
        case 4:
            //新品/热卖 专区
            return _totalH_prefecture;
            break;
        case 5:
            //最热视频
//            return _totalH_hotVideo;
            break;
        case 6:
            //全球购
//            return _totalH_globalShopping;
            break;
        case 7:
            //视频/地方特色
//            return _totalH_videoAndLocalfeatures;
            break;
        case 8:
            //商品列表
            return _goodsData.count * kFit(118.5)+20;
            break;
        default:
            break;
    }
    
    return kFit(0);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = RGBCOLOR(247, 247, 247);
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 5 || section == 6 || section == 7) {
        return .1f;
    }
    if (_totalH_secondsKill == 0){
        if (section == 3) {
           return .1f;
        }
    }
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:self.recommendGoodsTable]) {
        GoodsDetailsViewController *vc = [GoodsDetailsViewController new];
        vc.hidesBottomBarWhenPushed    = YES;
        vc.index = _goodsData[indexPath.row].id;
        [self pushViewController:vc];
    }
    
    
}

#pragma mark —— 推荐主播
- (void) setupAnchorRecommendView:(UITableViewCell *)cell{
    
    [cell addSubview:self.anchorRecommendView];
    
    _totalH_anchorRecommendView = self.anchorRecommendView.mj_h;
}

#pragma mark —— 频道菜单列表
- (void)setupChannelMenuListView:(UITableViewCell *)cell{
    if (self.arrayModel.count == 0) {
        NSDictionary *dic = @{@"mallSpeciesId":@"1"};
        [NetWorkHelper POST:URL_getChannelMenuList parameters:dic success:^(id  _Nonnull responseObject) {
            NSDictionary *data= KJSONSerialization(responseObject)[@"data"];
            NSArray *channelMenuList = data[@"channelMenuList"];
            for (NSDictionary *dic in channelMenuList) {
                ChannelModel *model = [ChannelModel channelModelWithDic:dic];
                [self.arrayModel addObject:model];
            }
            self.channelMenuListView.data = self.arrayModel;
        } failure:^(NSError * _Nonnull error) {}];
    }
    
    [cell addSubview:self.channelMenuListView];
    _totalH_channelMenuList = self.channelMenuListView.mj_h + KMargin;
}

#pragma mark —— 频道菜单列表 代理
-(void)channelBtnOfClick:(NSInteger)row{
    switch (row) {
        case 0: //短视频
            [self pushViewController:[ShortVideoViewController new]];
            break;
        case 1: //海鲜
            [self pushViewController:[GoodsShowViewController new]];
            break;
        case 2: //拼团
            [self pushViewController:[SpellGroupViewController new]];
            break;
        case 3: //限时秒杀
            [self pushViewController:[SecondsKillViewController new]];
            break;
        case 4: //直播
            break;
        case 5: //新品首发
            [self pushViewController:[NewProductLaunchViewController new]];
            break;
        case 6: //门店
            [self pushViewController:[StoreViewController new]];
            break;
        case 7: //入驻
            [self pushViewController:[MerchantsSettledViewController new]];
            break;
        default:
            break;
    }
}

- (void)pushViewController:(UIViewController *)vc{
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark —— 新上
- (void)setupNew:(UITableViewCell *)cell{
    //标题
    UIView *titleView = [[[NSBundle mainBundle] loadNibNamed:@"DBNewProductView" owner:nil options:nil] firstObject];
    [titleView setOrigin:CGPointMake(0, 0)];
    //轮播图
    ShufflingView *shufflingView = [[ShufflingView alloc] initWithFrame:CGRectMake(0, titleView.mj_h, self.tableView.mj_w, kFit(188)) andIndex:@"1"];
    shufflingView.delegate = self;
    
    [cell addSubview:titleView];
    [cell addSubview:shufflingView];
    _totalH_newShang = titleView.mj_h + shufflingView.mj_h;
}

#pragma mark —— 限时秒杀
- (void)setupSecondsKillView:(UITableViewCell *)cell{
//    kWeakSelf(self);
    //当前时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSDate *datenow = [NSDate date];
    NSString *currentTime = [formatter stringFromDate:datenow];
    //加载数据 
    NSDictionary *dic = @{@"hoursTime":currentTime,@"page":@"1", @"limit":@"2"};
    [NetWorkHelper POST:URl_getSecondsKillGoodsList parameters:dic success:^(id  _Nonnull responseObject) {
        NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
        NSDictionary *goodsList = data[@"goodsList"];
        NSArray *goodsData = [GoodsDetailsModel mj_objectArrayWithKeyValuesArray:goodsList];
        //头部View
        UIView *titleView = [self titleImg:@"h_tl" showMoreGoodsButton:@"h_newshop_greater" buttonTag:101];
        [cell addSubview:titleView];
        //限时秒杀View
        HomeSecondsKillView *secondsKillView;
        NSMutableArray *views = [NSMutableArray new];
        for (int i = 0; i<goodsData.count; i++) {
            //从xib中读出视图
            secondsKillView = [self loadNibNamed:@"HomeSecondsKillView"];
            secondsKillView.model = goodsData[i];
            [views addObject:secondsKillView];
            [cell addSubview:secondsKillView];
        }
        if (views.count == 2) {
            [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:KMargin leadSpacing:KMargin tailSpacing:KMargin];
            [views mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(titleView.mas_bottom).offset(0);
            }];
        }else if (views.count == 1){
            secondsKillView = views[0];
            [secondsKillView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(titleView.mas_bottom).offset(0);
                make.left.equalTo(KMargin);
                make.size.equalTo(CGSizeMake(169, 142));
            }];
        }

        _totalH_secondsKill = kFit(titleView.mj_h + secondsKillView.mj_h);
        if (goodsData.count == 0) {
            [titleView removeFromSuperview];
            _totalH_secondsKill = 0;
        }
    } failure:^(NSError * _Nonnull error) {}];
}

#pragma mark —— 新品专区
- (void)setupNewAndHotGoodsView:(UITableViewCell *)cell{
    
    dispatch_group_t g = dispatch_group_create();
    dispatch_group_enter(g);
    
    NSDictionary *dic = @{
                          @"page":@"1",
                          @"limit":@"5",
                          @"goodsPage":@"1",
                          @"goodsLimit":@"5",
                          @"categoryId":@"1",
                          @"type":@"0",
                          };
    [NetWorkHelper POST:URL_newGoodsList parameters:dic success:^(id  _Nonnull responseObject) {
        NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
        NSArray *list = [NewGoodsModel mj_objectArrayWithKeyValuesArray:data[@"GoodsCategoryList"]];
        //得到最前面的两个数据
        for (int i = 0; i<2; i++) {
            NewGoodsModel *model = list[i];
            [self.goodsImgList addObject:model];
        }
        dispatch_group_leave(g);
        
    } failure:^(NSError * _Nonnull error) {}];
    
    dispatch_group_notify(g, dispatch_get_main_queue(), ^{
        HomeNewAndHotGoodsView *goodsView;
        NSMutableArray *views = [NSMutableArray new];
        for (int i = 0; i<2; i++) {
            //从xib中读出视图
            goodsView                      = [self loadNibNamed:@"HomeNewAndHotGoodsView"];
            goodsView.delegate             = self;
            goodsView.goodsImgView.tag     = 10+i;
            [goodsView.goodsImgView setImageWithURL:[NSURL URLWithString:self.goodsImgList[i].listUrl] placeholder:kDefaultImg];
            [views addObject: goodsView];
            [cell  addSubview:goodsView];
        }
        //布局
        [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:KMargin leadSpacing:KMargin tailSpacing:KMargin];
        [views mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(kFit(172.5), kFit(145.5)));
            make.centerY.equalTo(cell.mas_centerY);
        }];
    });
    //得到最终高度,用于确定cell的高度
    _totalH_prefecture = kFit(145.5 + 12 + 14.5);
}

#pragma mark —— HomeNewAndHotGoodsView 代理(新上)
-(void)showMoreGoods:(UIButton *)sender{
    [self pushViewController:[NewProductLaunchViewController new]];
}

-(void)goodsImgViewGoGoodsDetailsView:(UIImageView *)imageView{
    //根据用户操作进入到商品详情界面
    GoodsDetailsViewController *vc = [GoodsDetailsViewController new];
    if (imageView.tag == 10) {
        NewGoodsModel *model = self.goodsImgList[0];
        vc.index = model.goodsVoList[0].id;
    }else{
        NewGoodsModel *model = self.goodsImgList[1];
        vc.index = model.goodsVoList[0].id;
    }
    [self pushViewController:vc];
}

#pragma mark —— 最热视频
- (void)setUp_hotVideo:(UITableViewCell *)cell{
//    UIView *titleView = [self titleImageOneString:@"h_hottest_video" titleImageTwoString:@"h_hotVideo" moreImageStrng:@"h_newshop_greater"];
//    [cell addSubview:titleView];
//
//    UIView *hotVideoView;
//    for (int i=0; i<2; i++) {
//        for (int j = 0; j<3; j++) {
//            hotVideoView = [self loadNibNamed:@"DBHotVideoView"];
//            CGFloat hotV_W = Adapt(hotVideoView.mj_w);
//            CGFloat hotV_H = Adapt(hotVideoView.mj_h);
//            CGFloat margin = (self.view.mj_w - (hotV_W*3))/4;
//            CGFloat hotV_X = j * (hotV_W+margin) + margin;
//            CGFloat hotV_Y = i * hotV_H + titleView.mj_h;
//            hotVideoView.frame = CGRectMake(hotV_X, hotV_Y, hotV_W, hotV_H);
//            [cell addSubview:hotVideoView];
//        }
//    }
//    // 底部查看更多button
//    UIButton *more_hotVieoBtn = [[UIButton alloc] init];
//    [more_hotVieoBtn setTitle:@"查看更多" forState:UIControlStateNormal];
//    [more_hotVieoBtn setTitleColor:[UIColor lightGreen] forState:UIControlStateNormal];
//    more_hotVieoBtn.titleLabel.adaptiveFontSize = 12;
//    // 设置按钮样式
//    more_hotVieoBtn.layer.cornerRadius = 10;
//    more_hotVieoBtn.layer.borderColor = [[UIColor lightGreen] CGColor];
//    more_hotVieoBtn.layer.borderWidth = 1.0f;
//    [cell addSubview:more_hotVieoBtn];
//
//    [more_hotVieoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(cell);
//        make.top.equalTo(hotVideoView.mas_bottom).with.offset(10);
//        make.size.mas_equalTo(CGSizeMake(100, 25));
//    }];
//    _totalH_hotVideo = titleView.mj_h + hotVideoView.mj_h*2 + 35;
}

#pragma mark —— 全球购
- (void)setUp_globalShopping:(UITableViewCell *)cell{
//    UIView *titleView  = [self titleImg:@"" showMoreGoodsButton:@"h_newshop_greater" buttonTag:100];
//    [cell addSubview:titleView];
//
//    UIImageView *gs_recommend_Img = [[UIImageView alloc] initWithFrame:CGRectMake(0, titleView.mj_h, KScreenW, kFit(153))];
//    gs_recommend_Img.image = [UIImage imageNamed:@"ad5"];
//    [cell addSubview:gs_recommend_Img];
//    _totalH_globalShopping = kFit(titleView.mj_h + gs_recommend_Img.mj_h+KMargin);
}

#pragma mark —— 视频 地方特色
- (void)setUp_videoAndLocalfeatures:(UITableViewCell *)cell{
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor whiteColor];
    [cell addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.centerX.mas_equalTo(cell);
        make.width.equalTo(cell).multipliedBy(0.95);
        make.height.equalTo(cell).multipliedBy(0.2);
    }];

    NSArray *list = @[@"视频",@"地方特色"];
    UIButton *selectBtn;
    NSMutableArray *arr = [NSMutableArray new];
    for (int i=0; i<2; i++) {
        selectBtn = [[UIButton alloc] init];
        [selectBtn setTitle:list[i] forState:UIControlStateNormal];
        [selectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        selectBtn.tag = 10 + i;
        selectBtn.titleLabel.adaptiveFontSize = 15;
        selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        selectBtn.backgroundColor = [UIColor randomColor];
        [arr addObject:selectBtn];
        [headView addSubview:selectBtn];
    }
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:150];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];

    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor redColor];
    [cell addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headView.mas_bottom).offset(0);
        make.left.mas_equalTo(10);
        make.centerX.mas_equalTo(cell);
        make.width.equalTo(cell).multipliedBy(0.95);
        make.height.equalTo(cell).multipliedBy(0.8);
    }];
    _totalH_videoAndLocalfeatures = 150;
}

// 抽取读取xib文件方法
- (id)loadNibNamed:(NSString *)string{
    return  [[[NSBundle mainBundle]loadNibNamed:string owner:nil options:nil] firstObject];
}

// 标题视图封装
- (UIView *)titleImg:(NSString *)imgName showMoreGoodsButton:(NSString *)btnName buttonTag:(NSInteger)tag{
    
    CGFloat superViewH = kFit(47);
    UIView *superView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, superViewH)];
    // 第一个图标
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:imgName];
    [superView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superView.mas_centerY);
        make.left.equalTo(kFit(KMargin));
        make.size.equalTo(CGSizeMake(112, 17.5));
    }];
   
    // 右边按钮
    UIButton *btn = [[UIButton alloc] init];
    btn.tag = tag;
    [btn setImage:[UIImage imageNamed:btnName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showMoreGoods2:) forControlEvents:UIControlEventTouchUpInside];
    // 设置图片偏移量
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, superViewH*2, 0, 0);
    [superView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superView.mas_centerY);
        make.right.equalTo(superView.mas_right).offset(0);
        make.size.equalTo(CGSizeMake(superViewH*3, superViewH));
    }];
    return superView;
}

- (void)showMoreGoods2:(UIButton *)sender{
    if (sender.tag == 100) {
        // 全球购
        [self pushViewController:[GlobalShoppingViewController new]];

    }else{
        // 限时秒杀
        [self pushViewController:[SecondsKillViewController new]];
    }
}

#pragma mark —— 定位点击事件
- (void)searchTouchAction{
    // https://www.jianshu.com/p/40bc4b6ddceb demo地址
//    JFCityViewController *cityVC = [[JFCityViewController alloc] init];
//    cityVC.delegate = self;
//    // 给JFCityViewController添加一个导航控制器
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cityVC];
//    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark —— JFCityViewControllerDelegate
- (void)cityName:(NSString *)name {
    
}

#pragma mark —— JFLocationDelegate
// 定位中...
- (void)locating {
    NSLog(@"定位中...");
}
// 定位成功
- (void)currentLocation:(NSDictionary *)locationDictionary {
    NSString *city = [locationDictionary valueForKey:@"City"];
    [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"locationCity"];
    [KCURRENTCITYINFODEFAULTS setObject:city forKey:@"currentCity"];
    [self.manager cityNumberWithCity:city cityNumber:^(NSString *cityNumber) {
        [KCURRENTCITYINFODEFAULTS setObject:cityNumber forKey:@"cityNumber"];
    }];
}
/// 拒绝定位
- (void)refuseToUsePositioningSystem:(NSString *)message {
    NSLog(@"%@",message);
}
/// 定位失败
- (void)locateFailure:(NSString *)message {
    NSLog(@"%@",message);
}
#pragma mark —— 顶部 View 的点击事件
- (void)shoppingCarClickAction{
    ShoppingCartViewController *vc = [[ShoppingCartViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:NO];
}

-(void)searchBoxClickAction{
    [self pushViewController:[SearchViewController new]];
}

#pragma mark —— ShufflingView 代理
-(void)goodsRotationSelectedAndJumpUrl:(NSString *)jumpUrl andParentId:(NSString *)parentId{
    if ([parentId isEqualToString:@"1"]) {
        GoodsDetailsViewController *vc = [[GoodsDetailsViewController alloc] init];
        vc.index = jumpUrl;
        [self pushViewController:vc];
    }
}

@end
