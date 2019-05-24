//
//  GoodsDetailsHeaderView.m
//  DaBangVR
//
//  Created by mac on 2019/5/21.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "GoodsDetailsHeaderView.h"

@implementation GoodsDetailsHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleLabel                  = [[UILabel alloc] init];
        self.titleLabel.textColor    = [UIColor lightGrayColor];
        self.backgroundColor         = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        _titleLabel.adaptiveFontSize = 14;
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    self.titleLabel.frame = CGRectMake(16, (self.bounds.size.height - self.titleLabel.bounds.size.height)/2, 200, self.titleLabel.bounds.size.height);
}

@end
