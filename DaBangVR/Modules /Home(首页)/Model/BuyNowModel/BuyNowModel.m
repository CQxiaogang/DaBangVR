//
//  BuyNowModel.m
//  DaBangVR
//
//  Created by mac on 2019/1/23.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "BuyNowModel.h"

@implementation BuyNowModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"productInfoVo"    : @"BuyNowOfProductInfoModel",
             @"receivingAddress" : @"BuyNowOfUserAddressModel",
             @"goodsVo"          : @"BuyNowOfGoodVoModel"
             };
}



@end
