//
//  RecommendGoodsCollectionViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/2/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "RecommendGoodsCollectionViewCell.h"

@implementation RecommendGoodsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(GoodsDetailsModel *)model{
    [_goodsImgView setImageWithURL:[NSURL URLWithString:model.listUrl] placeholder:[UIImage imageNamed:@""]];
    _goodsDescribe.text = model.describe;
    _goodsMarketPrice.text = model.marketPrice;
    _goodsSellingPrice.text = model.sellingPrice;
}
- (IBAction)andShoppingCarOfAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(recommendGoodsAddShoppingCar:)]) {
        [self.delegate recommendGoodsAddShoppingCar:sender];
    }
}

@end
