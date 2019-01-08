//
//  UIAlertController+TapGesAlertController.m
//  DaBangVR
//
//  Created by mac on 2018/12/17.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "UIAlertController+TapGesAlertController.h"

@implementation UIAlertController (TapGesAlertController)

- (void)tapGesAlert{
    NSArray *arrViews = [UIApplication sharedApplication].keyWindow.subviews;
    if (arrViews.count > 0) {
        //array会有两个对象，一个是UILayoutContainerView，另外一个是UITransitionView，我们找到最后一个
        UIView *backView = arrViews.lastObject;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [backView addGestureRecognizer:tap];
    }
}

- (void)tap{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
