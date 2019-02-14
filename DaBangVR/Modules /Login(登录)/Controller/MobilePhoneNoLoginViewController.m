//
//  DBphoneLoginViewController.m
//  DaBangVR
//
//  Created by mac on 2018/11/28.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "MobilePhoneNoLoginViewController.h"
#import <SMS_SDK/SMSSDK.h>

@interface MobilePhoneNoLoginViewController ()

@end

@implementation MobilePhoneNoLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)passwordAction:(id)sender {
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.accountNunber.text zone:@"86" template:nil result:^(NSError *error) {
        if (error) {
            
            NSLog(@"提交手机号失败%@",error);
            
        }else{
            
            NSLog(@"提交手机号成功");
            
        }
    }];
    
}
- (IBAction)loginAction:(id)sender {
    self.phoneNumBlock(self.accountNunber.text);
    [SMSSDK commitVerificationCode:self.password.text phoneNumber:self.accountNunber.text zone:@"86" result:^(NSError *error) {
        
        if (error) {
            NSLog(@"验证码失败%@",error);
        }else{
            
//            NSDictionary *dic = @{
//                                  @"nickName" :@"",
//                                  @"loginType":@"phone",
//                                  @"icon"     :@"",
//                                  @"openId"   :weakself.accountNunber.text
//                                  };
            
            self.phoneNumBlock(self.accountNunber.text);
            
//            [NetWorkHelper POST:URl_login parameters:dic success:^(id  _Nonnull responseObject) {
//
//            } failure:^(NSError * _Nonnull error) {
//
//            }];
            
            NSLog(@"验证码成功");
            
        }
        
    }];
}
- (IBAction)comeBack:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
