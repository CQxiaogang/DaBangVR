//
//  DeptDetailsGoodsModel.m
//  DaBangVR
//
//  Created by mac on 2019/5/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "DeptDetailsGoodsModel.h"

@implementation DeptDetailsGoodsModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"specList"               : @"DeptDetailsGoodsSpecList",
             @"deliveryProductInfoList":@"DeptDetailsGoodsDeliveryProductInfoListModel"
             };
}

@end
