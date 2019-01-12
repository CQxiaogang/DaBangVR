//
//  UserManager.m
//  DaBangVR
//
//  Created by mac on 2018/12/20.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "UserManager.h"
#import <UMSocialCore/UMSocialCore.h>

@interface UserManager()

@end

@implementation UserManager

SINGLETON_FOR_CLASS(UserManager)


#pragma mark —— 第三方登录
-(void)login:(UserLoginType)loginType completion:(loginBlock)completion{
    [self login:loginType params:nil completion:completion];
}

#pragma mark —— 带参数登录

-(void)login:(UserLoginType)loginType params:(NSDictionary *)params completion:(loginBlock)completion{
    
    //友盟登录类型
    UMSocialPlatformType platFormType;
    
    if (loginType == kUserLoginTypeQQ) {
        platFormType = UMSocialPlatformType_QQ;
    }else if (loginType == kUserLoginTypeWeChat){
        platFormType = UMSocialPlatformType_WechatSession;
    }else if (loginType == kUserLoginTypeWeibo){
        platFormType = UMSocialPlatformType_Sina;
    }else{
        platFormType = UMSocialPlatformType_UnKnown;
    }
    
    // 第三方登录
    if (loginType != kUserLoginTypeUnknow) {
        [[UMSocialManager defaultManager] getUserInfoWithPlatform:platFormType currentViewController:nil completion:^(id result, NSError *error) {
            if (error) {
                if (completion) {
                    completion(NO,error.localizedDescription);
                }
            }else{
                UMSocialUserInfoResponse *resp = result;
                
                //网络请求
                NSDictionary *params = @{@"uAccount": resp.openid,
                                      @"icon"    : resp.iconurl,
                                      @"uName"   : resp.name,
                                      @"type"    : @"QQ"
                                      };
                [self loginToServer:params completion:completion];
            }
        }];
    }
}

#pragma mark —— 登录服务器
- (void)loginToServer:(NSDictionary *)params completion:(loginBlock)completion{
//    [NetWorkHelper POST:NSStringFormat(@"%@%@",URL_main,URL_user_login) parameters:params success:^(id responseObject) {
//        [self LoginSuccess:responseObject completion:completion];
//    } failure:^(NSError *error) {
//        if (completion) {
//            completion(NO,error.localizedDescription);
//        }
//    }];
}

#pragma mark —— 登录成功数据处理
-(void)LoginSuccess:(id )responseObject completion:(loginBlock)completion{
        
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    self.curUserInfo = [UserInfo modelWithDictionary:dictionary];
    [self saveUserInfo];
    self.isLogined = YES;
    if (completion) {
        completion(YES,nil);
    }
    KPostNotification(KNotificationLoginStateChange, @YES);
}

#pragma mark —— 储存用户信息
- (void)saveUserInfo{
    if (self.curUserInfo) {
        YYCache *cache = [[YYCache alloc] initWithName:KUserCacheName];
        NSDictionary *dic = [self.curUserInfo modelToJSONObject];
        [cache setObject:dic forKey:KUserModelCache];
    }
}

#pragma mark —— 加载缓存的用户信息
- (BOOL)loadUserInfo{
    YYCache *cache = [[YYCache alloc] initWithName:KUserCacheName];
    NSDictionary *userDic = (NSDictionary *)[cache objectForKey:KUserModelCache];
    if (userDic) {
        self.curUserInfo = [UserInfo modelWithJSON:userDic];
        return YES;
    }
    
    return NO;
}

#pragma mark —— 退出登录 
-(void)logout:(loginBlock)completion{
    // 应用角标设置
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    
    self.curUserInfo = nil;
    self.isLogined = NO;
    
    // 移除缓存
    YYCache *cache = [[YYCache alloc] initWithName:KUserCacheName];
    [cache removeAllObjectsWithBlock:^{
        if (completion) {
            completion(YES,nil);
        }
    }];
    
    
    KPostNotification(KNotificationLoginStateChange, @NO);
}
@end
