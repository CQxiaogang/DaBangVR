//
//  GoodsRecommendCollectionViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/5/22.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "GoodsRecommendCollectionViewCell.h"

@implementation GoodsRecommendCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = kFit(5);
}

-(void)setModel:(GoodsShowListModel *)model{
    _model                  = model;
    _goodsPriceLabel.text   = model.marketPrice;
    _goodsDetailsLabel.text = model.name;
    [_goodsImgView setImageURL:[NSURL URLWithString:model.listUrl]];
}

@end
