//
//  BaseTableViewCell.h
//  DaBangVR
//
//  Created by mac on 2018/12/24.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeafoodShowModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SeafoodShowTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet YYAnimatedImageView *headImgView;

@property (strong, nonatomic) SeafoodShowModel *model;

@end

NS_ASSUME_NONNULL_END
