//
//  MineCollectionTableViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/2/12.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "MineCollectionTableViewCell.h"

@implementation MineCollectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setModel:(OrderGoodsModel *)model{
    _model = model;
    _goodsDetail.text = model.goodsName;
    _PromotionPrice.text = [NSString stringWithFormat:@"￥%@",model.marketPrice];
    [_goodsImgView setImageWithURL:[NSURL URLWithString:model.listUrl] placeholder:kDefaultImg];
}

@end
