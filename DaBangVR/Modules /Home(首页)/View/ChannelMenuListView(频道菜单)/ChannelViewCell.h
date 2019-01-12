//
//  ChannelView.h
//  DaBangVR
//
//  Created by mac on 2019/1/10.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChannelModel.h"
NS_ASSUME_NONNULL_BEGIN


@interface ChannelViewCell : UICollectionViewCell
// 频道图片
@property (weak, nonatomic) IBOutlet UIButton *channelBtn;
// 频道标题
@property (weak, nonatomic) IBOutlet UILabel *channelTitle;

@property (nonatomic, strong) ChannelModel *model;

@end

NS_ASSUME_NONNULL_END
