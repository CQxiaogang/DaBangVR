//
//  ChannelModel.h
//  DaBangVR
//
//  Created by mac on 2019/1/11.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^success)(NSArray *array);
@interface ChannelModel : NSObject
// 频道ID
//@property(nonatomic, assign) NSInteger cID;
// 频道头像
@property(nonatomic, copy) NSString *iconUrl;
// 频道标题
@property(nonatomic, copy) NSString *title;

@property (nonatomic, strong) success success;

@end

NS_ASSUME_NONNULL_END
