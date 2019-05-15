//
//  CategoryChooseView.m
//  DaBangVR
//
//  Created by mac on 2019/5/14.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "CategoryChooseView.h"

@implementation CategoryChooseView

-(instancetype)init{
    self = [super init];
    if (self) {
//        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    NSMutableArray *buttons = [NSMutableArray new];
    for (int i=0; i<3; i++) {
        UIButton *button = [[UIButton alloc] init];
        [button setBackgroundColor:KLightGreen];
        [buttons addObject:button];
        [self addSubview:button];
    }
    CGFloat m = (KScreenW-210)/3;
    [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:m leadSpacing:m tailSpacing:m];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(70, 70));
        make.centerY.equalTo(self.mas_centerX);
    }];
}

@end
