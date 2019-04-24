//
//  ZLBounceView.m
//  DaBangVR
//
//  Created by mac on 2019/4/23.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "ZLBounceView.h"
#define KContentViewH 150

@implementation ZLBounceView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self setupContetn];
    }
    return self;
}

-(void)setupContetn{
    self.frame = CGRectMake(0, 0, KScreenW, KScreenH);
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    if (_contentView == nil) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenH-KContentViewH, KScreenW, KContentViewH)];
        _contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_contentView];
    }
}

- (void)showInView:(UIView *)view {
    if (!view) {
        return;
    }
    [view addSubview:self];
    [view addSubview:_contentView];
    [_contentView setFrame:CGRectMake(0, KScreenH, KScreenW, KContentViewH)];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        [self.contentView setFrame:CGRectMake(0, KScreenH - KContentViewH, KScreenW, KContentViewH)];
    } completion:nil];
}

- (void)disMissView {
    [_contentView setFrame:CGRectMake(0, KScreenH - KContentViewH, KScreenW, KContentViewH)];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.alpha = 0.0;
                         [self.contentView setFrame:CGRectMake(0, KScreenH, KScreenW, KContentViewH)];
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         [self.contentView removeFromSuperview];
                     }];
    
}

@end
