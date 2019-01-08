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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setInfoModel:(modifyAddressModel *)infoModel{
    self.titleLabel.text = infoModel.title;
//    self.contentText.text = infoModel.content;
}

@end
