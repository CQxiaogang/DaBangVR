//
//  productInfoVoListModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/17.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductInfoVoListModel : NSObject
// 产品 ID
@property (nonatomic, copy) NSString *id;
// 商品 ID
@property (nonatomic, copy) NSString *goodsId;
// 商品规格名字
@property (nonatomic, copy) NSString *name;
// 此规格商品数量
@property (nonatomic, copy) NSString *number;
// 零售价格
@property (nonatomic, copy) NSString *retailPrice;
// 市场价格
@property (nonatomic, copy) NSString *marketPrice;
// 秒杀价格
@property (nonatomic, copy) NSString *secondsPrice;
// 团购价格
@property (nonatomic, copy) NSString *groupPrice;
// 商品规格 ID
@property (nonatomic, copy) NSString *goodsSpecIds;
// 商品名字
@property (nonatomic, copy) NSString *goodsName;
@end

NS_ASSUME_NONNULL_END
