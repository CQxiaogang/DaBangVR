//
//  TimeChooseView.m
//  DaBangVR
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "TimeChooseView.h"

@implementation TimeChooseView
// 即将秒杀
- (IBAction)seeGoods:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonSelectAction:)]) {
        [self.delegate buttonSelectAction:sender];
    }
}
// 正在秒杀
- (IBAction)isKill:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonSelectAction:)]) {
        [self.delegate buttonSelectAction:sender];
    }
}
// 结束秒杀
- (IBAction)endKill:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonSelectAction:)]) {
        [self.delegate buttonSelectAction:sender];
    }
}

@end
