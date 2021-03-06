//
//  NewGoodsCollectionViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "NewGoodsCollectionViewCell.h"

@implementation NewGoodsCollectionViewCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // 改变控件样式
    [UIView viewOfStyle:_nowBuy borderColor:KWhiteColor fillColor:KRedColor];
}

- (void)setModel:(GoodsDetailsModel *)model{
    _model = model;
    [_goodsImgView setImageURL:[NSURL URLWithString:model.listUrl]];
    _goodsDescribe.text = model.describe;
    _goodsPrice.text = [NSString stringWithFormat:@"￥ %@",model.sellingPrice];
}

@end
