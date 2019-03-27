//
//  LiveCollectionViewCell.h
//  DaBangVR
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LiveCollectionViewCell : UICollectionViewCell
/** 封面图片 */
@property (weak, nonatomic) IBOutlet UIImageView *liveCover;

@property (nonatomic, strong) LiveModel *model;

@end

NS_ASSUME_NONNULL_END
