//
//  DeptDetailsGoodsCategoryModel.h
//  DaBangVR
//
//  Created by mac on 2019/5/29.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeptDetailsGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DeptDetailsGoodsCategoryModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *deptId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray <DeptDetailsGoodsModel *> *deliveryGoodsVoList;


@end

NS_ASSUME_NONNULL_END
