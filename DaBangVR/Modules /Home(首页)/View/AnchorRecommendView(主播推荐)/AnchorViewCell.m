//
//  LiveRecommendView.m
//  DaBangVR
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "AnchorViewCell.h"

@implementation AnchorViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)setupUI{
    _anchorImageView.layer.cornerRadius = _anchorImageView.mj_w/2;
}
@end
