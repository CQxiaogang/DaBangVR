//
//  DBDetailHeaderView.m
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "OrderSureTopView.h"
#import "UserAddressModel.h"

@implementation OrderSureTopView
// 修改地址
- (IBAction)alterAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(informationModification)]) {
        [self.delegate informationModification];
    }
    
}

- (void)setModel:(UserAddressModel *)model{
    _model = model;
    _consigneeNameLab.text = model.consigneeName;
    _consigneePhoneLab.text = model.consigneePhone;
    _addressLab.text = [NSString stringWithFormat:@"%@%@%@%@%@",
                        model.receivingCountry,
                        model.province,
                        model.city,
                        model.area,
                        model.address];
}

@end
