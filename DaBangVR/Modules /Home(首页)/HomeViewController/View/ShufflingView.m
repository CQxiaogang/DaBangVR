//
//  ShufflingView.m
//  DaBangVR
//
//  Created by mac on 2019/2/20.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "ShufflingView.h"

#import "GoodsRotationListModel.h"

@implementation ShufflingView

-(instancetype)initWithFrame:(CGRect)frame andIndex:(nonnull NSString *)index{
    self = [super initWithFrame:frame];
    if (self) {
        NSMutableArray *dataSource = [NSMutableArray array];
        dispatch_group_t downloadGroup = dispatch_group_create();
        dispatch_group_enter(downloadGroup);
        [NetWorkHelper POST:URl_goods_rotation_list parameters:@{@"parentId": index} success:^(id  _Nonnull responseObject) {
            NSDictionary *data= KJSONSerialization(responseObject)[@"data"];
            NSArray *goodsArray = data[@"goodsRotationList"];
            for (NSDictionary *dic in goodsArray) {
                GoodsRotationListModel *model = [GoodsRotationListModel modelWithDictionary:dic];
                [dataSource addObject:model];
            }
            dispatch_group_leave(downloadGroup);
        } failure:^(NSError * _Nonnull error) {}];
        
        dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
            HomeBannerView *bannerView = [[HomeBannerView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, self.mj_h) andGoodsArray:dataSource];
            bannerView.delegate = self;
            [self addSubview:bannerView];
        });
    }
    return self;
}
-(void)imageDidSelected:(NSString *)goodsID{
    if (self.delegate && [self.delegate respondsToSelector:@selector(imgDidSelected:)]) {
        [self.delegate imgDidSelected:goodsID];
    }
}

@end
