//
//  UIColor+category.h
//  DaBangVR
//
//  Created by mac on 2018/11/19.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (category)

+ (UIColor *)lightGreen;

+ (UIColor*)colorWithHexString:(NSString *)hexString;

+ (UIColor *)randomColor;

@end

NS_ASSUME_NONNULL_END
