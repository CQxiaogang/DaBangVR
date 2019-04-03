//
//  RAYUploadFile.h
//  hooray
//
//  Created by wbxiaowangzi on 16/4/14.
//  Copyright © 2016年 RAY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RAYUploadFile : NSObject
@property (nonatomic, strong) NSURL* fileurl;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *token;

@end
