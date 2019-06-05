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
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    CGFloat width   = 75;//宽
    CGFloat height  = 75;//高
    CGFloat spacing = (KScreenW - width*3)/4;//间距
    for (int i=0; i<3; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i*(width+spacing)+spacing, 0, width, height)];
        [button setBackgroundColor:KRandomColor];
        [self addSubview:button];
    }
}

@end
