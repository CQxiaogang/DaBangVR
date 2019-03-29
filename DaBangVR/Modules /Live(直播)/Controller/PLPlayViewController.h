//
//  PLPlayViewController.h
//  NiuPlayer
//
//  Created by hxiongan on 2018/3/9.
//  Copyright © 2018年 hxiongan. All rights reserved.
//

#import "PLBaseViewController.h"
/** 七牛云直播 */
//#import <PLPlayerKit/PLPlayerKit.h>

@interface PLPlayViewController : PLBaseViewController
<
PLPlayerDelegate
>

@property (nonatomic, strong) PLPlayer      *player;
@property (nonatomic, strong) UIButton      *playButton;
/** 开始播放前的背景图片界面 */
@property (nonatomic, strong) UIImageView   *thumbImageView;
/** 关闭直播界面按钮 */
@property (nonatomic, strong) UIButton      *closeButton;
/** 直播地址 */
@property (nonatomic, strong) NSURL *url;
/** 开始播放前的背景图片 */
@property (nonatomic, strong) UIImage *thumbImage;
/** 开始播放前的背景图片地址 */
@property (nonatomic, strong) NSURL *thumbImageURL;

//是否启用手指滑动调节音量和亮度, default YES
@property (nonatomic, assign) BOOL enableGesture;

@end
