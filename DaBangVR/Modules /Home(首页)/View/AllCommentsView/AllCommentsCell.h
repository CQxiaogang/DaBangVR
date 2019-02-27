//
//  AllCommentsCell.h
//  DaBangVR
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CommentsListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AllCommentsCell : BaseTableViewCell
// 头像
@property (weak, nonatomic) IBOutlet UIImageView *userImgView;
// 昵称
@property (weak, nonatomic) IBOutlet UILabel *userName;
//评论内容
@property (weak, nonatomic) IBOutlet UILabel *userComments;


@property (nonatomic, strong)CommentsListModel *model;

@end

NS_ASSUME_NONNULL_END
