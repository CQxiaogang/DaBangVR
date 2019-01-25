//
//  informationModificationCell.m
//  DaBangVR
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "informationModificationCell.h"

@implementation informationModificationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setModel:(UserInfoChangeModel *)model{
    _model = model;
    _userName.text = model.consigneeName;
    _userPhoneNum.text = model.consigneePhone;
    _adress.text = [NSString stringWithFormat:@"%@%@%@%@",model.province,
                                                          model.city,
                                                          model.area,
                                                          model.address];
}
- (IBAction)defaultAddressBtn:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(defaultAdressSelect)]) {
        [self.delegate defaultAdressSelect];
    }
    
}
- (IBAction)changeAdressBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeAdress)]) {
        [self.delegate changeAdress];
    }
}
- (IBAction)deleteAdressBtn:(id)sender {
}

@end
