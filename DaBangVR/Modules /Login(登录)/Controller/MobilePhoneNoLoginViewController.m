//
//  DBphoneLoginViewController.m
//  DaBangVR
//
//  Created by mac on 2018/11/28.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "MobilePhoneNoLoginViewController.h"
#import "LoginManger.h"
#import <SMS_SDK/SMSSDK.h>

@interface MobilePhoneNoLoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *getVerificationCodeBtn;
/** 倒计时 */
@property (nonatomic, assign) NSInteger timeOut;
@end

@implementation MobilePhoneNoLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)passwordAction:(id)sender {
    [self sentPhoneCodeTimeMethod];
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.accountNunber.text zone:@"86" template:nil result:^(NSError *error) {
        if (error) {
            NSLog(@"提交手机号失败%@",error);
        }else{
            NSLog(@"提交手机号成功");
        }
    }];
    
}
- (IBAction)loginAction:(id)sender {
    [SMSSDK commitVerificationCode:self.password.text phoneNumber:self.accountNunber.text zone:@"86" result:^(NSError *error) {
        if (error) {
            NSLog(@"验证码失败%@",error);
        }else{
            isBound = YES;
            self.phoneNumBlock(self.accountNunber.text);
        }
    }];
}
- (IBAction)comeBack:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
/**
 倒计时方法 在点击获取验证码按钮的方法里调用此方法即可实现, 需要在倒计时里修改按钮相关的请在此方法里yourButton修改
 */
- (void)sentPhoneCodeTimeMethod{
    kWeakSelf(self);
    //倒计时时间 - 60S
    __block NSInteger timeOut = 59;
    self.timeOut = timeOut;
    //执行队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //计时器 -》 dispatch_source_set_timer自动生成
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (timeOut <= 0) {
            dispatch_source_cancel(timer);
            //主线程设置按钮样式
            dispatch_async(dispatch_get_main_queue(), ^{
                // 倒计时结束
                [weakself.getVerificationCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [weakself.getVerificationCodeBtn setEnabled:YES];
                [weakself.getVerificationCodeBtn setUserInteractionEnabled:YES];
            });
        }else{
            //开始计时
            //剩余秒数 seconds
            NSInteger seconds = timeOut % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.1ld", seconds];
            //主线程设置按钮样式
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *title = [NSString stringWithFormat:@"%@",strTime];
                [weakself.getVerificationCodeBtn setTitle:title forState:UIControlStateNormal];
                [weakself.getVerificationCodeBtn setUserInteractionEnabled:NO];
                [weakself.getVerificationCodeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            });
            timeOut--;
        }
    });
    dispatch_resume(timer);
}
@end
