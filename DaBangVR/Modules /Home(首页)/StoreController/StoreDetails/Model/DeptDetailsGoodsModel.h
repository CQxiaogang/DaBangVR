//
//  DeptDetailsGoodsModel.h
//  DaBangVR
//
//  Created by mac on 2019/5/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class DeptDetailsGoodsSpecList, DeptDetailsGoodsDeliveryProductInfoListModel;

@interface DeptDetailsGoodsModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *deliveryGoodsTypeId;
@property (nonatomic, copy) NSString *deliveryGoodsTypeName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *listUrl;
@property (nonatomic, copy) NSString *sellingPrice;
@property (nonatomic, copy) NSString *marketPrice;
@property (nonatomic, copy) NSString *deliverPrice;
@property (nonatomic, copy) NSString *packagingPrice;
@property (nonatomic, copy) NSString *startingPrice;
@property (nonatomic, copy) NSString *salesVolume;
//商品数量
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger number;
//规格列表
@property (nonatomic, copy) NSArray <DeptDetailsGoodsSpecList *>*specList;
//
@property (nonatomic, copy) NSArray <DeptDetailsGoodsDeliveryProductInfoListModel *>*deliveryProductInfoList;
@end

NS_ASSUME_NONNULL_END
