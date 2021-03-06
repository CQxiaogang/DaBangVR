//
//  DBphoneLoginViewController.h
//  DaBangVR
//
//  Created by mac on 2018/11/28.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MobilePhoneNoLoginViewController : RootViewController
@property (weak, nonatomic) IBOutlet UILabel *password;
@property (weak, nonatomic) IBOutlet UITextField *accountNunber;

@property (nonatomic, assign) void (^phoneNumBlock)(NSString *string);

@end

NS_ASSUME_NONNULL_END
