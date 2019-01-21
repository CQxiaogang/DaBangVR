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
// 个性签名
@property (nonatomic, copy)NSString *autograph;
// 粉丝数量
@property (nonatomic, copy)NSString *fansNumber;
@property (nonatomic, copy)NSString *followNumber;
// 头像
@property (nonatomic, copy)NSString *headUrl;
@property (nonatomic, copy)NSString *uFollow;
@property (nonatomic, copy)NSString *id;
// 登陆类型
@property (nonatomic, copy)NSString *loginType;
@property (nonatomic, copy)NSString *mobile;
// 昵称
@property (nonatomic, copy)NSString *nickName;
@property (nonatomic, copy)NSString *openId;
// 点赞数
@property (nonatomic, copy)NSString *praisedNumber;
@property (nonatomic,assign) UserGender sex;
@end

