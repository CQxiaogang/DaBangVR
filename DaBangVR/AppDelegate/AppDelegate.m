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
    
    return YES;
}
// 真机友盟登录，不走回调解决方法
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{

    if ([[UMSocialManager defaultManager] handleOpenURL:url options:options]) {
        return [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    }
    return [WXApi handleOpenURL:url delegate:nil];;
}

-(void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        switch(response.errCode){
            caseWXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");
                break;
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                break;
        }
    }
}
@end
