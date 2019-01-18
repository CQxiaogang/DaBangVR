//
//  AllCommentsCell.h
//  DaBangVR
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "AllCommentsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AllCommentsCell : BaseTableViewCell
// 头像
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
// 昵称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//评论内容
@property (weak, nonatomic) IBOutlet UILabel *CommentsContentLabel;


@property (nonatomic, strong)AllCommentsModel *model;

@end

NS_ASSUME_NONNULL_END
