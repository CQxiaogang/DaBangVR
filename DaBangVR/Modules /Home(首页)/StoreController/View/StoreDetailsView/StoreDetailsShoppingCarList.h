//
//  StoreDetailsShoppingCarList.h
//  DaBangVR
//
//  Created by mac on 2019/6/4.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreDetailsShoppingCarModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoreDetailsShoppingCarList : UIView

@property (nonatomic, copy) NSArray <StoreDetailsShoppingCarModel *>*data;

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

@end

NS_ASSUME_NONNULL_END
