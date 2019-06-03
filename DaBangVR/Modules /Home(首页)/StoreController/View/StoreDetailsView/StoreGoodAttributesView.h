//
//  StoreGoodAttributesView.h
//  DaBangVR
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeptDetailsGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^GoodsAttributesBlock)(NSArray *array);
static NSInteger lastNum;

@interface StoreGoodAttributesView : UIView

@property (nonatomic, strong) DeptDetailsGoodsModel *model;

/**
 *  显示属性选择视图
 *
 *  @param view 要在哪个视图中显示
 */
- (void)showInView:(UIView *)view;
/**
 *  属性视图的消失
 */
- (void)removeView;

@property (strong, nonatomic)GoodsAttributesBlock goodsAttributesBlock;

@end

NS_ASSUME_NONNULL_END
