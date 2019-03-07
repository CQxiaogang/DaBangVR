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
    _lowerRightCornerBtn.layer.cornerRadius = kFit(_lowerRightCornerBtn.mj_h/2);
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
    [_goodsImgView setImageWithURL:[NSURL URLWithString:model.goodsListUrl] placeholder:[UIImage imageNamed:@""]];
}

-(void)setDepModel:(OrderDeptGoodsModel *)depModel{
    _depModel = depModel;
    NSString *state = depModel.orderState;
    if ([state compare:@"0"] == NSOrderedSame) {
        _stateLab.text = kOrderState_forThePayment;
        [_lowerRightCornerBtn setTitle:kOrderState_forThePayment forState:UIControlStateNormal];
    }else if ([state compare:@"201"] == NSOrderedSame){
        _stateLab.text = kOrderState_ToSendTheGoods;
        [_lowerRightCornerBtn setTitle:kOrderState_ToSendTheGoods forState:UIControlStateNormal];
    }else if ([state compare:@"302"] == NSOrderedSame){
        _stateLab.text = kOrderState_ToEvaluate;
        [_lowerRightCornerBtn setTitle:kOrderState_ToEvaluate forState:UIControlStateNormal];
    }else if ([state compare:@"401"] == NSOrderedSame){
        _stateLab.text = @"退款中";
        [_lowerRightCornerBtn setTitle:@"退款中" forState:UIControlStateNormal];
    }
}

@end
