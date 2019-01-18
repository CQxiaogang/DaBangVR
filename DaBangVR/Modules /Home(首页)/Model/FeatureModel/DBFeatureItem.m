//
//  DBFeatureItem.m
//  Demo
//
//  Created by mac on 2018/12/28.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "DBFeatureItem.h"
#import "MJExtension.h"

@implementation DBFeatureItem

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"goodsSpecList" : @"DBFeatureList"
             };
}

@end
