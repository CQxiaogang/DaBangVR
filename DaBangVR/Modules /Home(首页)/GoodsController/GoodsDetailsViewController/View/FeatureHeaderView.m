//
//  DBFeatureHeaderView.m
//  Demo
//
//  Created by mac on 2018/12/28.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "FeatureHeaderView.h"
// Models
#import "DBFeatureTitleItem.h"
#import "Masonry.h"

@interface FeatureHeaderView ()
/* 属性标题 */
@property (strong , nonatomic)UILabel *headerLabel;
/* 底部View */
@property (strong , nonatomic)UIView *bottomView;

@end

@implementation FeatureHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    _headerLabel = [[UILabel alloc] init];
    _headerLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_headerLabel];
    
    _bottomView = [UIView new];
    _bottomView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3];
    [self addSubview:_bottomView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:10];
        make.centerY.mas_equalTo(self);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

#pragma mark - Setter Getter Methods
- (void)setHeadTitle:(NSString *)headTitle{
    _headTitle = headTitle;
    _headerLabel.text = headTitle;
}

@end
