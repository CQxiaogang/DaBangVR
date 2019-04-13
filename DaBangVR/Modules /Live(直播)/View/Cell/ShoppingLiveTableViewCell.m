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
    [_snapshotPlayImgView setImageWithURL:[NSURL URLWithString:model.snapshotPlayURL]placeholder:kDefaultImg];
}

@end
