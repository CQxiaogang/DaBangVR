//
//  AppDelegate+AppService.m
//  DaBangVR
//
//  Created by mac on 2018/12/19.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "LoginViewController.h"
#import <UMSocialCore/UMSocialCore.h>

@implementation AppDelegate (AppService)

#pragma mark —— 初始化服务
- (void)initService{
    // 注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChange:) name:KNotificationLoginStateChange object:nil];
    
}

#pragma mark —— 初始化 window
-(void)initWindow{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = KWhiteColor;
    [self.window makeKeyAndVisible];
}

#pragma mark —— 初始化用户系统
- (void)initUserManager{
    // 让自定义的tabBarViewController做为根试图
    self.mainTabBar = [MainTabBarController new];
    self.window.rootViewController = self.mainTabBar;
    if ([userManager loadUserInfo]) {
        
    }
}

#pragma mark —— 友盟 初始化
-(void)initUMeng{
    // 打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    
    // 设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey: UMengKey];
    
    [self configUSharePlatforms];
}

#pragma mark —— 配置第三方
-(void)configUSharePlatforms{
    // QQ
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:kAppKey_Tencent appSecret:nil redirectURL:nil];
}

#pragma mark —— 登录状态处理
- (void)loginStateChange:(NSNotification *)notification{
    
    BOOL loginSuccess = [notification.object boolValue];
    if (loginSuccess) {// 登录成功加载主窗口
        
        self.mainTabBar = [MainTabBarController new];
        CATransition *animation = [CATransition animation];
        animation.type = @"cude"; // 动画类型
        animation.subtype = kCATransitionFromRight; // 动画方向
        animation.duration = 0.3f;
        self.window.rootViewController = self.mainTabBar;
        
        [kAppWindow.layer addAnimation:animation forKey:@"revealAnimation"];
        
    }else{
        RootNavigationController *loginNav = [[RootNavigationController alloc] initWithRootViewController:[LoginViewController new]];
        CATransition *animation = [CATransition animation];
        animation.type = @"fade"; // 设置动画的类型
        animation.subtype = kCATransitionFromRight; //设置动画方向
        animation.duration = 0.3f;
        
        self.window.rootViewController = loginNav;
        [kAppWindow.layer addAnimation:animation forKey:@"revealAnimation"];
    }
   
}
@end