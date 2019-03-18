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
    _goodsSpec.text = model.goodsSpecNames;
    _sizeLab.text = model.goodsNumber?model.goodsNumber:model.number;
    [_goodsImgView setImageWithURL:[NSURL URLWithString:model.goodsListUrl?model.goodsListUrl:model.listUrl] placeholder:[UIImage imageNamed:@""]];
}
/*订单状态:0待付款
         101订单已取消
         102订单已删除
         201订单已付款
         300订单已发货
         301用户确认收货
         400申请退款
         401退款中
         402完成
         500已评论
 */
-(void)setDepModel:(OrderDeptGoodsModel *)depModel{
    _depModel = depModel;
    NSString *state = depModel.orderState;
    switch ([state integerValue]) {
        case 0: //待付款
            _stateLab.text = kOrderState_forThePayment;
            [_lowerRightCornerBtn setTitle:kOrderState_forThePayment forState:UIControlStateNormal];
            break;
        case 101: //订单已取消
            break;
        case 102: //订单已删除
            break;
        case 201: //订单已付款
            _stateLab.text = kOrderState_ToSendTheGoods;
            [_lowerRightCornerBtn setTitle:kOrderState_ToSendTheGoods forState:UIControlStateNormal];
            break;
        case 300: //订单已发货
            _stateLab.text = kOrderState_forTheGoods;
            [_lowerRightCornerBtn setTitle:kOrderState_ConfirmTheGoods forState:UIControlStateNormal];
            break;
        case 301: //用户确认收货
            _stateLab.text = kOrderState_ToEvaluate;
            [_lowerRightCornerBtn setTitle:kOrderState_ToEvaluate forState:UIControlStateNormal];
            break;
        case 400: //申请退款
            _stateLab.text = @"退款中";
            [_lowerRightCornerBtn setTitle:@"退款中" forState:UIControlStateNormal];
            break;
        case 401: //退款中
            _stateLab.text = @"退款中";
            [_lowerRightCornerBtn setTitle:@"退款中" forState:UIControlStateNormal];
            break;
        case 500: //完成
            _stateLab.text = @"已评论";
            [_lowerRightCornerBtn setTitle:@"已评论" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

@end
