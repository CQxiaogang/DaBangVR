//
//  DBLoginViewController.m
//  DaBangVR
//
//  Created by mac on 2018/11/28.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <TencentOpenAPI/TencentOAuth.h>
#import "MineHeaderView.h"
#import "MineViewController.h"
#import "LoginViewController.h"
#import "MainTabBarController.h"
#import "MobilePhoneNoLoginViewController.h"

@interface LoginViewController ()<TencentSessionDelegate>

@property (nonatomic, strong)TencentOAuth *tencentOAuth;

@property (nonatomic, strong)NSDictionary *userDic;//装用户的信息


@end

@implementation LoginViewController

#pragma mark —— 懒加载

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

//手机登陆
- (IBAction)phoneLogin:(id)sender {
    
    MobilePhoneNoLoginViewController *phoneLoginVC = [[MobilePhoneNoLoginViewController alloc] init];
    
    [self presentViewController:phoneLoginVC animated:YES completion:nil];
}

#pragma mark —— QQ登陆
- (IBAction)QQLogin:(id)sender {
    [userManager login:kUserLoginTypeQQ completion:^(BOOL success, NSString * _Nonnull des) {
        if (success) {
            DLog(@"成功");
        }else{
            DLog(@"失败");
        }
    }];
}

#pragma mark —— 腾讯 Delegate 
// 登录成功回调
- (void)tencentDidLogin{
    
}

//获取用户信息
-(void)getUserInfoResponse:(APIResponse *)response{
    // QQ头像地址
    NSString *imageStr = response.jsonResponse[@"figureurl_qq_2"];
    // QQ昵称
    NSString *userName = response.jsonResponse[@"nickname"];
    //网络请求
    _userDic = @{@"uAccount":_tencentOAuth.openId,
                 @"icon"    :imageStr,
                 @"uName"   :userName,
                 @"type"    :@"QQ"
                 };
}

// ⾮网络错误导致登录失败:
- (void)tencentDidNotLogin:(BOOL)cancelled{
    if (cancelled) {
        NSLog(@"取消登录");
    }
}

//网络错误导致登录失败
-(void)tencentDidNotNetWork
{
    NSLog(@"tencentDidNotNetWork");
}

//微信登陆
- (IBAction)wechatLogin:(id)sender {
    [userManager login:kUserLoginTypeWeChat completion:^(BOOL success, NSString * _Nonnull des) {
        if (success) {
            DLog(@"成功");
        }else{
            DLog(@"失败");
        }
    }];
}

//微博登陆
- (IBAction)weiboLogin:(id)sender {
}

-(void)showError:(NSString *)errorMsg{
    
}

@end
