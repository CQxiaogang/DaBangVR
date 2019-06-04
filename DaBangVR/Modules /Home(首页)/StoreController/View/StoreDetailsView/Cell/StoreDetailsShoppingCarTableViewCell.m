//
//  StoreDetailsShoppingCarTableViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/6/4.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "StoreDetailsShoppingCarTableViewCell.h"

@implementation StoreDetailsShoppingCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _plusButton.backgroundColor = KLightGreen;
    _minusButton.layer.borderColor = KLightGreen.CGColor;
    
}

- (IBAction)plusButton:(id)sender {
}

- (IBAction)minusButton:(id)sender {
}

- (void)setModel:(StoreDetailsShoppingCarModel *)model{
    _model = model;
    _goodsNameLabel.text = model.title;
    _goodsSpecificationsLabel.text = model.specifications;
    _goodsPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
    [_goodsImgView setImageURL:[NSURL URLWithString:model.pictureUrl]];
}

@end
