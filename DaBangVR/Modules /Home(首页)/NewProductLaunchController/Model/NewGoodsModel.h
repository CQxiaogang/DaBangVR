//
//  NewGoodsModel.h
//  DaBangVR
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodsDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewGoodsModel : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *parentId;
// 背景图片
@property (nonatomic, copy) NSString *categoryImg;
// 新品总量
@property (nonatomic, copy) NSString *count;
@property (nonatomic, copy) NSArray <GoodsDetailsModel *> *goodsVoList;
// 商品图片
@property (nonatomic, copy) NSString *listUrl;
@end

NS_ASSUME_NONNULL_END
