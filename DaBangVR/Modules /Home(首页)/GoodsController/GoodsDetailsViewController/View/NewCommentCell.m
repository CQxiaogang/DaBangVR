//
//  NewCommentCell.m
//  DaBangVR
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "NewCommentCell.h"

@implementation NewCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(CommentsListModel *)model{
    _model             = model;
    _userName.text     = model.nickName;
    _userComments.text = model.commentContent;
    [_userImgView setImageURL:[NSURL URLWithString:model.headUrl]];
    
}

@end
