//
//  GoodAttributesView.h
//  AiMeiBang
//
//  Created by Lingxiu on 16/1/25.
//  Copyright © 2016年 zym. All rights reserved.
//

#import <UIKit/UIKit.h>

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
// 商品属性数组，接受外部传进来的数据
@property (nonatomic, copy) NSArray  *goodsAttributesArray;
/* 商品图片 */
@property (nonatomic, copy) NSString *goodsImgStr;
// 商品信息列表
@property (nonatomic, copy) NSArray  *productInfoVoList;
// 商品价格
@property (nonatomic, copy) NSString *sellingPrice;
// 库存
@property (nonatomic, copy) NSString *remainingInventory;

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
