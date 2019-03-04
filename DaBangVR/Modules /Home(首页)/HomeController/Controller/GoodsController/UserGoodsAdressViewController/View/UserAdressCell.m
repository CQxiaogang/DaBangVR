//
//  informationModificationCell.m
//  DaBangVR
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "UserAdressCell.h"

@implementation UserAdressCell

- (void)setModel:(UserInfoChangeModel *)model{
    _model = model;
    _userName.text = model.consigneeName;
    _userPhoneNum.text = model.consigneePhone;
    _adress.text = [NSString stringWithFormat:@"%@%@%@%@",model.province,
                                                          model.city,
                                                          model.area,
                                                          model.address];
    if ([model.isDefault isEqualToString:@"0"]) {
        [_defaultAdress setImage:[UIImage imageNamed:@"r-default"] forState:(UIControlStateNormal)];
    }else{
        [_defaultAdress setImage:[UIImage imageNamed:@"r-default_select"] forState:(UIControlStateNormal)];
    }
    
}
- (IBAction)defaultAddressBtn:(UIButton *)sender {
//    sender.selected = !sender.selected;
//    if (sender.selected) {
//        [sender setImage:[UIImage imageNamed:@"r-default_select"] forState:(UIControlStateNormal)];
//    } else {
//        [sender setImage:[UIImage imageNamed:@"r-default"] forState:(UIControlStateNormal)];
//    }
    
}
- (IBAction)changeAdressBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeAdress)]) {
        [self.delegate changeAdress];
    }
}
- (IBAction)deleteAdressBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteAdress)]) {
        [self.delegate deleteAdress];
    }
}

@end
