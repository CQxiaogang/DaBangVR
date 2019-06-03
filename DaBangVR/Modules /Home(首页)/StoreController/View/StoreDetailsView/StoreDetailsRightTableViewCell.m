//
//  RightTableViewCell.m
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import "StoreDetailsRightTableViewCell.h"
#import "CategoryModel.h"
#import "GoodAttributesView.h"

#define kSpecificationButtonH  25

@interface StoreDetailsRightTableViewCell ()
{
    int number;
}

@property (nonatomic ,strong) UIButton *specificationButton;
    
@end

@implementation StoreDetailsRightTableViewCell

-(UIButton *)specificationButton{
    if (!_specificationButton) {
        _specificationButton = [[UIButton alloc] init];
        _specificationButton.titleLabel.adaptiveFontSize = 12;
        [_specificationButton setBackgroundColor:KLightGreen];
        [_specificationButton setTitle:@"选规格" forState:UIControlStateNormal];
        [_specificationButton addTarget:self action:@selector(specificationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _specificationButton.layer.cornerRadius = kSpecificationButtonH/2;
    }
    return _specificationButton;
}
    
-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self addSubview:self.specificationButton];
    
    number = 0;
    _numberLabel.hidden = YES;
    _minusButton.hidden = YES;
    
    _plusButton.backgroundColor = KLightGreen;
    _minusButton.layer.borderColor = KLightGreen.CGColor;
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self.specificationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.bottom.equalTo(-15);
        make.size.equalTo(CGSizeMake(60, kSpecificationButtonH));
    }];
}

-(void)specificationButtonClick:(UIButton*)button{
    if (self.delegate && [self.delegate respondsToSelector:@selector(specificationButtonClick:)]) {
        [self.delegate specificationButtonClick:button];
    }
}
//加
- (IBAction)plusButtonClick:(id)sender {
    number++;
    if (number>0) {
        _numberLabel.hidden = NO;
        _minusButton.hidden = NO;
        _numberLabel.text = [NSString stringWithFormat:@"%d",number];
        _model.number = number;
    }
}
//减
- (IBAction)minusButtonClick:(id)sender {
    number--;
    _numberLabel.text = [NSString stringWithFormat:@"%d",number];
    _model.number = number;
    if (number==0) {
        _numberLabel.hidden = YES;
        _minusButton.hidden = YES;
    }
}

- (void)setModel:(DeptDetailsGoodsModel *)model
{
    self.nameLabel.text  = model.name;
    self.salesLabel.text = [NSString stringWithFormat:@"月销%@笔",model.salesVolume];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.marketPrice];
    [self.goodsImgView setImageURL:[NSURL URLWithString:model.listUrl]];
    if (model.specList.count == 0) {
        self.specificationButton.hidden  = YES;
    }else{
        _numberLabel.hidden = YES;
        _minusButton.hidden = YES;
        _plusButton.hidden  = YES;
    }
    if (model.number) {
        _numberLabel.text = [NSString stringWithFormat:@"%d",number];
    }
}

@end
