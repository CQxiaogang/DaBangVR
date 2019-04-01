//
//  DB_TextView.h
//  DaBangVR
//
//  Created by mac on 2019/4/1.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DB_TextView : UIView
/** 发送按钮 */
@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, copy) void(^textBlock)(NSString *string);

- (void)setPlaceholderText:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
