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
    _liveLal.backgroundColor = KClearColor;
//    _liveLal = (UILabel *)[UIView viewOfStyle:_liveLal borderColor:KWhiteColor fillColor:KRedColor];
}

- (void)setModel:(GoodsShowListModel *)model{
    [_headImgView setImageWithURL:[NSURL URLWithString:model.listUrl] placeholder:[UIImage imageNamed:@""]];
    _describeLabel.text = model.describe;
    _sellingPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.sellingPrice];
}

@end
