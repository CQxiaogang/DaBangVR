//
//  ZLBounceView.m
//  DaBangVR
//
//  Created by mac on 2019/4/23.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "DB_BounceView.h"

@interface DB_BounceView ()
@property (nonatomic, assign) CGFloat contentViewHight;
@end

@implementation DB_BounceView

-(instancetype)initWithContentViewFrame:(CGRect)frame{
    self = [super init];
    if (self) {
        _contentViewHight = frame.size.height;
        [self setupContetn:(CGRect)frame];
    }
    return self;
}

-(void)setupContetn:(CGRect )frame{
    self.frame = CGRectMake(0, 0, KScreenW, KScreenH);
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    if (_contentView == nil) {
        _contentView = [[UIView alloc] initWithFrame:frame];
        _contentView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:.5f];
        [self addSubview:_contentView];
        //使用贝塞尔曲线画圆角及指定位置圆角
        CGFloat radius = kFit(20);
        UIRectCorner corner = UIRectCornerTopLeft|UIRectCornerTopRight;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:_contentView.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _contentView.bounds;
        maskLayer.path = path.CGPath;
        _contentView.layer.mask = maskLayer;
    }
}

- (void)showInView:(UIView *)view {
    if (!view) {
        return;
    }
    [view addSubview:self];
    [view addSubview:_contentView];
    [_contentView setMj_y:KScreenH];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        [self.contentView setMj_y:KScreenH - self.contentViewHight];
    } completion:nil];
}

- (void)disMissView {
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.alpha = 0.0;
                         [self.contentView setMj_y:KScreenH];
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         [self.contentView removeFromSuperview];
                         if (self.delegate && [self.delegate respondsToSelector:@selector(dismissViewShowButton)]) {
                             [self.delegate dismissViewShowButton];
                         }
                     }];
    
}

@end
