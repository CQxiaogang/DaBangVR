//
//  ChannelViewModel.m
//  DaBangVR
//
//  Created by mac on 2019/1/11.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "ChannelViewModel.h"
#import "ChannelModel.h"

@interface ChannelViewModel ()

@property (nonatomic, strong) ChannelModel *model;
@property (nonatomic, strong) NSMutableArray *arrayModel;

@end
@implementation ChannelViewModel

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
        [NetWorkHelper POST:URL_channel_menu_info parameters:nil success:^(id  _Nonnull responseObject) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSDictionary *dataDic= dictionary[@"data"];
            NSArray *channelArray = dataDic[@"channelMenuList"];
            for (NSDictionary *dic in channelArray) {
                self.model = [ChannelModel modelWithDictionary:dic];
                [self.arrayModel addObject:self.model];
            }
        } failure:^(NSError * _Nonnull error) {
           
        }];
    }
    return self;
}

@end
