//
//  HBK_ShopppingCartBottomView.m
//  HBK_ShoppingCart
//
//  Created by 黄冰珂 on 2017/11/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "HBK_ShopppingCartBottomView.h"

@implementation HBK_ShopppingCartBottomView

- (IBAction)allClickBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"r-default_select"] forState:(UIControlStateSelected)];
    } else {
        [sender setImage:[UIImage imageNamed:@"r-default"] forState:(UIControlStateNormal)];
    }
    if (self.AllClickBlock) {
        self.AllClickBlock(sender.selected);
    }
}

- (IBAction)accountBtn:(UIButton *)sender {
    if (self.AccountBlock) {
        self.AccountBlock();
    }
}

- (void)setIsClick:(BOOL)isClick {
    _isClick = isClick;
    self.clickBtn.selected = isClick;
    if (isClick) {
        [self.clickBtn setImage:[UIImage imageNamed:@"r-default_select"] forState:(UIControlStateNormal)];
    } else {
        [self.clickBtn setImage:[UIImage imageNamed:@"r-default"] forState:(UIControlStateNormal)];
    }
}
// 去付款
- (IBAction)goPaymentBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(goPaymentOfClick)]) {
        [self.delegate goPaymentOfClick];
    }
}

@end
