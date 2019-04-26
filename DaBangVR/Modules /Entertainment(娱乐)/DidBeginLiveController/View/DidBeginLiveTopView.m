//
//  DidBeginLiveTopView.m
//  DaBangVR
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "DidBeginLiveTopView.h"

@interface DidBeginLiveTopView ()
/** 主播头像 */
@property (weak, nonatomic) IBOutlet UIImageView *anchorHeadImgView;
@property (weak, nonatomic) IBOutlet UIButton *dismissBtn;

@end

@implementation DidBeginLiveTopView

-(void)awakeFromNib{
    [super awakeFromNib];
    _anchorHeadImgView.layer.cornerRadius = _anchorHeadImgView.mj_h/2;
}

- (IBAction)dismissAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(dismissAction)]) {
        [self.delegate dismissAction];
    }
}


@end
