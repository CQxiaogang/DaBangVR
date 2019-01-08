//
//  DBAppDelegate.m
//  DaBangVR
//
//  Created by mac on 2018/11/17.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "AppDelegate.h"

#import <TencentOpenAPI/TencentOAuth.h>

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
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    return [TencentOAuth HandleOpenURL:url];
}

@end
