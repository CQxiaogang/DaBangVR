//
//  DBDetailContentCell.m
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "DBDetailContentCell.h"
#import "PPNumberButton.h"
//#import "BuyNowOfGoodVoModel.h"

@interface DBDetailContentCell()<PPNumberButtonDelegate>

@property (nonatomic ,strong)PPNumberButton *numberBut;

@end
@implementation DBDetailContentCell

#pragma mark —— 懒加载
-(PPNumberButton *)numberBut{
    kWeakSelf(self);
    if (!_numberBut) {
        _numberBut = [PPNumberButton numberButtonWithFrame:CGRectZero];
        _numberBut.minValue = 1;
        _numberBut.inputFieldFont = 14;
        _numberBut.increaseTitle = @"+";
        _numberBut.decreaseTitle = @"-";
        _numberBut.currentNumber = 0;
        _numberBut.delegate = self;
        _numberBut.resultBlock = ^(NSInteger number, BOOL increaseStatus) {
            number = [weakself.model.number integerValue];
        };
    }
    return _numberBut;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self addSubview:self.numberBut];
    kWeakSelf(self);
    [self.numberBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-15);
        make.bottom.equalTo(weakself.mas_bottom).offset(-5.5);
        make.size.equalTo(CGSizeMake(60, 15));
    }];
}

- (void)setModel:(BuyNowModel *)model{
    _model = model;
    [_goodsImgView setImageWithURL:[NSURL URLWithString:model.goodsVo.listUrl] placeholder:[UIImage imageNamed:@""]];
    _goodsDescribeLab.text = model.goodsVo.describe;
    if (model.productId == nil) {
        _marketPriceLab.text = model.goodsVo.marketPrice;
        _sellingPriceLab.text = model.goodsVo.sellingPrice;
    }else{
        _marketPriceLab.text = model.productInfoVo.marketPrice;
        _sellingPriceLab.text = model.productInfoVo.retailPrice;
    }
}

@end
