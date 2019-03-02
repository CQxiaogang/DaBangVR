//
//  SortSearchCollectionViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/3/2.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "SortSearchCollectionViewCell.h"

@implementation SortSearchCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModel:(GoodsDetailsModel *)model{
     _model = model;
    [_goodsImgView setImageWithURL:[NSURL URLWithString:model.listUrl] placeholder:kDefaultImg];
    _goodsDetails.text = model.describe;
    _goodsPrice.text = [NSString stringWithFormat:@"￥%@",model.sellingPrice];
}

@end
