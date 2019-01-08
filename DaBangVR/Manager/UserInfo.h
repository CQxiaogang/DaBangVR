//
//  UserInfo.h
//  DaBangVR
//
//  Created by mac on 2018/12/20.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,UserGender){
    UserGenderUnKnow = 0,
    UserGenderMale,  // 男
    UserGenderFemale,// 女
};

@interface UserInfo : NSObject

@property (nonatomic, copy)NSString *aId;
@property (nonatomic, copy)NSString *token;
// openId
@property (nonatomic, copy)NSString *uAccount;
@property (nonatomic, copy)NSString *uFanse;
@property (nonatomic, copy)NSString *uFollow;
// 头像
@property (nonatomic, copy)NSString *uIcon;
// 用户ID
@property (nonatomic, assign)long long userid;
// 登陆方式
@property (nonatomic, copy)NSString *uLoginType;
// 用户名字
@property (nonatomic, copy)NSString *uName;
@property (nonatomic, copy)NSString *uPraise;
@property (nonatomic, copy)NSString *uTitle;
// 性别
@property (nonatomic,assign) UserGender sex;
@end

