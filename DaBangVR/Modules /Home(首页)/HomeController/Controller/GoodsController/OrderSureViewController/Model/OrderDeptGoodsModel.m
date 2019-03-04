//
//  OrderSureDeptGoodsModel.m
//  DaBangVR
//
//  Created by mac on 2019/1/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "OrderDeptGoodsModel.h"

@implementation OrderDeptGoodsModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"goodsList"      : [OrderGoodsModel class]
             };
}

@end
