//
//  DBHeaderView.h
//  DaBangVR
//
//  Created by mac on 2018/11/23.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol headerViewDelegate <NSObject>
// 昵称
- (void)nickNameViewClick;
// 设置
- (void)setupButtonClick;
// 积分商城
- (void)integralMallAction;
// 我的订单
- (void)myOrderAction;
// 购物车
- (void)shoppingCarAction;

@end

@interface MineHeaderView : UIView
// 头像
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
// 名字
@property (weak, nonatomic) IBOutlet UILabel     *nickName;
// 设置按钮
@property (weak, nonatomic) IBOutlet UIButton    *setupBtn;
// 个人简介
@property (weak, nonatomic) IBOutlet UILabel     *individualResume;
// 关注
@property (weak, nonatomic) IBOutlet UILabel     *myAttention;
// 粉丝
@property (weak, nonatomic) IBOutlet UILabel     *myFans;
// 获赞
@property (weak, nonatomic) IBOutlet UILabel     *tags;
// 标题
@property (weak, nonatomic) IBOutlet UILabel     *title;

// 用户信息
@property (nonatomic, strong) UserInfo *userInfo;
@property (nonatomic, assign) id<headerViewDelegate> delegate;

- (void)scrollViewDidScroll:(CGFloat)contentOffsetY;

@end

NS_ASSUME_NONNULL_END
