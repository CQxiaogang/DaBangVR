//
//  ChannelModel.m
//  DaBangVR
//
//  Created by mac on 2019/1/11.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "ChannelModel.h"

@interface ChannelModel ()

@property (nonatomic, strong) ChannelModel *model;

@property (nonatomic, strong) NSMutableArray *arrayModel;

@end
@implementation ChannelModel

- (NSMutableArray *)arrayModel{
    if (!_arrayModel) {
        _arrayModel = [NSMutableArray new];
    }
    return _arrayModel;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getData];
    }
    return self;
}

- (void)getData{
    [NetWorkHelper POST:URL_channel_menu_info parameters:nil success:^(id  _Nonnull responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic= dictionary[@"data"];
        NSArray *channelArray = dataDic[@"channelMenuList"];
        for (NSDictionary *dic in channelArray) {
            self.model = [ChannelModel modelWithDictionary:dic];
            [self.arrayModel addObject:self.model];
        }
        if (self.success != nil) {
            self.success(self.arrayModel);
        }
        
    } failure:^(NSError * _Nonnull error) {
        DLog(@"error %@",error);
    }];
}

@end
