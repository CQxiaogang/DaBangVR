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

- (void)setModel:(OrderSureGoodsModel *)model{
    _model = model;
    [_goodsImgView setImageWithURL:[NSURL URLWithString:model.listUrl] placeholder:[UIImage imageNamed:@""]];
    _goodsDescribeLab.text = model.goodsName;
    _sellingPriceLab.text = model.retailPrice;
    _marketPriceLab.text = model.marketPrice;
    _goodsNum.text = model.number;
}

@end
