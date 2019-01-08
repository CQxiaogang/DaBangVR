//
//  DBMoreFunctionModel.m
//  DaBangVR
//
//  Created by mac on 2018/11/30.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "DBMoreFunctionModel.h"

@implementation DBMoreFunctionModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *list = @[@"视屏",@"海鲜",@"拼图",@"限时秒杀",@"大邦",@"全球购",@"新品首发",@"门店",@"分类搜索",@"社区",];
        self.array = [list copy];
    }
    return self;
}
@end
