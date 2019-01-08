//
//  DBLayoutConstraint.m
//  xib适配
//
//  Created by mac on 2018/12/8.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "DBLayoutConstraint.h"
#import <objc/runtime.h>

NS_INLINE  CGFloat _sizeRate(){
    static CGFloat _rate = 0.0;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _rate = [UIScreen mainScreen].bounds.size.width / 375.0;
    });
    return _rate;
}

@implementation NSLayoutConstraint(AllSize)

- (void)setAdaptive:(BOOL)widthAdaptive {
    if (widthAdaptive) {
        CGFloat _cons = self.constant;
        _cons = _cons * _sizeRate();
        self.constant = _cons;
    }
    objc_setAssociatedObject(self, @selector(adaptive), @(widthAdaptive), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (BOOL)adaptive {
    NSNumber *value = objc_getAssociatedObject(self, @selector(adaptive));
    return [value boolValue];
}

@end
