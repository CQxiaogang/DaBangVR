//
//  BuyNowModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/23.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderDeptGoodsModel.h"
#import "UserAddressModel.h"
#import "GoodsDetailsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderSureModel : NSObject

// 邮费
@property (nonatomic, copy) NSString *orderLogisticsTotalPrice;
// 购物车 ID
@property (nonatomic, copy) NSString *cartIds;
// 商品总价
@property (nonatomic, copy) NSString *orderGoodsTotalPrice;
// 商品加邮费价格
@property (nonatomic, copy) NSString *orderTotalPrice;
// 店铺列表
@property (nonatomic, strong) NSArray <OrderDeptGoodsModel *> *deptGoodsList;
//// 商品信息
//@property (nonatomic, strong) NSArray <GoodsDetailsModel *> *goodsList;
// 用户信息，地址信息
@property (nonatomic, strong) UserAddressModel *receivingAddress;

@end

NS_ASSUME_NONNULL_END
