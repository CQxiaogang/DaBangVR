//
//  DeptModel.h
//  DaBangVR
//
//  Created by mac on 2019/5/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeptModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *categoryDesc;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *categoryImg;
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *level;
@property (nonatomic, copy) NSString *nGoodsNumber;
@property (nonatomic, copy) NSArray  *goodsVoList;
@end

NS_ASSUME_NONNULL_END
