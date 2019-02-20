//
//  BuyNowModel.m
//  DaBangVR
//
//  Created by mac on 2019/1/23.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "OrderSureModel.h"

@implementation OrderSureModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"receivingAddress" : [UserAddressModel class],
             @"deptGoodsList"    : [OrderDeptGoodsModel class]
             };
}



@end
