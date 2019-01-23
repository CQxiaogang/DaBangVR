//
//  BuyNowOfGoodVoModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/23.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BuyNowOfGoodVoModel : NSObject
@property(nonatomic, strong) NSString *id;

/**
 类别 ID
 */
@property(nonatomic, strong) NSString *categoryId;

/**
 类别名字
 */
@property(nonatomic, strong) NSString *categoryName;

/**
 产品名字
 */
@property(nonatomic, strong) NSString *name;

/**
 产品 标题
 */
@property(nonatomic, strong) NSString *title;

/**
 描述
 */
@property(nonatomic, strong) NSString *describe;

/**
 图片 地址
 */
@property(nonatomic, strong) NSString *listUrl;

/**
 销售价格
 */
@property(nonatomic, strong) NSString *sellingPrice;

/**
 市场价格
 */
@property(nonatomic, strong) NSString *marketPrice;

/**
 剩余的库存
 */
@property(nonatomic, strong) NSString *remainingInventory;

/**
 添加日期
 */
@property(nonatomic, strong) NSString *addDate;

/**
 更新日期
 */
@property(nonatomic, strong) NSString *updateDate;

/**
 部门 ID
 */
@property(nonatomic, strong) NSString *deptId;

/**
 货物状态
 */
@property(nonatomic, strong) NSString *goodsState;

/**
 排序
 */
@property(nonatomic, strong) NSString *sort;

/**
 销量
 */
@property(nonatomic, strong) NSString *salesVolume;

/**
 <#Description#>
 */
@property(nonatomic, strong) NSString *goodsDesc;

/**
 图片集
 */
@property(nonatomic, strong) NSString *imgList;

/**
 添加用户 ID
 */
@property(nonatomic, strong) NSString *addUserId;

/**
 更新用户 ID
 */
@property(nonatomic, strong) NSString *updateUserId;

/**
 是新的
 */
@property(nonatomic, strong) NSString *isNew;

/**
 是最热的
 */
@property(nonatomic, strong) NSString *isHot;

/**
 货物规格清单
 */
@property(nonatomic, strong) NSString *goodsSpecVoList;

/**
 物流的价格
 */
@property(nonatomic, strong) NSString *logisticsPrice;

/**
 产品信息列表
 */
@property(nonatomic, strong) NSString *productInfoVoList;
@end

NS_ASSUME_NONNULL_END
