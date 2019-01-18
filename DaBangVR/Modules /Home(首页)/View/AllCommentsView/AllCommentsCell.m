//
//  AllCommentsCell.m
//  DaBangVR
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "AllCommentsCell.h"


@implementation AllCommentsCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModel:(AllCommentsModel *)model{
    _model = model;
    _CommentsContentLabel.text = model.commentContent;
    
}

@end
