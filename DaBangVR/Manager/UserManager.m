//
//  UserManager.m
//  DaBangVR
//
//  Created by mac on 2018/12/20.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "UserManager.h"
#import <UMSocialCore/UMSocialCore.h>
#import "MobilePhoneNoLoginViewController.h"

@interface UserManager()

@end

@implementation UserManager

SINGLETON_FOR_CLASS(UserManager)

static UMSocialUserInfoResponse *resp;

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
                resp = result;
                //网络请求
                NSDictionary *params = @{@"openId"   : resp.openid,
                                         @"loginType": @"QQ"
                                         };
                [self loginToServer:params completion:completion];
            }
        }];
    }
}

#pragma mark —— 登录服务器
- (void)loginToServer:(NSDictionary *)params completion:(loginBlock)completion{
    NSMutableDictionary *mutableDic = [NSMutableDictionary new];
    DLog(@"bool is %d",_isFirst);
    DLog(@"bool is %@",resp.name);
    if (isFirstEnter) {
        [mutableDic addEntriesFromDictionary:params];;
        params = @{@"openId"   : resp.openid,
                   @"icon"     : resp.iconurl,
                   @"nickName" : resp.name,
                   @"loginType": @"QQ"
                   };
        [mutableDic addEntriesFromDictionary:params];
    }else{
        [mutableDic addEntriesFromDictionary:params];
    }
    
    // 调用后台
    [NetWorkHelper POST:URl_login parameters:mutableDic success:^(id  _Nonnull responseObject) {
        [self LoginSuccess:responseObject completion:completion];
    } failure:^(NSError * _Nonnull error) {
        DLog(@"error is %@",error);
    }];
}

#pragma mark —— 登录成功数据处理
-(void)LoginSuccess:(id )responseObject completion:(loginBlock)completion{
    
    NSString *string = [NSString stringWithFormat:@"%@",KJSONSerialization(responseObject)[@"errno"]];
    if ([string isEqualToString:@"1"]) {
        // 1.跳转手机绑定
        if (completion) {
            completion(NO,nil);
        }
    }else{
        NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
        self.curUserInfo = [UserInfo modelWithDictionary:data[@"user"]];
        [self saveUserInfo];
        self.isLogined = YES;
        if (completion) {
            completion(YES,nil);
        }
        KPostNotification(KNotificationLoginStateChange, @YES);
    }
    
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
