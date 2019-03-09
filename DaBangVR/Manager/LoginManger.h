//
//  LoginManger.h
//  DaBangVR
//
//  Created by mac on 2019/3/9.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define loginManger [LoginManger sharedLoginManger]
#define isBound [LoginManger sharedLoginManger].isBoundPhone

@interface LoginManger : NSObject
// 单例
SINGLETON_FOR_HEADER(LoginManger)

@property (nonatomic, assign) BOOL isBoundPhone;

@end

NS_ASSUME_NONNULL_END
