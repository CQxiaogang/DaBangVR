//
//  UIViewController+AlertViewAndActionSheet.h
//  DaBangVR
//
//  Created by mac on 2018/12/19.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
// block
typedef void(^click)(NSInteger index);

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (AlertViewAndActionSheet)

- (void)AlertWithTitle:(NSString *__nullable)title
        preferredStyle:(UIAlertControllerStyle)style
               message:(NSString *__nullable)message
             andOthers:(NSArray<NSString *> *)others
              animated:(BOOL)animated
                action:(click)click;
@end

NS_ASSUME_NONNULL_END
