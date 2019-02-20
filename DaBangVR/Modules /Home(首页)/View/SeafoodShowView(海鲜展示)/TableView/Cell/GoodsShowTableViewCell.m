//
//  BaseTableViewCell.m
//  DaBangVR
//
//  Created by mac on 2018/12/24.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "GoodsShowTableViewCell.h"

@implementation GoodsShowTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModel:(GoodsShowListModel *)model{
    [_headImgView setImageWithURL:[NSURL URLWithString:model.listUrl] placeholder:[UIImage imageNamed:@""]];
    _describeLabel.text = model.describe;
    _sellingPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",(float)model.sellingPrice];
}

@end
