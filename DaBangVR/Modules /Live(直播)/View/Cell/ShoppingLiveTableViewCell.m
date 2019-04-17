//
//  DBLiveTableViewCell.m
//  DaBangVR
//
//  Created by mac on 2018/11/22.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "ShoppingLiveTableViewCell.h"

@implementation ShoppingLiveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setModel:(LiveModel *)model{
    _model = model;
    [_snapshotPlayImgView setImageWithURL:[NSURL URLWithString:model.coverUrl]placeholder:kDefaultImg];
    _nickName.text = model.anchorName;
    [_headImgView setImageWithURL:[NSURL URLWithString:model.headUrl] placeholder:kDefaultImg];
    [_goodsImgView1 setImageWithURL:[NSURL URLWithString:model.liveGoodsList[0].listUrl] placeholder:kDefaultImg];
    [_goodsImgView2 setImageWithURL:[NSURL URLWithString:model.liveGoodsList[1].listUrl] placeholder:kDefaultImg];
    [_goodsImgView3 setImageWithURL:[NSURL URLWithString:model.liveGoodsList[2].listUrl] placeholder:kDefaultImg];
}

@end
