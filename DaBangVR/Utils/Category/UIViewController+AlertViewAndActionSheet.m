//
//  UIViewController+AlertViewAndActionSheet.m
//  DaBangVR
//
//  Created by mac on 2018/12/19.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "UIViewController+AlertViewAndActionSheet.h"

@implementation UIViewController (AlertViewAndActionSheet)

#pragma mark —— alert view

-(void)AlertWithTitle:(NSString *__nullable)title preferredStyle:(UIAlertControllerStyle)style message:(NSString *__nullable)message andOthers:(NSArray<NSString *> *)others animated:(BOOL)animated action:(click)click{
    // 创建提示框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    
    [others enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 取消
        if (idx == 0) {
            [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                if (action && click) {
                    click(idx);
                }
                
            }]];
        }else{
            // 确定
            [alertController addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                if (action && click) {
                    click(idx);
                }
                
            }]];
        }
    }];
    [self presentViewController:alertController animated:animated completion:nil];
}
@end
