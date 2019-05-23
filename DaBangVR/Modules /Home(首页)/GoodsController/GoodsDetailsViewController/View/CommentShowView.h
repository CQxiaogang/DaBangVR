//
//  CommentShowView.h
//  DaBangVR
//
//  Created by mac on 2019/5/22.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentShowView : UIView
//评论
@property (weak, nonatomic) IBOutlet UILabel *commentNumLabel;
//销售
@property (weak, nonatomic) IBOutlet UILabel *sellNumLabel;

@property (nonatomic, strong) GoodsDetailsModel *model;
@end

NS_ASSUME_NONNULL_END
