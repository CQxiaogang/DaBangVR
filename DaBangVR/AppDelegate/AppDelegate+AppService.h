//
//  AppDelegate+AppService.h
//  DaBangVR
//
//  Created by mac on 2018/12/19.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (AppService)

//初始化服务
-(void)initService;

//初始化 window
-(void)initWindow;

//初始化用户系统
-(void)initUserManager;

//初始化 UMeng
-(void)initUMeng;

@end

NS_ASSUME_NONNULL_END
