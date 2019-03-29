
//
//  PLPlayTopView.m
//  DaBangVR
//
//  Created by mac on 2019/3/29.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "PLPlayTopView.h"

@implementation PLPlayTopView

-(void)awakeFromNib{
    [super awakeFromNib];
    _headPortraitImgView.layer.cornerRadius = _headPortraitImgView.mj_h/2;
    _headPortraitImgView.layer.masksToBounds = YES;
    _anchorInfoView.layer.cornerRadius  = kFit(10);
    [_attentionButton setBackgroundImage:[UIImage imageWithGradualChangingColor:^(QQGradualChangingColor *graColor) {
        graColor.fromColor = KWhiteColor;
        graColor.toColor = KLightGreen;
        graColor.type = QQGradualChangeTypeUpLeftToDownRight;
    } size:_attentionButton.size cornerRadius:QQRadiusMakeSame(10)] forState:UIControlStateNormal];
}

- (IBAction)clickCloseButton:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickCloseButton)]) {
        [self.delegate clickCloseButton];
    }
}

@end
