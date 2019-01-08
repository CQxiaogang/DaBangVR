//
//  informationModificationHeaderView.m
//  DaBangVR
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "informationModificationHeaderView.h"

@implementation informationModificationHeaderView

- (IBAction)addNewAddressAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(addNewAddress)]) {
        [self.delegate addNewAddress];
    }
}
     

@end
