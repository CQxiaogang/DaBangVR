//
//  DBFeatureList.h
//  Demo
//
//  Created by mac on 2018/12/28.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBFeatureList : NSObject

/** 类型名 */
@property (nonatomic, copy) NSString *infoname;
/** 额外价格 */
@property (nonatomic, copy) NSString *plusprice;
/** 是否点击 */
@property (nonatomic,assign)BOOL isSelect;

@end

NS_ASSUME_NONNULL_END
