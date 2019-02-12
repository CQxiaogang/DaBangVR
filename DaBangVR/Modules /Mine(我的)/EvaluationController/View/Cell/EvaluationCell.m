//
//  EvaluationCell.m
//  DaBangVR
//
//  Created by mac on 2019/1/9.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "EvaluationCell.h"

@interface EvaluationCell ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *label;

@end
@implementation EvaluationCell
#pragma mark —— 懒加载
-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.evaluationTextView.mj_w, 30)];
        _label.enabled = NO;
        _label.text = @"评价大于60元的商品超过10个字就有机会获得京豆";
        _label.adaptiveFontSize = 14;
        _label.textColor = KRedColor;
    }
    return _label;
}
#pragma mark —— 系统方法
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI{
    _evaluationTextView.delegate = self;
    _evaluationTextView.textColor = KGrayColor;
    _evaluationTextView.font = [UIFont systemFontOfSize:Adapt(14)];
    _evaluationTextView.scrollEnabled = YES;
    [_evaluationTextView addSubview:self.label];
}

#pragma mark —— textView 协议
-(void)textViewDidChange:(UITextView *)textView{
    // 改变的时候掉用
    if ([textView.text length] == 0) {
        self.label.hidden = NO;
    }else{
        self.label.hidden = YES;
    }
}

@end
