//
//  DBFontOfSize.h
//  DaBangVR
//
//  Created by mac on 2018/12/8.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

//按比例获取宽度根据375的屏幕
#define  C_WIDTH(WIDTH) WIDTH * [UIScreen mainScreen].bounds.size.width/375.0

NS_ASSUME_NONNULL_BEGIN

@interface UILabel(FixScreenFont)

@property (nonatomic)IBInspectable float adaptiveFontSize;

@end

@interface UIButton(FixScreenFont)

@property (nonatomic)IBInspectable float adaptiveFontSize;

@end

NS_ASSUME_NONNULL_END
