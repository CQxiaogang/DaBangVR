//
//  DBHomePageViewController.m
//  DaBangVR
//
//  Created by mac on 2018/11/17.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "DBTopView.h"
#import "JFLocation.h"
#import "PageTitleView.h"
#import "PageContentView.h"
#import "DBPrefectureView.h"
#import "JFAreaDataManager.h"
#import "AnchorViewCell.h"
#import "JFCityViewController.h"
#import "HomeViewController.h"
#import "MineViewController2.h"
#import "GoodsShowViewController.h"
// Controllers
#import "SpellGroupViewController.h"        //拼团
#import "SecondsKillViewController.h"       //秒杀
#import "ShoppingCartViewController.h"  //购物车
#import "NewProductLaunchViewController.h"       //新品首发
// Views
#import "AnchorRecommendView.h" //主播推荐
#import "ChannelMenuListView.h" //频道菜单列表
#import "HomeBannerView.h"      //轮播新上
// Models
#import "ChannelModel.h"
#import "GoodsRotationListModel.h"
// 第三方

static NSString *cellID = @"cellID";
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
    CGFloat _totalH_miaoS;                // 秒杀总高度
    CGFloat _totalH_prefecture;           // 新品/热卖专区总高度
    CGFloat _totalH_hotVideo;             // 最热视频总高度
    CGFloat _totalH_globalShopping;       // 全球购总高度
    CGFloat _totalH_videoAndLocalfeatures;// 视频地方特色总高度
}

@property (nonatomic, strong) UITableView           *myTableView;     // 显示整个界面tableveiw

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

- (UITableView *)myTableView{
    if (_myTableView == nil) {
        _myTableView = [[UITableView alloc] init];
        CGFloat tableViewY = self.topView.mj_h + self.topView.mj_y;
        CGFloat tableView_H = self.view.mj_h - 49 - 20 - 44;
        //tableView制定
        _myTableView.frame = CGRectMake(0, tableViewY, self.view.mj_w, tableView_H);
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        //隐藏tableView分割线
        _myTableView.separatorStyle = UITableViewCellEditingStyleNone;
        //隐藏滚动条
        _myTableView.showsVerticalScrollIndicator = NO;
       
    }
    return _myTableView;
}

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
        [_homeTableView registerNib:[UINib nibWithNibName:@"DBtableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
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
        _channelMenuListView = [[ChannelMenuListView alloc] initWithFrame:CGRectMake(0, 0, self.view.mj_w, Adapt(130))];
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
    _margin = Adapt(20);
    
    [self setUp_homeUI];
    
    self.locationManager = [[JFLocation alloc] init];
    _locationManager.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 隐藏navigationBar
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark —— 设置主页UI
- (void)setUp_homeUI{
    // 设置顶部视图
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(20);
        make.size.equalTo(CGSizeMake(self.view.mj_w, self.topView.mj_h));
    }];
    
    [self.view addSubview:self.myTableView];
}

#pragma mark —— tableView实现
//设置多少个数据组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([tableView isEqual:self.myTableView]) {
        return 9;
    }else{
        return 3;
    }
}

//此方法告诉tableview对应的组有多少个数据行。需要对每组依次进行设置，return几就表示几行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

