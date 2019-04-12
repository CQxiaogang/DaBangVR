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

typedef void (^constructingBodyWithBlock)(id _Nonnull formData);
@interface NetWorkHelper : NSObject

+ (void)POST:(NSString *)URL
  parameters:(id __nullable)parameters
     success:(RequestSuccess __nullable)success
     failure:(RequestFailed __nullable)failure;

+ (void)POST:(NSString *)URL
constructingBodyWithBlock:(constructingBodyWithBlock)constructingBodyWithBlock
  parameters:(id __nullable)parameters
     success:(RequestSuccess __nullable)success
     failure:(RequestFailed __nullable)failure;

/**
 POST含图片的时候调用

 @param URL 请求地址
 @param image 需要上传的图片
 @param parameters 需要上传的参数
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)POST:(NSString *)URL
      images:(UIImage *)image
 parameters:(id __nullable)parameters
     success:(RequestSuccess __nullable)success
     failure:(RequestFailed __nullable)failure;

+ (void)GET:(NSString *)URL
 parameters:(id __nullable)parameters
    success:(RequestSuccess __nullable)success
    failure:(RequestFailed __nullable)failure;

@end

NS_ASSUME_NONNULL_END
