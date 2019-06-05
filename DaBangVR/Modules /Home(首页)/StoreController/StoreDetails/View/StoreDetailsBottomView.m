//
//  StoreDetailsBottomView.m
//  DaBangVR
//
//  Created by mac on 2019/5/29.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "StoreDetailsBottomView.h"

@implementation StoreDetailsBottomView

- (IBAction)shoppingCarButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shoppingCarButtonClick:)]) {
        [self.delegate shoppingCarButtonClick:sender];
    }
}

- (IBAction)totalPriceButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(totalPriceButtonClick:)]) {
        [self.delegate totalPriceButtonClick:sender];
    }
}

//- (void)setShoppingCarButton:(UIButton *)shoppingCarButton{
//    
//}

@end
