//
//  RAYUploader.h
//  hooray
//
//  Created by wbxiaowangzi on 16/4/14.
//  Copyright © 2016年 RAY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QiniuSDK.h>
#import "RAYUploadFile.h"



@protocol RAYUploaderDelegate <NSObject>

@optional

- (void)uploadWithQNResponseInfo:(QNResponseInfo*)info fileUrl:(NSURL *)url resp:(NSDictionary *)resp;

- (void)uploadingProgress:(float)percent fileUrl:(NSURL *)url;

- (void)uploadFinish;

@end

@interface RAYUploader : NSObject

@property (nonatomic, assign) id<RAYUploaderDelegate> delegate;

//单例
+ (instancetype)defaultUploader;

/**
 * @desc 开始上传某个文件，根据fileUrl 判断
 * @param bucket 文件类型，全部可用值： hooray-ask, hooray-cloudspace, hooray-weike, hooray-whiteboard, hooray-system
 */
- (void)uploadWithFileurl:(NSURL*)fileurl bucketType:(NSString *)bucket;

//取消上传某个文件，根据fileUrl 判断
- (void)cancelUploadWithFileUrl:(NSURL *)url;

//继续上传某个文件，根据fileUrl 判断
- (void)continueUploadWithFileUrl:(NSURL *)url;

//某个任务上传进度
- (float)uploadPersentOfFileUrl:(NSURL *)fileUrl;

//取消所有上传
- (void)cancelAllTask;

//继续所有任务
- (void)continueAllTask;

//任务是否正在上传
- (BOOL)isUploadingOfFileurl:(NSURL *)fileUrl;

@end

