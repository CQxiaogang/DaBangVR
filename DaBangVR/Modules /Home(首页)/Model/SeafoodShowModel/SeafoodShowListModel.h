//
//  SeafoodShowListModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/12.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SeafoodShowListModel : NSObject
// id
@property (nonatomic, assign) NSInteger id;
// 描述
@property (nonatomic, copy)   NSString *describe;
// 图片
@property (nonatomic, copy)   NSString *listUrl;
// 销售价格
@property (nonatomic, assign) NSInteger sellingPrice;
// 市场价格
@property (nonatomic, assign) NSInteger marketPrice;
@end

NS_ASSUME_NONNULL_END
