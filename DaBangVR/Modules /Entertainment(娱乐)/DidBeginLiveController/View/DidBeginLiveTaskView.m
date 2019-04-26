//
//  DidBeginLiveTaskView.m
//  DaBangVR
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "DidBeginLiveTaskView.h"

@interface DidBeginLiveTaskView ()
/** 任务数量 */
@property (weak, nonatomic) IBOutlet UILabel *taskNumberLabel;

@end

@implementation DidBeginLiveTaskView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    _taskNumberLabel.layer.cornerRadius = _taskNumberLabel.mj_h/2;
    _taskNumberLabel.layer.masksToBounds = YES;
    //使用贝塞尔曲线画圆角及指定位置圆角
    CGFloat radius = _taskNumberLabel.mj_h;
    UIRectCorner corner = UIRectCornerTopRight|UIRectCornerBottomRight;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}

@end
