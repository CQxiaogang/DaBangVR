//
//  SeafoodShowListModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/12.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsShowListModel : NSObject
//id
@property (nonatomic, assign) NSInteger id;
//商品名字
@property (nonatomic, copy) NSString *name;
//描述
@property (nonatomic, copy)   NSString *describe;
//图片
@property (nonatomic, copy)   NSString *listUrl;
//销售价格
@property (nonatomic, assign) NSString *sellingPrice;
//销量
@property (nonatomic, assign) NSString * salesVolume;
//市场价格
@property (nonatomic, assign) NSString *marketPrice;
@end

NS_ASSUME_NONNULL_END
