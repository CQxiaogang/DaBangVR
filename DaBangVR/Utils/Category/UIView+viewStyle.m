//
//  UIView+viewStyle.m
//  DaBangVR
//
//  Created by mac on 2019/3/21.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "UIView+viewStyle.h"

@implementation UIView (viewStyle)

+ (UIView *)viewOfStyle:(UIView *)view borderColor:(nonnull UIColor *)borderColor fillColor:(nonnull UIColor *)fillColor{
    [view updateCornerRadius:^(QQCorner *corner) {
        corner.radius = QQRadiusMakeSame(view.mj_h/2);
        corner.borderWidth = .5f;
        corner.fillColor = fillColor;
        corner.borderColor = borderColor;
    }];
    return view;
}

@end
