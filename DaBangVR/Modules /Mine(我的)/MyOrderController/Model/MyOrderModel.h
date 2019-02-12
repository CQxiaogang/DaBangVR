//
//  MyOrderModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/29.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *goodsId;
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, copy) NSString *goodsNumber;
@property (nonatomic, copy) NSString *marketPrice;
@property (nonatomic, copy) NSString *retailPrice;

@end

NS_ASSUME_NONNULL_END
