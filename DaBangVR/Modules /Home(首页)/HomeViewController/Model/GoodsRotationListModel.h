//
//  GoodsRotationListModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsRotationListModel : NSObject

// ID
@property (nonatomic, copy) NSString *ID;
// 轮播图片
@property (nonatomic, copy) NSString *chartUrl;
// 标题
@property (nonatomic, copy) NSString *title;
//
@property (nonatomic, copy) NSString *jumpUrl;
// 状态
@property (nonatomic, copy) NSString *state;
// 排序
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *mallSpeciesId;
@property (nonatomic, copy) NSString *mallSpeciesName;
@end

NS_ASSUME_NONNULL_END
