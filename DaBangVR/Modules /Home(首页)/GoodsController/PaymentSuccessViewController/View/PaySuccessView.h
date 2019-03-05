//
//  PaySuccessView.h
//  DaBangVR
//
//  Created by mac on 2019/2/20.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol PaySuccessViewDelegate <NSObject>

- (void)buttonClickAction:(NSInteger)tag;

@end

@interface PaySuccessView : UIView
// 头像
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
// 继续购物
@property (weak, nonatomic) IBOutlet UIButton *continueShoppingBtn;
// 查看订单
@property (weak, nonatomic) IBOutlet UIButton *examineOrderBtn;

@property (weak, nonatomic) id<PaySuccessViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
