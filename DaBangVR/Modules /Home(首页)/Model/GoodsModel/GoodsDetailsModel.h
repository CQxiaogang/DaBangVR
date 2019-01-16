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
// 类别 ID
@property (nonatomic, copy) NSString *categoryId;
// 名字
@property (nonatomic, copy) NSString *name;
// 标题
@property (nonatomic, copy) NSString *title;
// 描述
@property (nonatomic, copy) NSString *describe;
// 图片
@property (nonatomic, copy) NSString *listUrl;
// 销售价格
@property (nonatomic, copy) NSString *sellingPrice;
// 市场价格
@property (nonatomic, copy) NSString *marketPrice;
// 图片数组
@property (nonatomic, copy) NSArray  *imgList;
// 是新上
@property (nonatomic , assign) BOOL *isNew;
// 是热销
@property (nonatomic , assign) BOOL *isHot;
@end

NS_ASSUME_NONNULL_END
