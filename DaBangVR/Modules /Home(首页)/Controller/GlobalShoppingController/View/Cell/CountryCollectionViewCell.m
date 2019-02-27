//
//  CountryCollectionViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/2/25.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "CountryCollectionViewCell.h"

@implementation CountryCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModel:(CountryListModel *)model{
    _model = model;
    [_iconImgView setImageURL:[NSURL URLWithString:model.categoryImg]];
    _titleLab.text = model.name;
}

@end
