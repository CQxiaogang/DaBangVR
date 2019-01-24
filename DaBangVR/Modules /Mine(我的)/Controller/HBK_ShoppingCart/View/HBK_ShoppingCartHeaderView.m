//
//  HBK_ShoppingCartHeaderView.m
//  HBK_ShoppingCart
//
//  Created by 黄冰珂 on 2017/11/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import "HBK_ShoppingCartHeaderView.h"

@implementation HBK_ShoppingCartHeaderView


- (IBAction)click:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"r-default_select"] forState:(UIControlStateNormal)];
    } else {
        [sender setImage:[UIImage imageNamed:@"r-default"] forState:(UIControlStateNormal)];
    }
    if (self.clickBtn) {
        self.ClickBlock(sender.selected);
    }
}

- (void)setStoreModel:(HBK_StoreModel *)storeModel {
    self.storeNameLabel.text = storeModel.deptName;
    self.isClick = storeModel.isSelect;
}

- (void)setIsClick:(BOOL)isClick {
    _isClick = isClick;
    self.clickBtn.selected = isClick;
    if (isClick) {
        [self.clickBtn setImage:[UIImage imageNamed:@"r-default_select"] forState:(UIControlStateSelected)];
    } else {
        [self.clickBtn setImage:[UIImage imageNamed:@"r-default"] forState:(UIControlStateNormal)];
    }
}

@end
