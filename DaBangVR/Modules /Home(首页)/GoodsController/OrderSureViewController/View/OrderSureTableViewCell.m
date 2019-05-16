//
//  DBDetailContentCell.m
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "OrderSureTableViewCell.h"

@interface OrderSureTableViewCell()

@end
@implementation OrderSureTableViewCell

#pragma mark —— 懒加载b

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModel:(OrderGoodsModel *)model{
    _model                 = model;
    _goodsNum.text         = model.cartNumber?model.cartNumber:model.number;
    _marketPriceLab.text   = model.marketPrice;
    _sellingPriceLab.text  = [NSString stringWithFormat:@"￥%@",model.retailPrice];
    _goodsDescribeLab.text = model.goodsName;
    [_goodsImgView setImageWithURL:[NSURL URLWithString:model.goodsListUrl?model.goodsListUrl:model.listUrl] placeholder:[UIImage imageNamed:@""]];
}

@end
