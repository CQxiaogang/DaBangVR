//
//  DBHomePageViewController.m
//  DaBangVR
//
//  Created by mac on 2018/11/17.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "DBTopView.h"
#import "JFLocation.h"
#import "DBPrefectureView.h"
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
// Views
#import "AnchorRecommendView.h" //主播推荐
#import "ChannelMenuListView.h" //频道菜单列表
#import "HomeBannerView.h"      //轮播新上
#import "SecondsKillView.h"     //秒杀
#import "HomeTableViewCell.h"
// Models
#import "ChannelModel.h"
#import "GoodsRotationListModel.h"
// 第三方
#import "SureCustomActionSheet.h"

static NSString *CellID = @"CellID";
#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]

@interface HomeViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
JFLocationDelegate,
JFCityViewControllerDelegate,
ChannelMenuListViewDelegate,
TopViewDelegate
>

{
    CGFloat _margin;
    CGFloat _totalH_anchorRecommendView;  // 推荐直播总高度
    CGFloat _totalH_channelMenuList;      // 更多功能总高度
    CGFloat _totalH_newShang;             // 新上总高度
    CGFloat _totalH_secondsKill;          // 秒杀总高度
    CGFloat _totalH_prefecture;           // 新品/热卖专区总高度
    CGFloat _totalH_hotVideo;             // 最热视频总高度
    CGFloat _totalH_globalShopping;       // 全球购总高度
    CGFloat _totalH_videoAndLocalfeatures;// 视频地方特色总高度
}

//@property (nonatomic, strong) UITableView           *myTableView;     // 显示整个界面tableveiw

@property (nonatomic, strong) UITableView           *homeTableView;   // 底部显示更多商品tableveiw

@property (nonatomic, strong) DBTopView             *topView;         // 顶部navagationBar

@property (nonatomic, strong) DBPrefectureView      *prefectureView;

@property (nonatomic, strong) UICollectionView      *collectionView;
/** 城市定位管理器*/
@property (nonatomic, strong) JFLocation            *locationManager;
/** 城市数据管理器*/
@property (nonatomic, strong) JFAreaDataManager     *manager;
// 频道菜单 view
@property (nonatomic, strong) ChannelMenuListView *channelMenuListView;
// 主播推荐 view
@property (nonatomic, strong) AnchorRecommendView *anchorRecommendView;
@property (nonatomic, strong) NSMutableArray *arrayModel;
// 推荐商品数据
@property (nonatomic, copy) NSArray *goodsData;
@end

@implementation HomeViewController
#pragma mark —— 懒加载属性
/*
 访问的时候用get方法来访问，用self.的方式。而不能成员变量(_xxx)访问，成员变量访问的是它的指针
 */
- (UIView *)topView{
    if (!_topView) {
        _topView = [[[NSBundle mainBundle]loadNibNamed:@"DBTopView" owner:nil options:nil] firstObject];
        [_topView setMj_y:20];
        _topView.delegate = self;
        [_topView.location addTarget:self action:@selector(searchTouchAction) forControlEvents:UIControlEventTouchUpInside];
        _topView.searchBox.layer.cornerRadius = Adapt(15);
    }
    return _topView;
}

//- (UITableView *)myTableView{
//    if (_myTableView == nil) {
//        _myTableView = [[UITableView alloc] init];
//        CGFloat tableViewY = self.topView.mj_h + self.topView.mj_y;
//        CGFloat tableView_H = self.view.mj_h - 49 - 20 - 44;
//        //tableView制定
//        _myTableView.frame = CGRectMake(0, tableViewY, self.view.mj_w, tableView_H);
//        _myTableView.delegate = self;
//        _myTableView.dataSource = self;
//        //隐藏tableView分割线
//        _myTableView.separatorStyle = UITableViewCellEditingStyleNone;
//        //隐藏滚动条
//        _myTableView.showsVerticalScrollIndicator = NO;
//
//    }
//    return _myTableView;
//}

-(UITableView *)homeTableView{
    if (_homeTableView == nil) {
        
        _homeTableView = [[UITableView alloc] init];
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
        //设置不能滚动
        _homeTableView.scrollEnabled = NO;
        _homeTableView.showsVerticalScrollIndicator = NO;
        //根据homeTable的内容获取高度
        CGFloat homeT_H = 3 * 105;
        _homeTableView.frame = CGRectMake(0, 0, self.view.mj_w, homeT_H);
        [_homeTableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:CellID];
    }
    return _homeTableView;
}

