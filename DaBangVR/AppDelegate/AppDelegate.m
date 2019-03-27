//
//  DBAppDelegate.m
//  DaBangVR
//
//  Created by mac on 2018/11/17.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "AppDelegate.h"
#import "UMSocialWechatHandler.h"
#import <UMSocialCore/UMSocialCore.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "PaymentManager.h"
#import <PLMediaStreamingKit/PLMediaStreamingKit.h>
#import "EntertainmentViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //初始化服务
    [self initService];
    
    //初始化 window
    [self initWindow];
    
    //初始化用户系统
    [self initUserManager];
    
    //UMeng初始化
    [self initUMeng];
    
    //微信初始化
    [self initWX];
    
    //七牛云初始化
    [PLStreamingEnv initEnv];
    
    return YES;
}
// 真机友盟登录，不走回调解决方法
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    [[UMSocialManager defaultManager] handleOpenURL:url];
    [WXApi handleOpenURL:url delegate:[PaymentManager sharedPaymentManager]];
    return YES;
}

-(void)didClickButtonWithIndex:(NSInteger)index{
   
}

@end
