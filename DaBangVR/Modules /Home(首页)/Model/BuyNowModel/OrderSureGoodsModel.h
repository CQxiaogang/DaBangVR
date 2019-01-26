//
//  OrderSureGoodsModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderSureGoodsModel : NSObject

/**
 商品 名字
 */
@property(nonatomic, strong) NSString *goodsName;

/**
 商品 销售价
 */
@property(nonatomic, strong) NSString *retailPrice;

/**
 商品 市场价
 */
@property(nonatomic, strong) NSString *marketPrice;

/**
 商品 邮费
 */
@property(nonatomic, strong) NSString *logisticsPrice;

/**
 商品 数量
 */
@property(nonatomic, strong) NSString *number;

/**
 商品 图片地址
 */
@property(nonatomic, strong) NSString *listUrl;

@end

NS_ASSUME_NONNULL_END
