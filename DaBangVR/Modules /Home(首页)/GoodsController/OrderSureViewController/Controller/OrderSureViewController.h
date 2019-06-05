//
//  BuyNowViewController.h
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderSureViewController : UIViewController
//提交订单的状态
@property (nonatomic, copy) NSString *submitType;
//订单状态
@property (nonatomic, copy) NSString *orderSnTotal;
//订单ID orderID == nil 第一次支付,orderID != nil 重新支付
@property (nonatomic, copy) NSString *orderID;

@end

NS_ASSUME_NONNULL_END
