//
//  AllOrdersCell.m
//  DaBangVR
//
//  Created by mac on 2019/1/9.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "AllOrdersCell.h"

@implementation AllOrdersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) setupUI{
    _lowerRightCornerBtn.layer.borderColor = KOrangeColor.CGColor;
    _lowerRightCornerBtn.layer.borderWidth = 0.5;
    _lowerRightCornerBtn.layer.cornerRadius = Adapt(10);
}
// 右下角 button 点击事件
- (IBAction)lowerRightCornerBtnAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(lowerRightCornerClickEvent:)]) {
        [self.delegate lowerRightCornerClickEvent:btn.titleLabel.text];
    }
}

- (void)setModel:(MyOrderModel *)model{
    _model = model;
    _priceLab.text = model.retailPrice;
    _goodsNameLab.text = model.goodsName;
    _sizeLab.text = model.goodsNumber;
}

@end
