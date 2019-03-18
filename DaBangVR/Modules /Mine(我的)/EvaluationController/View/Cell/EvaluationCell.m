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
        _label = [[UILabel alloc] initWithFrame:CGRectMake(kFit(5), 0, self.evaluationTextView.mj_w, kFit(30))];
        _label.enabled = NO;
        _label.text = @"评价大于60元的商品超过10个字就有机会获得京豆";
        _label.adaptiveFontSize = 12;
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
    _evaluationTextView.font = [UIFont systemFontOfSize:kFit(14)];
    _evaluationTextView.scrollEnabled = YES;
    [_evaluationTextView addSubview:self.label];
}

#pragma mark —— textView 协议
-(void)textViewDidChange:(UITextView *)textView{
    self.textViewBlock(textView.text);
    // 改变的时候掉用
    if ([textView.text length] == 0) {
        self.label.hidden = NO;
    }else{
        self.label.hidden = YES;
    }
}

-(void)setModel:(OrderGoodsModel *)model{
    _model = model;
    [_goodsImgView setImageWithURL:[NSURL URLWithString:model.listUrl] placeholder:kDefaultImg];
    _goodsDetails.text = model.goodsName;
    _goodsNum.text = [NSString stringWithFormat:@"共%@件商品",model.goodsNumber];
    _goodsPrice.text = [NSString stringWithFormat:@"￥%@",model.retailPrice];
    _goodsPostage.text = [NSString stringWithFormat:@"配送费￥%@",model.logisticsPrice];
}

@end
