//
//  ChannelMenuListView.h
//  DaBangVR
//
//  Created by mac on 2019/1/10.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ChannelModel.h"
#import "ChannelViewCell.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ChannelMenuListViewDelegate <NSObject>

- (void)channelBtnOfClick:(NSInteger)row;

@end

@interface ChannelMenuListView : UIView

@property (nonatomic, weak) id <ChannelMenuListViewDelegate> delegate;

@property (nonatomic, strong) NSArray *data;

@end

NS_ASSUME_NONNULL_END
