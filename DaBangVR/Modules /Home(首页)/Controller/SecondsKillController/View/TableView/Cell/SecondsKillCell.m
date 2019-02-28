//
//  SecondsKillCell.m
//  DaBangVR
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "SecondsKillCell.h"

@implementation SecondsKillCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _BuyNowBtn.layer.cornerRadius = Adapt(8);
    _BuyNowBtn.layer.borderColor = [[UIColor redColor] CGColor];
    _BuyNowBtn.layer.borderWidth = 0.5f;
    _BuyNowBtn.layer.masksToBounds = YES;
}

- (void)setModel:(GoodsDetailsModel *)model{
    _model = model;
    [_goodsImgView setImageWithURL:[NSURL URLWithString:model.listUrl] placeholder:nil];
    _goodsDetails.text = model.describe;
    _goodsMarketPrice.text = model.marketPrice;
    _goodsSellingPrice.text = model.sellingPrice;
}

@end
