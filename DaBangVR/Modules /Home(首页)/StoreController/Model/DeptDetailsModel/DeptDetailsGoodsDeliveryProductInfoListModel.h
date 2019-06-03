//
//  DeptDetailsGoodsDeliveryProductInfoListModel.h
//  DaBangVR
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeptDetailsGoodsDeliveryProductInfoListModel : UIView

@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *sellingPrice;
@property (nonatomic, copy) NSString *marketPrice;
@property (nonatomic, copy) NSString *specIds;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *deliveryGoodsId;
@property (nonatomic, copy) NSString *packagingPrice;
@property (nonatomic, copy) NSString *deliveryGoodsSpecIds;
/** 是否点击 */
@property (nonatomic,assign)BOOL isSelect;

@end

NS_ASSUME_NONNULL_END
