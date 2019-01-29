//
//  MyOrderDeptModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/29.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderDeptModel : NSObject

@property (nonatomic, copy) NSString *deptName;

@property (nonatomic, copy) NSString *deptLogo;
@property (nonatomic, copy) NSArray <MyOrderModel *> *orderGoodslist;

@end

NS_ASSUME_NONNULL_END
