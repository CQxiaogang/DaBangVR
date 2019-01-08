//
//  PageContentView.h
//  Demo
//
//  Created by mac on 2018/11/26.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol pageContentViewDelegate <NSObject>

- (void)pageContentView:(UIView *)contentView progress:(CGFloat)p sourceIndex:(int)s targetIndex:(int)t;

@end

@interface PageContentView : UIView<UICollectionViewDataSource, UICollectionViewDelegate>

/**
 重写init
 @param frame initWithFrame构造方法的参数，确定视图的大小
 @param childv 全部view添加到contenView中，用一个数组保存
 */
- (instancetype)initWithFrame:(CGRect)frame childSv:(NSMutableArray *)childv;


/**
 提供外部方法
 @param index 确定当前的index，来进行collectionView的移动
 */
- (void) setCurrentIndex:(int)index;

@property (nonatomic, weak) id<pageContentViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
