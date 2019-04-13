//
//  LIveCommentTableViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/4/13.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "LiveCommentTableViewCell.h"

@implementation LiveCommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //cell颠倒
    self.contentView.transform = CGAffineTransformMakeScale(1, -1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
