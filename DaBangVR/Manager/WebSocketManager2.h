//
//  WebSocketManager2.h
//  DaBangVR
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRWebSocket.h"
NS_ASSUME_NONNULL_BEGIN

@interface WebSocketManager2 : NSObject
@property (nonatomic, strong) SRWebSocket *webSocket;
+ (instancetype)sharedSocketManager;//单例
- (void)connectServer;//建立长连接
- (void)SRWebSocketClose;//关闭长连接
- (void)sendDataToServer:(id)data;//发送数据给服务器
@end

NS_ASSUME_NONNULL_END