-(DBPrefectureView *)prefectureView{
    if (_prefectureView == nil) {
        
        _prefectureView = [[DBPrefectureView alloc] init];
        
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
        _channelMenuListView = [[ChannelMenuListView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, kFit(130))];
        _channelMenuListView.delegate = self;
    }
    return _channelMenuListView;
}
// 主播推荐 view
- (AnchorRecommendView *)anchorRecommendView{
    if (!_anchorRecommendView) {
        _anchorRecommendView = [[AnchorRecommendView alloc] initWithFrame:CGRectMake(0, 0, self.view.mj_w, Adapt(140))];
    }
    return _anchorRecommendView;
}

- (NSMutableArray *)arrayModel{
    if (!_arrayModel) {
        _arrayModel = [NSMutableArray new];
    }
    return _arrayModel;
}
#pragma mark —— 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // 全局变量,定义边距
    _margin = kFit(20);
    self.locationManager = [[JFLocation alloc] init];
    _locationManager.delegate = self;
    
    [self loadingData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 隐藏navigationBar
    [self.navigationController setNavigationBarHidden:YES];
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
                          @"parentId":@"2",
                          @"categoryId":@"1036112",
                          @"page":@"1",
                          @"limit":@"10"
                          };
    [NetWorkHelper POST:URl_getGlobalList parameters:dic success:^(id  _Nonnull responseObject) {
        NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
        // 推荐商品
        weakself.goodsData = [GoodsDetailsModel mj_objectArrayWithKeyValuesArray:data[@"goodsLists"]];
        [weakself.homeTableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark —— tableView实现
//设置多少个数据组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([tableView isEqual:self.tableView]) {
        return 9;
    }else{
        return _goodsData.count;
    }
}

//此方法告诉tableview对应的组有多少个数据行。需要对每组依次进行设置，return几就表示几行
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableView]) {
        //让cell不重用
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
        }
        switch (indexPath.section) {
            case 0:
                // 主播推荐
                [self setupAnchorRecommendView:cell];
                break;
            case 1:
                // 频道菜单
                [self setupChannelMenuListView:cell];
                break;
            case 2:
                // 新上
                [self setupNew:cell];
                break;
            case 3:
                // 限时秒杀
                [self setupSecondsKillView:cell];
                break;
            case 4:
                // 新品/热卖 专区
                [self setUp_prefectureView:cell];
                break;
            case 5:
                // 最热视频
                [self setUp_hotVideo:cell];
                break;
            case 6:
                // 全球购
                [self setUp_globalShopping:cell];
                break;
            case 7:
                // 视频 地方特色
                [self setUp_videoAndLocalfeatures:cell];
                break;
            case 8:
                // 商品列表
                [cell addSubview:self.homeTableView];
                break;
            default:
                break;
        }
        // 设置cell不能点击
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        
        HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        
        if (cell == nil) {
            cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
        }
        cell.model = _goodsData[indexPath.row];
        return cell;
    }
}

//个方法返回指定的 row 的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableView]) {
        switch (indexPath.section) {
            case 0:
                // 直播推荐视图
                return _totalH_anchorRecommendView+kFit(20);
                break;
            case 1:
                // 更多功能界面
                return _totalH_channelMenuList;
                break;
            case 2:
                // 新上
                return Adapt(200);
                break;
            case 3:
                // 限时秒杀
                return _totalH_secondsKill;
                break;
            case 4:
                // 新品/热卖 专区
                return _totalH_prefecture;
                break;
            case 5:
                // 最热视频
                return _totalH_hotVideo;
                break;
            case 6:
                // 全球购
                return _totalH_globalShopping;
                break;
            case 7:
                // 视频/地方特色
                return _totalH_videoAndLocalfeatures;
                break;
            case 8:
                // 商品列表
                return self.homeTableView.mj_h;
                break;
            default:
                break;
        }
        return 0;
    }else{
        return kFit(105);
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1f;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc] init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1f;
}
#pragma mark —— 推荐主播
- (void) setupAnchorRecommendView:(UITableViewCell *)cell{
    
//    [cell addSubview:self.anchorRecommendView];
    
//    _totalH_anchorRecommendView = self.anchorRecommendView.mj_h;
}

