//
//  CountryGoodsCollectionViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/2/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "CountryGoodsCollectionViewCell.h"

@implementation CountryGoodsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setModel:(GoodsDetailsModel *)model{
    _model = model;
    [_goodsImgView setImageWithURL:[NSURL URLWithString:model.listUrl] placeholder:[UIImage imageNamed:@""]];
    _goodsDescribe.text = model.describe;
    _goodsPrice.text = model.sellingPrice;
}
- (IBAction)addShoppingCarOfAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(countryGoodsAddShoppingCar:)]) {
        [_delegate countryGoodsAddShoppingCar:sender];
    }
    
}

@end
