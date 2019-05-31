//
//  DeptDetailsGoodsModel.h
//  DaBangVR
//
//  Created by mac on 2019/5/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

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
@property (nonatomic, copy) NSArray *specList;
@property (nonatomic, copy) NSArray *deliveryProductInfoList;

@end

NS_ASSUME_NONNULL_END
