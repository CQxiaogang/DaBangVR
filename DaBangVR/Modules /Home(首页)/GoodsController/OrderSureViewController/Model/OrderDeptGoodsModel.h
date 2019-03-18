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
// 实际支付价格
@property (nonatomic, copy) NSString *actualPayPrice;
// 地址
@property (nonatomic, copy) NSString *address;
// 地址ID
@property (nonatomic, copy) NSString *addressId;
// 购买类型
@property (nonatomic, copy) NSString *buyType;
// 确认时间
@property (nonatomic, copy) NSString *confirmTime;
// 收货人的名字
@property (nonatomic, copy) NSString *consigneeName;
// 收货人的电话
@property (nonatomic, copy) NSString *consigneePhone;
// 交货时间
@property (nonatomic, copy) NSString *deliveryTime;

// 店铺 ID
@property (nonatomic, copy) NSString *deptId;
// 店铺 logo
@property (nonatomic, copy) NSString *deptLogo;
// 店铺 名字
@property (nonatomic, copy) NSString *deptName;
// 预计交付时间
@property (nonatomic, copy) NSString *expectedDeliveryTime;
// 店铺 商品总价
@property (nonatomic, copy) NSString *deptTotalPrice;
// 邮费总价
@property (nonatomic, copy) NSString *deptLogisticsTotalPrice;
// 货物总价
@property (nonatomic, copy) NSString *goodsTotalPrice;
@property (nonatomic, copy) NSString *id;
// 留言
@property (nonatomic, copy) NSString *leaveMessage;
// 物流的代码
@property (nonatomic, copy) NSString *logisticsCode;
// 物流费用
@property (nonatomic, copy) NSString *logisticsFee;
// 物流ID
@property (nonatomic, copy) NSString *logisticsId;
// 物流名字
@property (nonatomic, copy) NSString *logisticsName;
// 物流编号
@property (nonatomic, copy) NSString *logisticsSn;
// 物流状态
@property (nonatomic, copy) NSString *logisticsState;
// 物流总价
@property (nonatomic, copy) NSString *logisticsTotalPrice;
// 店铺 商品
@property (nonatomic, copy) NSArray <OrderGoodsModel *> *goodsList;
@property (nonatomic, copy) NSArray <OrderGoodsModel *> *orderGoodslist;
// 订单号
@property (nonatomic, copy) NSString *orderSn;
@property (nonatomic, copy) NSString *orderTotalSn;
// 订单支付类型
@property (nonatomic, copy) NSString *orderSnType;
// 订单状态
@property (nonatomic, copy) NSString *orderState;
// 订单时间
@property (nonatomic, copy) NSString *orderTime;
// 订单总价
@property (nonatomic, copy) NSString *orderTotalPrice;
// 店铺 商品加邮费总价
@property (nonatomic, copy) NSString *deptGoodsTotalPrice;
// 支付时间
@property (nonatomic, copy) NSString *payTime;
// 总价
@property (nonatomic, copy) NSString *totalPrice;

@end

NS_ASSUME_NONNULL_END
