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

- (void)setModel:(OrderGoodsModel *)model{
    _model = model;
    _priceLab.text = model.retailPrice;
    _goodsNameLab.text = model.goodsName;
    _sizeLab.text = model.goodsNumber;
    [_goodsImgView setImageWithURL:[NSURL URLWithString:model.listUrl] placeholder:[UIImage imageNamed:@""]];
    NSString *goodsState = model.goodsState;
    if ([goodsState compare:@"0"] == NSOrderedSame) {
        _stateLab.text = @"待付款";
        [_lowerRightCornerBtn setTitle:@"待付款" forState:UIControlStateNormal];
    }else if ([goodsState compare:@"201"] == NSOrderedSame){
        _stateLab.text = @"待收货";
        [_lowerRightCornerBtn setTitle:@"待收货" forState:UIControlStateNormal];
    }else if ([goodsState compare:@"302"] == NSOrderedSame){
        _stateLab.text = @"待评价";
        [_lowerRightCornerBtn setTitle:@"待评价" forState:UIControlStateNormal];
    }else if ([goodsState compare:@"401"] == NSOrderedSame){
        _stateLab.text = @"退款中";
        [_lowerRightCornerBtn setTitle:@"退款中" forState:UIControlStateNormal];
    }
}

@end
