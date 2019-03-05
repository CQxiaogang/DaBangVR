//
//  DBTopView.m
//  DaBangVR
//
//  Created by mac on 2018/12/8.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "DBTopView.h"

@implementation DBTopView

-(void)awakeFromNib{
    [super awakeFromNib];
    // 用户交互开启
    _searchBox.userInteractionEnabled = YES;
}

- (IBAction)shoppingCarAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shoppingCarClickAction)]) {
        [self.delegate shoppingCarClickAction];
    }
}


@end
