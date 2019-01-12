//
//  ChannelView.m
//  DaBangVR
//
//  Created by mac on 2019/1/10.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "ChannelViewCell.h"

@implementation ChannelViewCell

// 频道按钮点击事件
- (IBAction)chananelBtnAction:(id)sender {
    
}

- (void)setModel:(ChannelModel *)model{
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.iconUrl]];
    [_channelBtn setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
    
    _channelTitle.text = model.title;
}

@end
