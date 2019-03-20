//
//  UserInfoModel.h
//  DaBangVR
//
//  Created by mac on 2019/3/20.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoModel : UIView
// 签名
@property (nonatomic, copy) NSString *autograph;
// 绑定手机
@property (nonatomic, copy) NSString *bindMobile;
// 粉丝
@property (nonatomic, copy) NSString *fansNumber;
@property (nonatomic, copy) NSString *followNumber;
// 头像
@property (nonatomic, copy) NSString *headUrl;
// 手机号
@property (nonatomic, copy) NSString *mobile;
// 昵称
@property (nonatomic, copy) NSString *nickName;
// 点赞数量
@property (nonatomic, copy) NSString *praisedNumber;
// 性别
@property (nonatomic, copy) NSString *sex;
@end

NS_ASSUME_NONNULL_END
