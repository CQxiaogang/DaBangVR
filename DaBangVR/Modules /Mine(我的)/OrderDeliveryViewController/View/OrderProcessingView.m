//
//  OrderDeliveryView.m
//  DaBangVR
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "OrderProcessingView.h"

@implementation OrderProcessingView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    _contentView.layer.borderColor = [KWhiteColor CGColor];
    _contentView.layer.borderWidth = 2.0f;
    _contentView.layer.masksToBounds = YES;
}

@end
