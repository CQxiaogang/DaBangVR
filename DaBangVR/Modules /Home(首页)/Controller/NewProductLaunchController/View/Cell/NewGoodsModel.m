//
//  NewGoodsModel.m
//  DaBangVR
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "NewGoodsModel.h"

@implementation NewGoodsModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"data":[GoodsDetailsModel class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id",
             @"data":@"page.data",
             @"count":@"page.count"
             };
}

@end
