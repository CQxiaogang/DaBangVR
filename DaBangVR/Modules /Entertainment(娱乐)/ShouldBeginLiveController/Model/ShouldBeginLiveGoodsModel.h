//
//  ShouldBeginLiveGoodsModel.h
//  DaBangVR
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShouldBeginLiveGoodsModel : NSObject
/** 商品ID */
@property (nonatomic, copy) NSString *id;
/** 商品名字 */
@property (nonatomic, copy) NSString *name;
/** 商品图片 */
@property (nonatomic, copy) NSString *listUrl;
/** 是否点击 */
@property (nonatomic,assign)BOOL isSelect;
@end

NS_ASSUME_NONNULL_END
