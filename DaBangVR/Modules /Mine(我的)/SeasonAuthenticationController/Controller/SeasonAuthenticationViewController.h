//
//  SeasonAuthenticationViewController.h
//  DaBangVR
//
//  Created by mac on 2019/4/2.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SeasonAuthenticationViewController : RootViewController
/** 认证按钮 */
@property (weak, nonatomic) IBOutlet UIButton *authemticationButton;
//获取验证码
@property (weak, nonatomic) IBOutlet UIButton *getVerificationCodeBtn;

@end

NS_ASSUME_NONNULL_END
