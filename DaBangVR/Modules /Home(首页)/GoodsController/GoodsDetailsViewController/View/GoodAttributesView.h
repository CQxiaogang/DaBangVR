//
//  GoodAttributesView.h
//  AiMeiBang
//
//  Created by Lingxiu on 16/1/25.
//  Copyright © 2016年 zym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailsModel.h"

typedef void (^GoodsAttributesBlock)(NSArray *array);
/* 上一次选择的属性 */
static NSArray *lastSeleArray;
/* 上一次选择的数量 */
static NSInteger lastNum;

@interface GoodAttributesView : UIView

@property (nonatomic, copy) NSString *good_img;
@property (nonatomic, copy) NSString *good_name;
@property (nonatomic, copy) NSString *good_price;

/** 购买数量 */
@property (nonatomic, assign) int buyNum;
/** 属性名1 */
@property (nonatomic, copy) NSString *goods_attr_1;
/** 属性名2 */
@property (nonatomic, copy) NSString *goods_attr_2;
/** 属性值1 */
@property (nonatomic, copy) NSString *goods_attr_value_1;
/** 属性值2 */
@property (nonatomic, copy) NSString *goods_attr_value_2;
@property (nonatomic, strong) NSArray *goodAttrsArr;
/** 订单提交类型，用于显示不同的价格 */
@property (nonatomic, copy) NSString *submitType;

/**
 商品详情 model,用于当商品p没有规格的时候显示价格等数据。
 */
@property (nonatomic, strong) GoodsDetailsModel *model;

@property (nonatomic, copy) void (^sureBtnsClick)(NSString *num, NSString *attr_id, NSString *goods_attr_value_1, NSString *goods_attr_value_2);
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
