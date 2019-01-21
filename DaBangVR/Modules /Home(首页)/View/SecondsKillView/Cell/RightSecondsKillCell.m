//
//  RightSecondsKillCell.m
//  DaBangVR
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "RightSecondsKillCell.h"

@implementation RightSecondsKillCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _CancelReminderBtn.layer.cornerRadius = Adapt(8);
    _CancelReminderBtn.layer.borderColor = [[UIColor lightGreen] CGColor];
    _CancelReminderBtn.layer.borderWidth = 0.5f;
    _CancelReminderBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
