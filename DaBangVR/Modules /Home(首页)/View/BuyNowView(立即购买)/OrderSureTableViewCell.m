//
//  DBDetailContentCell.m
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "OrderSureTableViewCell.h"
#import "PPNumberButton.h"
//#import "BuyNowOfGoodVoModel.h"

@interface OrderSureTableViewCell()<PPNumberButtonDelegate>

@property (nonatomic ,strong)PPNumberButton *numberBut;

@end
@implementation OrderSureTableViewCell

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
    
//    [self addSubview:self.numberBut];
//    kWeakSelf(self);
//    [self.numberBut mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(-15);
//        make.bottom.equalTo(weakself.mas_bottom).offset(-5.5);
//        make.size.equalTo(CGSizeMake(60, 15));
//    }];
}

- (void)setModel:(OrderSureModel *)model{
    _model = model;
}

@end
