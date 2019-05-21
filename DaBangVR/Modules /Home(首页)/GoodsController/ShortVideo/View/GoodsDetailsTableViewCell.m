//
//  GoodsDetailsTableViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/5/21.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "GoodsDetailsTableViewCell.h"

@implementation GoodsDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor  = KRandomColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
