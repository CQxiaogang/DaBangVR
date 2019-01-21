//
//  NewCommentCell.h
//  DaBangVR
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "AllCommentsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewCommentCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userImgView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userComments;

@property (nonatomic, strong) AllCommentsModel *model;

@end

NS_ASSUME_NONNULL_END
