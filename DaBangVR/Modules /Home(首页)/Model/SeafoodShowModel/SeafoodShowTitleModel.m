//
//  SeafoodShowTitleModel.m
//  DaBangVR
//
//  Created by mac on 2019/1/12.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "SeafoodShowTitleModel.h"

@implementation SeafoodShowTitleModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getDate];
    }
    return self;
}

- (void)getDate{
    [NetWorkHelper POST:URL_seafood_title parameters:nil success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic  = dic[@"data"];
    } failure:^(NSError * _Nonnull error) {
        DLog(@"errr %@",error)
    }];
}

@end
