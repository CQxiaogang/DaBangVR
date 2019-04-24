//
//  ZLBounceView.h
//  DaBangVR
//
//  Created by mac on 2019/4/23.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLBounceView : UIView

@property (nonatomic, strong) UIView *contentView;
//展示从底部向上弹出的UIView（包含遮罩）
- (void)showInView:(UIView *)view;
@end

NS_ASSUME_NONNULL_END
