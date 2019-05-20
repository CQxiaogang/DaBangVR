//
//  PaymentManager.h
//  DaBangVR
//
//  Created by mac on 2019/3/8.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UtilsMacros.h"
#import "WXApi.h"
NS_ASSUME_NONNULL_BEGIN

#define PayManager [PaymentManager sharedPaymentManager]


@interface PaymentManager : NSObject<WXApiDelegate>
// 单例
SINGLETON_FOR_HEADER(PaymentManager)

/**
 微信支付提供外部接口

 @param orderSn 订单号
 @param payOrderSnType 付款类型
 * 1：立即购买=》直接支付     使用orderSnTotal
 * 2：立即购买=》取消=》重新付款     使用orderSnTotal
 * 3：立即购买=》取消=》查看订单=》订单详情=》去付款    使用orderSn
 * 4：购物车=》去付款    使用orderSnTotal
 * 5：购物车=》去付款=》取消=》重新付款    使用orderSnTotal
 * 6：购物车=》去付款=》取消=》查看订单=》订单详情=》去付款    使用orderSn
 */
- (void)weiXinPayWithOrderSn:(NSString *)orderSn andPayOrderSnType:(NSString *)payOrderSnType;

- (void)weiXinPayWithOrderID:(NSString *)orderID ;

@end

NS_ASSUME_NONNULL_END
