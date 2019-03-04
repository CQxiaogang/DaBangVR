//
//  DBtableViewCell.m
//  DaBangVR
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModel:(GoodsDetailsModel *)model{
    _model = model;
    [_goodsImgView setImageWithURL:[NSURL URLWithString:model.listUrl] placeholder:nil];
    _goodsDetails.text = model.describe;
    _goodsPrice.text = [NSString stringWithFormat:@"￥ %@",model.sellingPrice];
}

@end
