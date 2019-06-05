//
//  DeptDetailsGoodsSpecList.h
//  DaBangVR
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DBFeatureList;

@interface DeptDetailsGoodsSpecList : UIView

@property (nonatomic, copy) NSString *goodsCategoryId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSArray <DBFeatureList*>*deliveryGoodsSpecList;
@end

NS_ASSUME_NONNULL_END
