//
//  DBDetailFooterView.m
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "OrderSureFooterView.h"

@interface OrderSureFooterView ()<UITextViewDelegate>

@property (nonatomic, strong) UILabel *placeholderLabel;

@end
@implementation OrderSureFooterView

-(UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel                  = [UILabel new];
        _placeholderLabel.text             = @"买家留言:";
        _placeholderLabel.textColor        = KGrayColor;
        _placeholderLabel.adaptiveFontSize = 14;
        [_placeholderLabel sizeToFit];
    }
    return _placeholderLabel;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    _leaveMessageTextView.font = [UIFont systemFontOfSize:14];
    _leaveMessageTextView.delegate = self;
    [_leaveMessageTextView addSubview:self.placeholderLabel];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    kWeakSelf(self);
    [_placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(10);
        make.left.equalTo(10);
        make.size.equalTo(CGSizeMake(weakself.leaveMessageTextView.mj_w, 14));
    }];
}

#pragma mark —— UITextViewDelegate
-(void)textViewDidEndEditing:(UITextView *)textView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textViewString:)]) {
        [self.delegate textViewString:textView.text];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(nonnull NSString *)text{
    if (![text isEqualToString:@""])
    {
        self.placeholderLabel.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
        
    {
        self.placeholderLabel.hidden = NO;
    }
    return YES;
}

//留言
- (IBAction)leaveMessage:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(leaveMessageBtnClickAction:)]) {
        [self.delegate leaveMessageBtnClickAction:sender];
    }
}
//需要发票
- (IBAction)needTheInvoice:(id)sender {
}

@end
