//
//  SpellGroupModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SpellGroupModel : NSObject

@property (nonatomic, copy) NSString *id;

/**
 名字
 */
@property (nonatomic, copy) NSString *name;

/**
 标题
 */
@property (nonatomic, copy) NSString *title;

/**
 详情
 */
@property (nonatomic, copy) NSString *describe;

/**
 图片地址
 */
@property (nonatomic, copy) NSString *listUrl;

/**
 销售价
 */
@property (nonatomic, copy) NSString *sellingPrice;

/**
 市场价
 */
@property (nonatomic, copy) NSString *marketPrice;
@end

NS_ASSUME_NONNULL_END
