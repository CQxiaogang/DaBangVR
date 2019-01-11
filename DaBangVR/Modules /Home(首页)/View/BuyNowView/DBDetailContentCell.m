//
//  DBDetailContentCell.m
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "DBDetailContentCell.h"
#import "PPNumberButton.h"
@interface DBDetailContentCell()

@property (nonatomic ,strong)PPNumberButton *numberBut;

@end
@implementation DBDetailContentCell

#pragma mark —— 懒加载
-(PPNumberButton *)numberBut{
    if (!_numberBut) {
        _numberBut = [PPNumberButton numberButtonWithFrame:CGRectZero];
        _numberBut.minValue = 1;
        _numberBut.inputFieldFont = 14;
        _numberBut.increaseTitle = @"+";
        _numberBut.decreaseTitle = @"-";
        _numberBut.currentNumber = 1;
//        _numberBut.delegate = self;
        _numberBut.resultBlock = ^(NSInteger number, BOOL increaseStatus) {
            
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
