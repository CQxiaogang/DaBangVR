//
//  BuyNowOfUserAddressModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/23.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserAddressModel : NSObject

@property(nonatomic, strong) NSString *id;
//国家
@property(nonatomic, strong) NSString *receivingCountry;
//省
@property(nonatomic, strong) NSString *province;
//城市
@property(nonatomic, strong) NSString *city;
//区域
@property(nonatomic, strong) NSString *area;
//地址
@property(nonatomic, strong) NSString *address;
//邮政编码
@property(nonatomic, strong) NSString *zipCode;
//收货人的名字
@property(nonatomic, strong) NSString *consigneeName;
//收货人手机号
@property(nonatomic, strong) NSString *consigneePhone;
//默认的
@property(nonatomic, strong) NSString *isDefault;
//状态
@property(nonatomic, strong) NSString *state;
//用户 ID
@property(nonatomic, strong) NSString *userId;
@end

NS_ASSUME_NONNULL_END
