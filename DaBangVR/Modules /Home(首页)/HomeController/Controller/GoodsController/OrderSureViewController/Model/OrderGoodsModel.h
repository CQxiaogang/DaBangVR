//
//  OrderSureGoodsModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderGoodsModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *goodsId;
// 商品 名字
@property (nonatomic, copy) NSString *goodsName;
// 商品 销售价
@property(nonatomic, copy) NSString *retailPrice;
// 商品 市场价
@property(nonatomic, copy) NSString *marketPrice;
// 商品 邮费
@property(nonatomic, copy) NSString *logisticsPrice;
// 商品 数量
@property(nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *goodsNumber;
// 商品 图片地址
@property(nonatomic, copy) NSString *goodsListUrl;
// 商品 图片地址
@property(nonatomic, copy) NSString *listUrl;
// 商品状态
@property(nonatomic, copy) NSString *goodsState;
// 购物车数量
@property(nonatomic, copy) NSString *cartNumber;
@end

NS_ASSUME_NONNULL_END
