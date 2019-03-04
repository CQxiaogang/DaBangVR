//
//  ChannelModel.m
//  DaBangVR
//
//  Created by mac on 2019/1/11.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "ChannelModel.h"

@implementation ChannelModel


+ (instancetype)channelModelWithDic:(NSDictionary *)dic{
    ChannelModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

@end
