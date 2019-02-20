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
    
    [WXApi handleOpenURL:url delegate:nil];
    [[UMSocialManager defaultManager] handleOpenURL:url];
    return YES;
}

- (void)onResp:(BaseResp *)resp{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d",resp.errCode];
    NSString *strTitle;
    NSString *strNote;
    if ([resp isKindOfClass:[PayResp class]]) {
        // 支付返回结果,实际支付结果需要去微信服务器端查询
        strTitle = @"支付结果";
    }
    switch (resp.errCode) {
        case WXSuccess:{
            strMsg = @"支付成功,可以进行洗车";
            strNote = @"success";
            
            break;
        }
        case WXErrCodeUserCancel:{
            strMsg = @"支付已取消";
            strNote = @"cancel";
            break;
        }
        case WXErrCodeSentFail: {
            strMsg = @"支付失败,请重新支付";
            strNote = @"fail";
            break;
        }
        default:{
            strMsg = @"支付失败";
            strNote = @"fail";
            break;
        }
    }
}

@end
