//
//  NetWorkHlper.m
//  DaBangVR
//
//  Created by mac on 2018/12/25.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "NetWorkHelper.h"
#import "AFNetworking.h"

@implementation NetWorkHelper

+ (void)POST:(NSString *)URL parameters:(id __nullable)parameters success:(RequestSuccess)success failure:(RequestFailed)failure{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript" ,@"text/plain", nil];
    
    [manager POST:URL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        /**
         从AFNetworking返回的Error中取出服务端返回的错误信息
         */
        //        if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
        //            id response = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
        //        }
        DLog(@"TIM_POST请求失败:%@", error.description);
        failure(error);
    }];
}

@end
