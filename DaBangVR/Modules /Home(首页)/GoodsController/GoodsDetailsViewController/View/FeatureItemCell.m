//
//  DBFeatureItemCell.m
//  Demo
//
//  Created by mac on 2018/12/28.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "FeatureItemCell.h"
#import "Masonry.h"

// Models
#import "DBFeatureList.h"
#import "DBFeatureItem.h"

@interface FeatureItemCell()
/* 属性 */
@property (strong , nonatomic)UILabel *attLabel;

@end
@implementation FeatureItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _defaultColor = KBlackColor;
        _selectColor = KRedColor;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    _attLabel = [[UILabel alloc] init];
    _attLabel.textAlignment = NSTextAlignmentCenter;
    _attLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_attLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_attLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

#pragma mark - Setter Getter Methods

- (void)setContent:(DBFeatureList *)content{
    _content = content;
    _attLabel.text = content.value;
    
    if (content.isSelect) {
        _attLabel.textColor = _selectColor;
        [self dc_chageControlCircularWith:_attLabel AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:_selectColor canMasksToBounds:YES];
    }else{
        _attLabel.textColor = _defaultColor;
        [self dc_chageControlCircularWith:_attLabel AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:[_defaultColor colorWithAlphaComponent:0.4] canMasksToBounds:YES];
    }
}

-(void)setDefaultColor:(UIColor *)defaultColor{
    _defaultColor = defaultColor;
}

-(void)setSelectColor:(UIColor *)selectColor{
    _selectColor = selectColor;
}

- (id)dc_chageControlCircularWith:(id)anyControl AndSetCornerRadius:(NSInteger)radius SetBorderWidth:(NSInteger)width SetBorderColor:(UIColor *)borderColor canMasksToBounds:(BOOL)can
{
    CALayer *icon_layer=[anyControl layer];
    [icon_layer setCornerRadius:radius];
    [icon_layer setBorderWidth:width];
    [icon_layer setBorderColor:[borderColor CGColor]];
    [icon_layer setMasksToBounds:can];
    
    return anyControl;
}

@end
