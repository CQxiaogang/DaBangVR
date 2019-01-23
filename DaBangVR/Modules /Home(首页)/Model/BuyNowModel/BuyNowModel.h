//
//  BuyNowModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/23.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BuyNowOfGoodVoModel.h"
#import "BuyNowOfUserAddressModel.h"
#import "BuyNowOfProductInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BuyNowModel : NSObject

/**
 邮费
 */
@property(nonatomic, copy) NSString *logisticsPrice;

/**
 数量
 */
@property(nonatomic, copy) NSString *number;

/**
 产品 ID
 */
@property(nonatomic, copy) NSString *productId;

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
 产品信息
 */
@property(nonatomic, strong) BuyNowOfProductInfoModel *productInfoVo;

/**
 用户信息，地址信息
 */
@property(nonatomic, strong) BuyNowOfUserAddressModel *receivingAddress;

/**
 货物信息
 */
@property(nonatomic, strong) BuyNowOfGoodVoModel *goodsVo;
@end

NS_ASSUME_NONNULL_END
