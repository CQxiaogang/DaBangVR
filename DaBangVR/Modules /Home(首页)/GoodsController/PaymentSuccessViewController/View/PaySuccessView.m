//
//  PaySuccessView.m
//  DaBangVR
//
//  Created by mac on 2019/2/20.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "PaySuccessView.h"
#import "UIView+FontSize.h"

@implementation PaySuccessView

-(void)layoutSubviews{
    [super layoutSubviews];
    
//    _headImgView.layer.cornerRadius = kFit(_headImgView.mj_h/2);
//    _headImgView.layer.masksToBounds = YES;
    [self setupType:_continueShoppingBtn];
    [self setupType:_examineOrderBtn];
}

- (void)setupType:(UIView *)view{
    view.layer.cornerRadius = kFit(10);
    view.layer.borderColor = [[UIColor lightGreen] CGColor];
    view.layer.borderWidth = .5f;
    view.layer.masksToBounds = YES;
}
// 查看订单 tag = 10;
- (IBAction)examineOrder:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickAction:)]) {
        [self.delegate buttonClickAction:((UIButton *)sender).tag];
    }
}
// 继续购物 tag = 11;
- (IBAction)continueShopping:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickAction:)]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(buttonClickAction:)]) {
            [self.delegate buttonClickAction:((UIButton *)sender).tag];
        }
    }
}

@end
