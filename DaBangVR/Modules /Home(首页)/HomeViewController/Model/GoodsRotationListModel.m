//
//  GoodsRotationListModel.m
//  DaBangVR
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "GoodsRotationListModel.h"

@implementation GoodsRotationListModel

+ (id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName{
    if ([propertyName isEqualToString:@"ID"]) return @"id";
    return [propertyName mj_underlineFromCamel];
}

@end
