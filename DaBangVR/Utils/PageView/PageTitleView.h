//
//  TitleView.h
//  Demo
//
//  Created by mac on 2018/11/26.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PageTitleViewDelegate <NSObject>

- (void)pageTitleView:(UIView *)titleView selectedIndex:(int)index;

@end

@interface PageTitleView : UIView

@property (nonatomic, weak) id<PageTitleViewDelegate> delagate;
@property (nonatomic, strong) NSArray *titlesArr;

/**
 自定义构造方法

 @param frame    确定titleView的大小
 @param titleArr 进入title的总数
 */
- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray *)titleArr;

/**
 提供暴露的方法
 @param progress    偏移的比例（偏移量），用了设置contentView需要移动多少
 @param sourceIndex 原来的index
 @param targetIndex 目标的index
 */
- (void)setTitleWithProgress:(CGFloat)progress sourceIndex:(int)sourceIndex targetIndex:(int)targetIndex;

@end

NS_ASSUME_NONNULL_END
