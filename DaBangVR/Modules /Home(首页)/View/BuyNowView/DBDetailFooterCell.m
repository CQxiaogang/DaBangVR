//
//  DBDetailFooterCell.m
//  DaBangVR
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "DBDetailFooterCell.h"

@implementation DBDetailFooterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.textLabel.font = [UIFont fontWithName:@"Thonburi" size:14];
    self.textLabel.textColor = KFontColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
