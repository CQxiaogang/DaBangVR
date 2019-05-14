//
//  GoodsDetailsModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsDetailsModel : NSObject
//商品 ID
@property (nonatomic, copy) NSString *id;
//类别 ID
@property (nonatomic, copy) NSString *categoryId;
//名字
@property (nonatomic, copy) NSString *name;
//标题
@property (nonatomic, copy) NSString *title;
// 描述
@property (nonatomic, copy) NSString *describe;
//图片
@property (nonatomic, copy) NSString *listUrl;
//销售价格
@property (nonatomic, copy) NSString *sellingPrice;
//市场价格
@property (nonatomic, copy) NSString *marketPrice;
//秒杀价格
@property (nonatomic, copy) NSString *secondsPrice;
//团购价格
@property (nonatomic, copy) NSString *groupPrice;
//图片数组
@property (nonatomic, copy) NSArray  *imgList;
//是新上
@property (nonatomic, assign) BOOL   *isNew;
//是热销
@property (nonatomic, assign) BOOL   *isHot;
//商品规格数组
@property (nonatomic, copy) NSArray  *goodsSpecVoList;
//商品信息数组
@property (nonatomic, copy) NSArray  *productInfoVoList;
//库存
@property (nonatomic, copy) NSString *remainingInventory;
//店铺 ID
@property (nonatomic, copy) NSString *deptId;
//秒杀商品结束时间
@property (nonatomic, copy) NSString *secondsEndTime;
//团购商品结束时间
@property (nonatomic, copy) NSString *endTime;
//销量
@property (nonatomic, copy) NSString *salesVolume;
@end

NS_ASSUME_NONNULL_END
