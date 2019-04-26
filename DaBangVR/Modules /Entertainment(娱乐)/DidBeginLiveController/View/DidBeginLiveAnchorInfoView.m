//
//  DidBeginLiveAnchorInfoView.m
//  DaBangVR
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "DidBeginLiveAnchorInfoView.h"

@implementation DidBeginLiveAnchorInfoView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:.4f];
    //使用贝塞尔曲线画圆角及指定位置圆角
    CGFloat radius = kFit(17);
    UIRectCorner corner = UIRectCornerTopRight|UIRectCornerBottomRight;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}

@end
