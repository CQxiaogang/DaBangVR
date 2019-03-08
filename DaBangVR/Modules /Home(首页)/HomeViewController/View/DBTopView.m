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
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];
    [_searchBox addGestureRecognizer:tap];
    [tap setNumberOfTapsRequired:1];
}

-(void)event:(UITapGestureRecognizer *)gesture{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBoxClickAction)]) {
        [self.delegate searchBoxClickAction];
    }
}

- (IBAction)shoppingCarAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shoppingCarClickAction)]) {
        [self.delegate shoppingCarClickAction];
    }
}


@end
