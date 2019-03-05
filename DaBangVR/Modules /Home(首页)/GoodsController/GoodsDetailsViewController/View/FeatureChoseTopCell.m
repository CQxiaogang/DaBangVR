//
//  DBFeatureChoseTopCell.m
//  DaBangVR
//
//  Created by mac on 2018/12/29.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "FeatureChoseTopCell.h"

@interface FeatureChoseTopCell ()

/* 取消 */
@property (strong , nonatomic)UIButton *crossButton;

@end

@implementation FeatureChoseTopCell

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
    _goodPriceLabel.adaptiveFontSize = 17;
    _goodPriceLabel.textColor = [UIColor redColor];
    [self addSubview:_goodPriceLabel];
    
    _inventoryLabel = [UILabel new];
    _inventoryLabel.adaptiveFontSize = 10;
    _inventoryLabel.textColor = KGrayColor;
    [self addSubview:_inventoryLabel];
    
    _chooseAttLabel = [UILabel new];
    _chooseAttLabel.numberOfLines = 2;
    _chooseAttLabel.adaptiveFontSize = 12;
    _chooseAttLabel.textColor = KGrayColor;
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
    
    [_inventoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.goodPriceLabel);
        make.right.mas_equalTo(weakself.crossButton.mas_left);
        [make.top.mas_equalTo(weakself.goodPriceLabel.mas_bottom)setOffset:5];
    }];
    
    [_chooseAttLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.goodPriceLabel);
        make.right.mas_equalTo(weakself.crossButton.mas_left);
        [make.top.mas_equalTo(weakself.inventoryLabel.mas_bottom)setOffset:15];
    }];
    
}

- (void)crossButtonClick
{
    !_crossButtonClickBlock ?: _crossButtonClickBlock();
}
@end
