//
//  DBFeatureChoseTopCell.m
//  DaBangVR
//
//  Created by mac on 2018/12/29.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "DBFeatureChoseTopCell.h"

@interface DBFeatureChoseTopCell ()

/* 取消 */
@property (strong , nonatomic)UIButton *crossButton;

@end

@implementation DBFeatureChoseTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    _crossButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_crossButton setImage:[UIImage imageNamed:@"comeBack-x"] forState:0];
    [_crossButton addTarget:self action:@selector(crossButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_crossButton];
    
    _goodImageView = [UIImageView new];
    [self addSubview:_goodImageView];
    
    _goodPriceLabel = [UILabel new];
    _goodPriceLabel.font = [UIFont systemFontOfSize:17];
    _goodPriceLabel.textColor = [UIColor redColor];
    [self addSubview:_goodPriceLabel];
    
    _chooseAttLabel = [UILabel new];
    _chooseAttLabel.numberOfLines = 2;
    _chooseAttLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_chooseAttLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    kWeakSelf(self);
    [_crossButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self)setOffset:-10];
        [make.top.mas_equalTo(self)setOffset:10];
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [_goodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:10];
        [make.top.mas_equalTo(self)setOffset:10];
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [_goodPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(weakself.goodImageView.mas_right)setOffset:10];
        [make.top.mas_equalTo(weakself.goodImageView)setOffset:10];
    }];
    
    [_chooseAttLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.goodPriceLabel);
        make.right.mas_equalTo(weakself.crossButton.mas_left);
        [make.top.mas_equalTo(weakself.goodPriceLabel.mas_bottom)setOffset:5];
    }];
    
}

- (void)crossButtonClick
{
    !_crossButtonClickBlock ?: _crossButtonClickBlock();
}
@end
