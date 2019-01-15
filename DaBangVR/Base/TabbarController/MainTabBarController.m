//
//  DBTabBarViewController.m
//  DaBangVR
//
//  Created by mac on 2018/11/17.
//  Copyright © 2018 DaBangVR. All rights reserved.
//
#import "DBTabBar.h"
#import "MineViewController.h"
#import "DBLiveViewController.h"
#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "DBShortVideoViewController.h"

#define kSWidth [UIScreen mainScreen].bounds.size.width


@interface MainTabBarController ()<DBTabBarDelegate , UITabBarControllerDelegate>

{
    NSUInteger _selectedIndex;
}

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
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.hidesBottomBarWhenPushed = YES;
}

#pragma mark - 自定义方法初始化所有的子控制器
- (void)setupAllChildViewControllers{
    HomeViewController *homeVC = [HomeViewController new];
    [self addChildViewController:homeVC title:@"首页" imageName:@"h_homepage" selectedImageName:@"h_homepage_select"];
    
    DBLiveViewController *liveVC = [DBLiveViewController new];
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

#pragma mark - DBTabBar delegate
- (void)tabBarDidClickPlusButton:(DBTabBar *)tabBar {
    NSLog(@"点击，在这里实现代理操作，比如跳转一个控制器");
}

//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//    if ([viewController.tabBarItem.title isEqualToString:@"我的"]){
//        if ([DBLoginModel sharedLoginModel].isLogin == NO) {
//            /**
//             在为登陆的情况下，当前tabBarItem.title是不是"我的"，是"我的"就跳转到登陆界面
//             **/
//                
//            DBLoginViewController *loginVC = [DBLoginViewController new];
//            
//            [self presentViewController:loginVC animated:YES completion:nil];
//            
//            return NO;
//        }
//    }
//    return YES;
//}
// 隐藏tabBar

@end
