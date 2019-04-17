//
//  DBHeaderView.m
//  DaBangVR
//
//  Created by mac on 2018/11/23.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "MineHeaderView.h"

@implementation MineHeaderView

#pragma mark —— 懒加载
-(UILabel *)nickName{
    if (_nickName) {
        // 1. 创建一个点击事件，点击时触发labelClick方法
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nickNameViewClick)];
        // 2. 将点击事件添加到label上
        [_nickName addGestureRecognizer:tap];
        // 可以理解为设置label可被点击
        _nickName.userInteractionEnabled = YES;
    }
    return _nickName;
}

#pragma mark —— 系统方法
-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self setupContent];
    
    [self setupUI];
    
    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
}

#pragma mark —— UI细节设置
- (void)setupUI{
    _headImageView.layer.cornerRadius = Adapt(_headImageView.mj_h/2);
    // 将多余的部分切掉
    _headImageView.layer.masksToBounds = YES;
    
    //设置headerView中label属性，根据内容显示字体大小
    _myFans.adjustsFontSizeToFitWidth = YES;
    _tags.adjustsFontSizeToFitWidth   = YES;
    _myAttention.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.nickName];
}
#pragma mark —— 值设置
- (void)setupContent{
    
    _nickName.text = curUser.nickName?:@"点击登录";
    _headImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:curUser.headUrl]]]?:[UIImage imageNamed:@"theDefaultAvatar"];
}

#pragma mark —— 昵称点击
- (void)nickNameViewClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(nickNameViewClick)]) {
        
        [self.delegate nickNameViewClick];
    }
}
#pragma mark —— 设置 button

- (IBAction)setupButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(setupButtonClick)]) {
        [self.delegate setupButtonClick];
    }
}
#pragma mark —— 任务中心
- (IBAction)taskCenterAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(taskCenterAction)]) {
        [self.delegate taskCenterAction];
    }
}
#pragma mark —— 积分商城
- (IBAction)integralMallAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(integralMallAction)]) {
        [self.delegate integralMallAction];
    }
}
#pragma mark —— 我的订单
- (IBAction)myOrderAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(myOrderAction)]) {
        [self.delegate myOrderAction];
    }
}
#pragma mark —— 购物车
- (IBAction)shoppingCartAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shoppingCarAction)]) {
        [self.delegate shoppingCarAction];
    }
}

@end
