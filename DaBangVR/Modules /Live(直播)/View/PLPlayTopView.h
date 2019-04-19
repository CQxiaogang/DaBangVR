//
//  PLPlayTopView.h
//  DaBangVR
//
//  Created by mac on 2019/3/29.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PLPlayTopViewDelegate <NSObject>

- (void)clickCloseButton;

@end

@interface PLPlayTopView : UIView
/** 主播头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headPortraitImgView;
/** 用户名字 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
/** 粉丝数量 */
@property (weak, nonatomic) IBOutlet UILabel *fansNumLabel;
/** 关注按钮 */
@property (weak, nonatomic) IBOutlet UIButton *attentionButton;
/** 装载主播信息的背景视图 */
@property (weak, nonatomic) IBOutlet UIView *anchorInfoView;
/** 关闭直播界面按钮 */
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (weak, nonatomic) id<PLPlayTopViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
