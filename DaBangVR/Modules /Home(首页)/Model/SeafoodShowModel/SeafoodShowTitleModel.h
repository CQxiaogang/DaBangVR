//
//  SeafoodShowTitleModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/12.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SeafoodShowTitleModel : NSObject

// 海鲜标题 ID
@property (nonatomic, assign) NSInteger titleID;
// 海鲜标题
@property (nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
