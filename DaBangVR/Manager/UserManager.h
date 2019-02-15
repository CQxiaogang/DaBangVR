//
//  UserManager.h
//  DaBangVR
//
//  Created by mac on 2018/12/20.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "UtilsMacros.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,UserLoginType){
    kUserLoginTypeUnknow = 0, // 未知
    kUserLoginTypeWeChat,     // 微信登录
    kUserLoginTypeQQ,         // QQ登录
    kUserLoginTypeWeibo,      // 微博
    kUserLoginTypeMobilePhone,// 电话
};
// block
typedef void (^ _Nullable loginBlock)(BOOL success,NSString * _Nullable  des);

// 宏定义
#define isLogin [UserManager sharedUserManager].isLogined
#define curUser [UserManager sharedUserManager].curUserInfo
#define userManager [UserManager sharedUserManager]

@protocol UserManagerDelegate <NSObject>

- (void)comeBack;

@end

@interface UserManager : NSObject
// 单例
SINGLETON_FOR_HEADER(UserManager)
// 用户信息
@property (nonatomic, strong) UserInfo *__nullable curUserInfo;
// 登录类型
@property (nonatomic, assign) UserLoginType *loginType;
// 是已登陆
@property (nonatomic, assign) BOOL isLogined;

#pragma mark —— 登录相关 
/**
 三方登录
 @param loginType 登录方式
 @param completion 回调
 */
-(void)login:(UserLoginType )loginType completion:(loginBlock)completion;

/**
 带参登录
 @param loginType 登录方式
 @param params 参数，手机登录需要
 @param completion 回调
 */
-(void)login:(UserLoginType )loginType params:(NSDictionary *__nullable)params completion:(loginBlock)completion;

/**
 退出登录
 @param completion 回调
 */
- (void)logout:(loginBlock)completion;

/**
 加载缓存用户数据
 @return 是否成功
 */
-(BOOL)loadUserInfo;

// 登录服务器
- (void)loginToServer:(NSDictionary *__nullable)params completion:(loginBlock)completion;

@end

NS_ASSUME_NONNULL_END
