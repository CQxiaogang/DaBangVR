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
//规格id
@property (nonatomic, copy) NSString *id;
//规格组合
@property (nonatomic, copy) NSString *name;
//这个规格买的数量
@property (nonatomic, copy) NSString *number;
//销售价格
@property (nonatomic, copy) NSString *sellingPrice;
//市场价格
@property (nonatomic, copy) NSString *marketPrice;
//包装费用
@property (nonatomic, copy) NSString *packagingPrice;
//规格组合完成的ID
@property (nonatomic, copy) NSString *deliveryGoodsSpecIds;
/** 是否点击 */
@property (nonatomic,assign)BOOL isSelect;

@end

NS_ASSUME_NONNULL_END
