//
//  ShouldBeginLiveGoodsCell.m
//  DaBangVR
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "ShouldBeginLiveGoodsCell.h"

@implementation ShouldBeginLiveGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setModel:(ShouldBeginLiveGoodsModel *)model{
    _model = model;
    [_goodsImgView setImageWithURL:[NSURL URLWithString:model.listUrl] placeholder:kDefaultImg];
    _goodsName.text = model.name;
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        _selectBtn.backgroundColor = KRedColor;
    }else{
        _selectBtn.backgroundColor = KGrayColor;
    }
}

@end
