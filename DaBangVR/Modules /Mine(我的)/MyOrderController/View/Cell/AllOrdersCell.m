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
}

- (void)setModel:(OrderGoodsModel *)model{
    _model = model;
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
            break;
        case 101: //订单已取消
            break;
        case 102: //订单已删除
            break;
        case 201: //订单已付款
            _stateLab.text = kOrderState_ToSendTheGoods;
            break;
        case 300: //订单已发货
            _stateLab.text = kOrderState_forTheGoods;
            break;
        case 301: //用户确认收货
            _stateLab.text = kOrderState_ToEvaluate;
            break;
        case 400: //申请退款
            _stateLab.text = @"退款中";
            break;
        case 401: //退款中
            _stateLab.text = @"退款中";
            break;
        case 500: //完成
            _stateLab.text = @"已评论";
            break;
        default:
            break;
    }
}

@end
