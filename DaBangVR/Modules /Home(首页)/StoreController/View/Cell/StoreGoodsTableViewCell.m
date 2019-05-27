//
//  StoreGoodsTableViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/5/15.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "StoreGoodsTableViewCell.h"

@implementation StoreGoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModel:(DeptModel *)model{
    _model = model;
    _storeName.text = model.name;
    [_goodsImgView setImageURL:[NSURL URLWithString:model.categoryImg]];
}

@end
