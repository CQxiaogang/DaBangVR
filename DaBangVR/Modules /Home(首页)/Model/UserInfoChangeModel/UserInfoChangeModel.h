//
//  UserInfoChangeModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/25.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfoChangeModel : NSObject

@property (nonatomic, copy) NSString *id;
// 国家
@property (nonatomic, copy) NSString *receivingCountry;
// 省
@property (nonatomic, copy) NSString *province;
// 市
@property (nonatomic, copy) NSString *city;
// 县
@property (nonatomic, copy) NSString *area;
// 详细地址
@property (nonatomic, copy) NSString *address;
// 邮编
@property (nonatomic, copy) NSString *zipCode;
// 用户名字
@property (nonatomic, copy) NSString *consigneeName;
// 电话号码
@property (nonatomic, copy) NSString *consigneePhone;
// 默认地址 1/0
@property (nonatomic, copy) NSString *isDefault;
// 用户 ID
@property (nonatomic, copy) NSString *userId;

@end

NS_ASSUME_NONNULL_END
