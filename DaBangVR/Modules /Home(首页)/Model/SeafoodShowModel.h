//
//  SeafoodShowModel.h
//  DaBangVR
//
//  Created by mac on 2018/12/25.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SeafoodShowModel : NSObject

// 头像地址
@property (nonatomic, copy) NSString *headImgStr;
// 当前状态
@property (nonatomic, copy) NSString *state;
// 商品简介
@property (nonatomic, copy) NSString *intro;
// 商品价格
@property (nonatomic,assign) long long thePrice;
// 付款人数
@property (nonatomic,assign) long long paymentPeople;
@end

NS_ASSUME_NONNULL_END
