//
//  BSFitdpiUtil.h
//  DaBangVR
//
//  Created by mac on 2018/12/7.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Adapt(floatValue) [BSFitdpiUtil adaptiveFontSize:floatValue]

NS_ASSUME_NONNULL_BEGIN

@interface BSFitdpiUtil : NSObject

/**
 以屏幕宽度为固定比例关系，来计算对应的值。假设：参考屏幕宽度375，floatV=10；当前屏幕宽度为750时，那么返回的值为20
 @param floatV 参考屏幕下的宽度值
 @return 当前屏幕对应的宽度值
 */
+ (CGFloat)adaptiveFontSize:(CGFloat)floatV;

@end

NS_ASSUME_NONNULL_END
