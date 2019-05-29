//
//  DeptDetailsGoodsCategoryModel.m
//  DaBangVR
//
//  Created by mac on 2019/5/29.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "DeptDetailsGoodsCategoryModel.h"

@implementation DeptDetailsGoodsCategoryModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{@"deliveryGoodsVoList" : [DeptDetailsGoodsModel class]};
}

@end
