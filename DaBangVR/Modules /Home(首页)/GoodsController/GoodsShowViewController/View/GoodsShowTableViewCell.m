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
    _describeLabel.text     = model.name;
    _salesVolumeLabel.text  = [NSString stringWithFormat:@"销量:%@",model.salesVolume];
    _sellingPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.sellingPrice];
    [_headImgView setImageWithURL:[NSURL URLWithString:model.listUrl] placeholder:[UIImage imageNamed:@""]];
}

@end
