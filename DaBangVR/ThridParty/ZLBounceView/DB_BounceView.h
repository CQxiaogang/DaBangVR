//
//  ZLBounceView.h
//  DaBangVR
//
//  Created by mac on 2019/4/23.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DB_BounceViewDelagete <NSObject>

/**
 视图显示后按钮出现
 */
-(void)dismissViewShowButton;

@end

@interface DB_BounceView : UIView

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, weak) id<DB_BounceViewDelagete>delegate;

//展示从底部向上弹出的UIView（包含遮罩）
-(void)showInView:(UIView *)view;
-(instancetype)initWithContentViewFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