#pragma mark —— 频道菜单列表
- (void)setupChannelMenuListView:(UITableViewCell *)cell{
    if (self.arrayModel.count == 0) {
        NSDictionary *dic = @{
                              @"mallSpeciesId":@"1"
                              };
        [NetWorkHelper POST:URL_getChannelMenuList parameters:dic success:^(id  _Nonnull responseObject) {
            NSDictionary *data= KJSONSerialization(responseObject)[@"data"];
            NSArray *channelMenuList = data[@"channelMenuList"];
            for (NSDictionary *dic in channelMenuList) {
                ChannelModel *model = [ChannelModel channelModelWithDic:dic];
                [self.arrayModel addObject:model];
            }
            self.channelMenuListView.data = self.arrayModel;
            
        } failure:^(NSError * _Nonnull error) {
            DLog(@"error %@",error);
        }];
    }
    
    [cell addSubview:self.channelMenuListView];
    _totalH_channelMenuList = self.channelMenuListView.mj_h;
}

#pragma mark —— 频道菜单列表 代理
-(void)channelBtnOfClick:(NSInteger)row{
    switch (row) {
        case 0: // 视屏
//            [self pushViewController:[SecondsKillViewController alloc]];
            break;
        case 1: // 海鲜
            [self pushViewController:[GoodsShowViewController new]];
            break;
        case 2: // 拼团
            [self pushViewController:[SpellGroupViewController new]];
            break;
        case 3: // 限时秒杀
            [self pushViewController:[SecondsKillViewController new]];
            break;
        case 4: // 大邦
            break;
        case 5: // 全球购
            [self pushViewController:[GlobalShoppingViewController new]];
            break;
        case 6: // 新品首发
            [self pushViewController:[NewProductLaunchViewController new]];
            break;
        case 8: // 分类搜索
            [self pushViewController:[SortSearchViewController new]];
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
    NSMutableArray *dataSource = [NSMutableArray array];
    dispatch_group_t downloadGroup = dispatch_group_create();
    dispatch_group_enter(downloadGroup);
    [NetWorkHelper POST:URl_goods_rotation_list parameters:@{@"parentId": @"1"} success:^(id  _Nonnull responseObject) {
        NSDictionary *data= KJSONSerialization(responseObject)[@"data"];
        NSArray *goodsArray = data[@"goodsRotationList"];
        for (NSDictionary *dic in goodsArray) {
            GoodsRotationListModel *model = [GoodsRotationListModel modelWithDictionary:dic];
            [dataSource addObject:model];
        }
        dispatch_group_leave(downloadGroup);
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        HomeBannerView *bannerView = [[HomeBannerView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 200)andGoodsArray:dataSource];
        [cell addSubview:bannerView];
    });
}

#pragma mark —— 限时秒杀
- (void)setupSecondsKillView:(UITableViewCell *)cell{
//    kWeakSelf(self);
    NSDictionary *dic = @{@"hoursTime":@"12",@"page":@"1", @"limit":@"2"};
    [NetWorkHelper POST:URl_getSecondsKillGoodsList parameters:dic success:^(id  _Nonnull responseObject) {
        NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
        NSDictionary *goodsList = data[@"goodsList"];
        NSArray *goodsData = [GoodsDetailsModel mj_objectArrayWithKeyValuesArray:goodsList];
        
        //头部便签
        UIView *titleView = [self titleImageOneString:@"h_maio" titleImageTwoString:@"h_tl" moreImageStrng:@"h_newshop_greater"];
        [cell addSubview:titleView];
        
        SecondsKillView *secondsKillView;
        NSMutableArray *views = [NSMutableArray new];
        for (int i = 0; i<2; i++) {
            //从xib中读出视图
            secondsKillView = [self loadNibNamed:@"SecondsKillView"];
            if (goodsData.count != 0) {
                secondsKillView.model = goodsData[i];
                [views addObject:secondsKillView];
                [cell addSubview:secondsKillView];
            }
        }
        if (views.count != 0) {
            [views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:5 leadSpacing:10 tailSpacing:10];
            [views mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(titleView.mas_bottom).offset(0);
            }];
        }
        self->_totalH_secondsKill = kFit(titleView.mj_h + secondsKillView.mj_h);
        if (goodsData.count == 0) {
            [titleView removeFromSuperview];
            self->_totalH_secondsKill = 0;
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark —— 新品/热卖 专区
- (void)setUp_prefectureView:(UITableViewCell *)cell{
    //新品/热卖 专区
    UIView *prefectureView;
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i<2; i++) {
        //从xib中读出视图
        prefectureView = [self loadNibNamed:@"DBPrefectureView"];
        [arr addObject: prefectureView];
        [cell addSubview:prefectureView];
    }
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
     _totalH_prefecture = Adapt(prefectureView.mj_h);
}

#pragma mark —— 最热视频
- (void)setUp_hotVideo:(UITableViewCell *)cell{
    UIView *titleView = [self titleImageOneString:@"h_hottest_video" titleImageTwoString:@"h_hotVideo" moreImageStrng:@"h_newshop_greater"];
    [cell addSubview:titleView];

    UIView *hotVideoView;
    for (int i=0; i<2; i++) {
        for (int j = 0; j<3; j++) {
            hotVideoView = [self loadNibNamed:@"DBHotVideoView"];
            CGFloat hotV_W = Adapt(hotVideoView.mj_w);
            CGFloat hotV_H = Adapt(hotVideoView.mj_h);
            CGFloat margin = (self.view.mj_w - (hotV_W*3))/4;
            CGFloat hotV_X = j * (hotV_W+margin) + margin;
            CGFloat hotV_Y = i * hotV_H + titleView.mj_h;
            hotVideoView.frame = CGRectMake(hotV_X, hotV_Y, hotV_W, hotV_H);
            [cell addSubview:hotVideoView];
        }
    }
    // 底部查看更多button
    UIButton *more_hotVieoBtn = [[UIButton alloc] init];
    [more_hotVieoBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [more_hotVieoBtn setTitleColor:[UIColor lightGreen] forState:UIControlStateNormal];
    more_hotVieoBtn.titleLabel.adaptiveFontSize = 12;
    // 设置按钮样式
    more_hotVieoBtn.layer.cornerRadius = 10;
    more_hotVieoBtn.layer.borderColor = [[UIColor lightGreen] CGColor];
    more_hotVieoBtn.layer.borderWidth = 1.0f;
    [cell addSubview:more_hotVieoBtn];

    [more_hotVieoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(cell);
        make.top.equalTo(hotVideoView.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
    _totalH_hotVideo = titleView.mj_h + hotVideoView.mj_h*2 + 35;
}

#pragma mark —— 全球购
- (void)setUp_globalShopping:(UITableViewCell *)cell{
    UIView *titleView = [self titleImageOneString:@"h_global" titleImageTwoString:@"h_global2" moreImageStrng:@"h_newshop_greater"];
    [cell addSubview:titleView];
    
    UIImageView *gs_recommend_Img = [[UIImageView alloc] init];
    gs_recommend_Img.image = [UIImage imageNamed:@"ad5"];
    [cell addSubview:gs_recommend_Img];
    [gs_recommend_Img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_bottom).offset(0);
        make.centerX.equalTo(cell);
        make.height.equalTo(cell).multipliedBy(0.9);
        make.width.equalTo(cell).multipliedBy(0.95);
    }];
    _totalH_globalShopping = 200;
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
- (UIView *)titleImageOneString:(NSString *)oneString titleImageTwoString:(NSString *)twoString moreImageStrng:(NSString *)moreString{
    
    CGFloat superViewH = kFit(40);
    
    UIView *superView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.mj_w, superViewH)];
    // 第一个图标
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:oneString];
    [superView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superView.mas_centerY);
        make.left.equalTo(kFit(0));
        make.size.equalTo(CGSizeMake(superViewH, superViewH/2));
    }];
    // 第二个图标
    UIImageView *imgView2 = [[UIImageView alloc] init];
    imgView2.image = [UIImage imageNamed:twoString];
    [superView addSubview:imgView2];
    [imgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(superView.mas_centerY);
        make.left.equalTo(imgView.mas_right).offset(2);
        make.size.equalTo(CGSizeMake(superViewH*2, superViewH/2));
    }];
    // 右边按钮
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:moreString] forState:UIControlStateNormal];
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

#pragma mark —— 定位点击事件
- (void)searchTouchAction{
    // https://www.jianshu.com/p/40bc4b6ddceb demo地址
    JFCityViewController *cityVC = [[JFCityViewController alloc] init];
    cityVC.delegate = self;
    // 给JFCityViewController添加一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cityVC];
    [self presentViewController:nav animated:YES completion:nil];
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

@end
