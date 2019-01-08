//
//  DBLayoutConstraint.h
//  xib适配
//
//  Created by mac on 2018/12/8.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSLayoutConstraint(AllSize)

/**
    自适应宽高
 */
@property (nonatomic, assign) IBInspectable BOOL adaptive;

@end

NS_ASSUME_NONNULL_END
