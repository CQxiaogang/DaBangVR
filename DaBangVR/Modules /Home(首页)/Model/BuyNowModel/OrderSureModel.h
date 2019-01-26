//
//  BuyNowModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/23.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderSureDeptGoodsModel.h"
#import "OrderSureUserAddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderSureModel : NSObject

/**
 邮费
 */
@property(nonatomic, copy) NSString *orderLogisticsTotalPrice;

/**
 数量
 */
@property(nonatomic, copy) NSString *number;

/**
 产品 ID
 */
@property(nonatomic, copy) NSString *productId;

/**
 商品总价
 */
@property(nonatomic, copy) NSString *orderGoodsTotalPrice;

/**
 商品加邮费价格
 */
@property(nonatomic, copy) NSString *orderTotalPrice;
/**
 货物 ID
 */
@property(nonatomic, copy) NSString *goodsId;

/**
 商品价格
 */
@property(nonatomic, copy) NSString *goodsPrice;

/**
 商品总价
 */
@property(nonatomic, copy) NSString *goodsTotalPrice;

/**
 用户信息，地址信息
 */
@property(nonatomic, strong) OrderSureUserAddressModel *receivingAddress;

/**
 店铺列表
 */
@property(nonatomic, strong) NSArray <OrderSureDeptGoodsModel *> *deptGoodsList;

@end

NS_ASSUME_NONNULL_END
