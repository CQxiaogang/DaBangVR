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

- (void)setModel:(CommentsListModel *)model{
    _model = model;
    _userComments.text = model.commentContent;
    _userName.text = model.nickName;
    [_userImgView setImageURL:[NSURL URLWithString:model.headUrl]];
}

@end
