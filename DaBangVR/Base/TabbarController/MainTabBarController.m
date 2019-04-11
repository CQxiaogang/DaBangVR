//
//  DBTabBarViewController.m
//  DaBangVR
//
//  Created by mac on 2018/11/17.
//  Copyright © 2018 DaBangVR. All rights reserved.
//
#import "DBTabBar.h"
#import "LiveViewController.h"
#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "DBShortVideoViewController.h"
#import "PagingViewController.h"
#import "MineViewController.h"
#import "ShouldBeginLiveViewController.h"
#import "GoodAttributesView.h"

#define kSWidth [UIScreen mainScreen].bounds.size.width

#import "TPCSpringMenu.h"
#import "TPCSpringMenu.h"

@interface MainTabBarController ()<DBTabBarDelegate , UITabBarControllerDelegate, TPCSpringMenuDataSource, TPCSpringMenuDelegate>

{
    NSUInteger _selectedIndex;
}

@property (weak, nonatomic) TPCSpringMenu *menu;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllChildViewControllers];
    //把自定义的tabBar替换掉系统tabBar
    DBTabBar *customTabBar = [DBTabBar new];
    //成为代理对象
    customTabBar.myDelegate = self;
    self.delegate = self;
    //注意：因为是系统的tabBar是readonly的，所以用KVO方法替换
    [self setValue:customTabBar forKey:@"tabBar"];
    //tabBar不透明
    self.tabBar.translucent = NO;
    
    [self setupTPCSpringMenu];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.hidesBottomBarWhenPushed = YES;
}

#pragma mark - 自定义方法初始化所有的子控制器
- (void)setupAllChildViewControllers{
    HomeViewController *homeVC = [HomeViewController new];
    [self addChildViewController:homeVC title:@"首页" imageName:@"h_homepage" selectedImageName:@"h_homepage_select"];
    
    LiveViewController *liveVC = [LiveViewController new];
    [self addChildViewController:liveVC title:@"直播" imageName:@"h_LiveBroadcast" selectedImageName:@"h_LiveBroadcast_select"];
    
    DBShortVideoViewController *shortVideoVC = [DBShortVideoViewController new];
    [self addChildViewController:shortVideoVC title:@"短视频" imageName:@"h_ShortVideo" selectedImageName:@"h_ShortVideo_select"];

    MineViewController *myVC = [MineViewController new];
    [self addChildViewController:myVC title:@"我的" imageName:@"h_Member" selectedImageName:@"h_Member_select"];
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    // 设置选中的图标
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    // 2.包装一个导航控制器
    RootNavigationController *nav = [[RootNavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
}
// 设置弹出菜单
- (void)setupTPCSpringMenu{
    TPCItem *item1 = [TPCItem itemWithImage:[UIImage imageNamed:@"per_center_broadcast"] title:@"开直播"];
    TPCItem *item2 = [TPCItem itemWithImage:[UIImage imageNamed:@"per_center_ShortVideo"] title:@"短视频"];
    TPCItem *item3 = [TPCItem itemWithImage:[UIImage imageNamed:@"per_center_dynamics"] title:@"发动态"];
    NSArray *items = @[item1, item2, item3];
    
    TPCSpringMenu *menu = [TPCSpringMenu menuWithItems:items];
    // 按钮文字颜色
    menu.buttonTitleColor = KBlackColor;
    // 按钮行数
    menu.columns = 3;
    // 最后一个按钮与底部的距离
    menu.spaceToBottom = 100;
    // 按钮半径（只支持圆形图片，非圆形图片以宽度算）
    menu.buttonDiameter = 50;
    // 允许点击隐藏menu
    menu.enableTouchResignActive = YES;
    menu.dataSource = self;
    menu.delegate = self;
    [self.view addSubview:menu];
    _menu = menu;
}

#pragma mark - DBTabBar delegate
- (void)tabBarDidClickPlusButton:(DBTabBar *)tabBar {
    [_menu becomeActive];
}

#pragma mark TPCSpringMenuDataSource
- (UIButton *)buttonToChangeActiveForSpringMenu:(TPCSpringMenu *)menu
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, KScreenW, 40);
    UIImage *img = [UIImage imageNamed:@"per_center_button"];
    [btn setImage:img forState:UIControlStateNormal];
    
    return btn;
}

- (UIView *)backgroundViewOfSpringMenu:(TPCSpringMenu *)menu
{
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = KWhiteColor;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"compose_slogan"]];
    imageView.bounds = CGRectMake(0, 0, 154, 48);
    imageView.center = CGPointMake(self.view.bounds.size.width * 0.5, 100);
    [view addSubview:imageView];
    
    return view;
}
#pragma mark TPCSpringMenuDelegate
- (void)springMenu:(TPCSpringMenu *)menu didClickBottomActiveButton:(UIButton *)button
{
    
}

- (void)springMenu:(TPCSpringMenu *)menu didClickButtonWithIndex:(NSInteger)index
{
//    [self.MDelegate didClickButtonWithIndex:index];
    if (index==0) {
        ShouldBeginLiveViewController *vc = [ShouldBeginLiveViewController new];
        [self presentViewController:vc animated:NO completion:nil];
    }
}

@end
