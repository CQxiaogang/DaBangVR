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

+ (void)POST:(NSString *)URL parameters:(id __nullable)parameters success:(RequestSuccess __nullable)success failure:(RequestFailed __nullable)failure{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD dismissWithDelay:1.0];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript" ,@"text/plain", nil];
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [mutableDic setObject:kToken forKey:@"DABANG-TOKEN"];
    [manager POST:URL parameters:mutableDic progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [SVProgressHUD showWithStatus:@"加载成功"];
//        [SVProgressHUD dismissWithDelay:1.0];
//        [SVProgressHUD dismiss];
        if (success) {
           success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        /**
//         从AFNetworking返回的Error中取出服务端返回的错误信息
//         */
//        if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
//                    id response = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
//        }
        [SVProgressHUD showWithStatus:@"加载失败"];
        [SVProgressHUD dismissWithDelay:2.0];
        [SVProgressHUD dismiss];
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)URL images:(UIImage *)image parameters:(id)parameters success:(RequestSuccess)success failure:(RequestFailed)failure{
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [mutableDic setObject:kToken forKey:@"DABANG-TOKEN"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",@"image/jpg",@"text/plain",nil];
    [manager POST:URL parameters:mutableDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //取出单张图片二进制数据
        NSData *imgData = UIImageJPEGRepresentation(image, 0.8);
        //上传的参数名，在服务器端保存文件的文件夹名
        NSString *name = @"file";
        //上传filename
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg",name];
        [formData appendPartWithFileData:imgData name:name fileName:fileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)URL constructingBodyWithBlock:(nonnull constructingBodyWithBlock)constructingBodyWithBlock parameters:(id _Nullable)parameters success:(RequestSuccess _Nullable)success failure:(RequestFailed _Nullable)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/javascript" ,@"text/plain", nil];
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:parameters];
    [mutableDic setObject:kToken forKey:@"DABANG-TOKEN"];
    [manager POST:URL parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (constructingBodyWithBlock) {
            constructingBodyWithBlock(formData);
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        /**
         从AFNetworking返回的Error中取出服务端返回的错误信息
         */
        if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
            id response = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
            [SVProgressHUD showInfoWithStatus:response[@"errmsg"]];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD dismissWithDelay:1.0];
        }
        DLog(@"TIM_POST请求失败:%@", error.description);
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)GET:(NSString *)URL parameters:(id __nullable)parameters success:(RequestSuccess)success failure:(RequestFailed)failure{
    AFHTTPSessionManager *manger = [AFHTTPSessionManager manager];
    [manger GET:URL parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
            id response = [NSJSONSerialization JSONObjectWithData:error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] options:0 error:nil];
            [SVProgressHUD showInfoWithStatus:response[@"msg"]];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD dismissWithDelay:1.0];
        }
        DLog(@"error is %@",error);
    }];
}



@end
