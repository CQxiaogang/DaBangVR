//
//  modifyAddressViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "modifyAddressViewCell.h"

@implementation modifyAddressViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentText.font = [UIFont systemFontOfSize:Adapt(14)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(ModifyAddressModel *)model{
//    self.titleLabel.text = (NSString *)model;
    //    self.contentText.text = infoModel.content;
}

@end
