//
//  DidBeginLiveGoodsTableViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "DidBeginLiveGoodsTableViewCell.h"

@implementation DidBeginLiveGoodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setModel:(GoodsDetailsModel *)model{
    _model = model;
    [_goodsImgView setImageWithURL:[NSURL URLWithString:model.listUrl] placeholder:kDefaultImg];
    _goodsPrice.text = model.sellingPrice;
    
}

@end