/*
 告诉tableview每一行显示什么内容—— 每一行都是一个UITableViewCell或其子类，故只需要返回一个cell即可。其中的参数indexPath
 indexPath.section 表示组（从0开始
 indexPath.row 表示行（从0开始
 另外，给cell添加数据也是在此方法体中添加
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.myTableView]) {
        static NSString *cellIdentifier = @"Cell";
        //让cell不重用
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
//        cell.backgroundColor = DBRandomColor;
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
                [self setUp_miaoSView:cell];
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
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {

            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        
        return cell;
    }
}

//个方法返回指定的 row 的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.myTableView]) {
        switch (indexPath.section) {
            case 0:
                // 直播推荐视图
                return _totalH_anchorRecommendView+20;
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
                return _totalH_miaoS;
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
        return Adapt(105);
    }
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
                              @"token"        :kToken,
                              @"mallSpeciesId":@"1"
                              };
        [NetWorkHelper POST:URL_getChannelMenuList parameters:dic success:^(id  _Nonnull responseObject) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dataDic= dictionary[@"data"];
            NSArray *channelArray = dataDic[@"channelMenuList"];
            for (NSDictionary *dic in channelArray) {
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
            [self videoShow];
            break;
        case 1: // 海鲜
            [self seafoodShow];
            break;
        case 2: // 拼团
            [self spellGroup];
            break;
        case 3: // 限时秒杀
            [self limitedTimeSecondsKill];
            break;
        case 4: // 大邦
            break;
        case 5: // 全球购
            break;
        case 6: // 新品首发
            [self pushViewController:[NewProductLaunchViewController alloc]];
            break;
        default:
            break;
    }
}

- (void)videoShow{
    
}

- (void)seafoodShow{
    GoodsShowViewController *goodsShowView = [[GoodsShowViewController alloc] init];
    goodsShowView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:goodsShowView animated:NO];
}
- (void)spellGroup{
    SpellGroupViewController *vc = [[SpellGroupViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)limitedTimeSecondsKill{
    SecondsKillViewController *vc = [[SecondsKillViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)pushViewController:(UIViewController *)vc{
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark —— 新上
- (void)setupNew:(UITableViewCell *)cell{
    NSMutableArray *data = [NSMutableArray array];
    dispatch_group_t downloadGroup = dispatch_group_create();
    dispatch_group_enter(downloadGroup);
    [NetWorkHelper POST:URl_goods_rotation_list parameters:@{@"token":kToken} success:^(id  _Nonnull responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic= dictionary[@"data"];
        NSArray *goodsArray = dataDic[@"goodsRotationList"];
        for (NSDictionary *dic in goodsArray) {
            GoodsRotationListModel *model = [GoodsRotationListModel modelWithDictionary:dic];
            [data addObject:model];
        }
        dispatch_group_leave(downloadGroup);
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
        HomeBannerView *bannerView = [[HomeBannerView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 200)andGoodsArray:data];
        [cell addSubview:bannerView];
    });
}

#pragma mark —— 限时秒杀
- (void)setUp_miaoSView:(UITableViewCell *)cell{
    //头部便签
    UIView *titleView = [self titleImageOneString:@"h_maio" titleImageTwoString:@"h_tl" moreImageStrng:@"h_newshop_greater"];
    [cell addSubview:titleView];
    
    UIView *miaoS_BabyView;
    NSMutableArray *arr = [NSMutableArray new];
    for (int i = 0; i<2; i++) {
        //从xib中读出视图
        miaoS_BabyView = [self loadNibNamed:@"DBTimeLimitSecondsKill"];
        [arr addObject:miaoS_BabyView];
        [cell addSubview:miaoS_BabyView];
    }
    if (arr.count != 0) {
        [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:5 leadSpacing:10 tailSpacing:10];
        [arr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleView.mas_bottom).offset(0);
        }];
    }
    _totalH_miaoS = Adapt(titleView.mj_h + miaoS_BabyView.mj_h);
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
    titleView.backgroundColor = [UIColor redColor];
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
- (UIView *)loadNibNamed:(NSString *)string{    return  [[[NSBundle mainBundle]loadNibNamed:string owner:nil options:nil] firstObject];
}

// 标题视图封装
- (UIView *)titleImageOneString:(NSString *)oneString titleImageTwoString:(NSString *)twoString moreImageStrng:(NSString *)moreString{
    
    CGFloat imageY = 0;
    CGFloat margin = _margin;//边距
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.mj_w, Adapt(20))];
    // 第一个图标
    UIImageView *titleImageView_One = [[UIImageView alloc] initWithFrame:CGRectMake(margin, imageY, Adapt(30), Adapt(20))];
    titleImageView_One.image = [UIImage imageNamed:oneString];
    [mainView addSubview:titleImageView_One];
    // 第二个图标
    UIImageView *titleImageView_Two = [[UIImageView alloc] initWithFrame:CGRectMake((titleImageView_One.mj_x+margin+titleImageView_One.mj_w), imageY, Adapt(100), Adapt(20))];
    titleImageView_Two.image = [UIImage imageNamed:twoString];
    [mainView addSubview:titleImageView_Two];
    // 右边按钮
    CGFloat btnW = Adapt(100);
    CGFloat moreBtnX = self.view.mj_w - btnW - margin;
    UIButton *moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(moreBtnX, imageY, btnW, Adapt(20))];
    [moreBtn setImage:[UIImage imageNamed:moreString] forState:UIControlStateNormal];
    // 设置图片偏移量
    moreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, Adapt(80), 0, 0);
    [mainView addSubview:moreBtn];
    mainView.backgroundColor = [UIColor whiteColor];
    return mainView;
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
