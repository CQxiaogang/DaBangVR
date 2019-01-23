//
//  DBDetailHeaderView.m
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "DBDetailHeaderView.h"
#import "BuyNowOfUserAddressModel.h"

@implementation DBDetailHeaderView

- (IBAction)alterAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(informationModification)]) {
        [self.delegate informationModification];
    }
    
}

- (void)setModel:(BuyNowModel *)model{
    _model = model;
    _consigneeNameLab.text = model.receivingAddress.consigneeName;
    _consigneePhoneLab.text = model.receivingAddress.consigneePhone;
    _addressLab.text = [NSString stringWithFormat:@"%@%@%@%@%@",
                        model.receivingAddress.receivingCountry,
                        model.receivingAddress.province,
                        model.receivingAddress.city,
                        model.receivingAddress.area,
                        model.receivingAddress.address];
}

@end
