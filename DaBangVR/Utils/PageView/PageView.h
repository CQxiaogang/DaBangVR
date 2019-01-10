//
//  PageView.h
//  DaBangVR
//
//  Created by mac on 2019/1/9.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageView : UIView

- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray *)titles ContentViews:(NSMutableArray *)views;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSMutableArray *contentViewArray;

@end

NS_ASSUME_NONNULL_END
