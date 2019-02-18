//
//  DBLoginViewController.m
//  DaBangVR
//
//  Created by mac on 2018/11/28.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <TencentOpenAPI/TencentOAuth.h>
#import "MineHeaderView.h"
#import "LoginViewController.h"
#import "MainTabBarController.h"
#import "MobilePhoneNoLoginViewController.h"
#import "WXApi.h"

@interface LoginViewController ()

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
    
    [self presentViewController:phoneLoginVC animated:NO completion:nil];
}

#pragma mark —— QQ登陆
- (IBAction)QQLogin:(id)sender {
    [userManager login:kUserLoginTypeQQ params:nil completion:^(BOOL success, NSString * _Nullable des) {
        
        if (success) {
            DLog(@"成功");
        }else{
            MobilePhoneNoLoginViewController *vc = [[MobilePhoneNoLoginViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
            // 回调数据
            vc.phoneNumBlock = ^(NSString * _Nonnull string) {
                NSDictionary *dic = @{@"phone" : string};
                [userManager loginToServer:dic completion:nil];
                
            };
        }
        
    }];
}

//微信登陆
- (IBAction)wechatLogin:(id)sender {
    
    if([WXApi isWXAppInstalled]){//判断用户是否已安装微信App
        
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.state = @"wx_oauth_authorization_state";//用于保持请求和回调的状态，授权请求或原样带回
        req.scope = @"snsapi_userinfo";//授权作用域：获取用户个人信息
        
        [WXApi sendReq:req];//发起微信授权请求
        
        [userManager login:kUserLoginTypeWeChat completion:^(BOOL success, NSString * _Nonnull des) {
            if (success) {
                DLog(@"成功");
            }else{
                MobilePhoneNoLoginViewController *vc = [[MobilePhoneNoLoginViewController alloc] init];
                [self presentViewController:vc animated:YES completion:nil];
                // 回调数据
                vc.phoneNumBlock = ^(NSString * _Nonnull string) {
                    NSDictionary *dic = @{@"phone" : string};
                    [userManager loginToServer:dic completion:nil];
                };
            }
        }];
        
    }else{
        
        //提示：未安装微信应用或版本过低
    }
}

//微博登陆
- (IBAction)weiboLogin:(id)sender {
}

@end
