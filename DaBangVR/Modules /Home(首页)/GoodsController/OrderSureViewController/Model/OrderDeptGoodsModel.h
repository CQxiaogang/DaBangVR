//
//  OrderSureDeptGoodsModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderDeptGoodsModel : NSObject
@property (nonatomic, copy) NSString *id;
// 店铺 logo
@property (nonatomic, copy) NSString *deptLogo;
// 店铺 名字
@property (nonatomic, copy) NSString *deptName;
// 订单状态
@property (nonatomic, copy) NSString *orderState;
// 店铺 商品总价
@property (nonatomic, copy) NSString *deptTotalPrice;
// 邮费总价
@property (nonatomic, copy) NSString *deptLogisticsTotalPrice;
// 店铺 ID
@property (nonatomic, copy) NSString *deptId;
// 店铺 商品
@property (nonatomic, copy) NSArray <OrderGoodsModel *> *goodsList;
@property (nonatomic, copy) NSArray <OrderGoodsModel *> *orderGoodslist;
// 店铺 商品加邮费总价
@property (nonatomic, copy) NSString *deptGoodsTotalPrice;
// 订单号
@property (nonatomic, copy) NSString *orderSn;
@end

NS_ASSUME_NONNULL_END
