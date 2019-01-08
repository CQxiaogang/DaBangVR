//
//  BSFitdpiUtil.m
//  DaBangVR
//
//  Created by mac on 2018/12/7.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "BSFitdpiUtil.h"

@implementation BSFitdpiUtil

+ (CGFloat)adaptiveFontSize:(CGFloat)floatV;
{
    return floatV * [UIScreen mainScreen].bounds.size.width/375.0;
}

@end
