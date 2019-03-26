//
//  OrderTableViewFooterView.m
//  DaBangVR
//
//  Created by mac on 2019/3/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "OrderTableViewFooterView.h"

@implementation OrderTableViewFooterView

-(void)awakeFromNib{
    [super awakeFromNib];
    _stateChangeOfButton.layer.borderColor = KOrangeColor.CGColor;
    _stateChangeOfButton.layer.borderWidth = 0.5;
    _stateChangeOfButton.layer.cornerRadius = kFit(_stateChangeOfButton.mj_h/2);
}

- (IBAction)stateChangeOfButton:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(stateChangeOfButton:)]) {
        [self.delegate stateChangeOfButton:btn.titleLabel.text];
    }
    
}

- (void)setDepModel:(OrderDeptGoodsModel *)depModel{
    _goodsPrice.text = [NSString stringWithFormat:@"￥%@",depModel.totalPrice];
    NSString *state = depModel.orderState;
    switch ([state integerValue]) {
        case 0: //待付款
            [_stateChangeOfButton setTitle:kOrderState_forThePayment forState:UIControlStateNormal];
            break;
        case 101: //订单已取消
            break;
        case 102: //订单已删除
            break;
        case 201: //订单已付款
            [_stateChangeOfButton setTitle:kOrderState_ToSendTheGoods forState:UIControlStateNormal];
            break;
        case 300: //订单已发货
            [_stateChangeOfButton setTitle:kOrderState_ConfirmTheGoods forState:UIControlStateNormal];
            break;
        case 301: //用户确认收货
            [_stateChangeOfButton setTitle:kOrderState_ToEvaluate forState:UIControlStateNormal];
            break;
        case 400: //申请退款
            [_stateChangeOfButton setTitle:@"退款中" forState:UIControlStateNormal];
            break;
        case 401: //退款中
            [_stateChangeOfButton setTitle:@"退款中" forState:UIControlStateNormal];
            break;
        case 500: //完成
            [_stateChangeOfButton setTitle:@"已评论" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}

@end
