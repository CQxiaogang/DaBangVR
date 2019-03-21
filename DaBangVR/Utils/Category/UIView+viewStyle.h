//
//  UIView+viewStyle.h
//  DaBangVR
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (viewStyle)

+ (UIView *)viewOfStyle:(UIView *)view borderColor:(UIColor *)borderColor fillColor:(UIColor *)fillColor;

@end

NS_ASSUME_NONNULL_END
