//
//  LiveCollectionViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "LiveCollectionViewCell.h"

@implementation LiveCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModel:(LiveModel *)model{
    _model = model;
    [_liveCover setImageWithURL:[NSURL URLWithString:model.snapshotPlayURL] placeholder:kDefaultImg];
}

@end
