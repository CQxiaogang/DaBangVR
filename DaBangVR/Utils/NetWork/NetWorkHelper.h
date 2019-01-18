//
//  NetWorkHlper.h
//  DaBangVR
//
//  Created by mac on 2018/12/25.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 请求成功的Block */
typedef void(^RequestSuccess)(id responseObject);

/** 请求失败的Block */
typedef void(^RequestFailed)(NSError *error);

@interface NetWorkHelper : NSObject

+ (void)POST:(NSString *)URL
  parameters:(id __nullable)parameters
     success:(RequestSuccess)success
     failure:(RequestFailed)failure;

+ (void)POSTW:(NSString *)URL parameters:(id __nullable)parameters success:(RequestSuccess)success failure:(RequestFailed)failure;

@end

NS_ASSUME_NONNULL_END
