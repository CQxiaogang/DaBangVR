//
//  BuyNowOfProductInfoModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/23.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuyNowOfProductInfoModel : NSObject
//
@property(nonatomic, copy) NSString *id;

/**
 规格 ID
 */
@property(nonatomic, copy) NSString *specIds;

/**
 规格名字
 */
@property(nonatomic, copy) NSString *name;

/**
 数量
 */
@property(nonatomic, copy) NSString *number;

/**
零售价格
 */
@property(nonatomic, copy) NSString *retailPrice;

/**
 市场价格
 */
@property(nonatomic, copy) NSString *marketPrice;

/**
 邮费
 */
@property(nonatomic, copy) NSString *logisticsFee;

/**
 状态
 */
@property(nonatomic, copy) NSString *state;

/**
 排序
 */
@property(nonatomic, copy) NSString *sort;

/**
商品规格 ID
 */
@property(nonatomic, copy) NSString *goodsSpecIds;

/**
 商品规格名字
 */
@property(nonatomic, copy) NSString *goodsSpecNames;

/**
 商品名字
 */
@property(nonatomic, copy) NSString *goodsName;

/**
 销售数量
 */
@property(nonatomic, copy) NSString *salesVolume;

@end

NS_ASSUME_NONNULL_END
