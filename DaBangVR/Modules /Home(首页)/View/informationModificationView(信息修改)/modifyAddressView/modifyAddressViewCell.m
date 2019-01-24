//
//  modifyAddressViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "modifyAddressViewCell.h"

@interface modifyAddressViewCell()<UITextFieldDelegate>

@end

@implementation modifyAddressViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _contentText.delegate = self;
    
    _contentText.font = [UIFont systemFontOfSize:Adapt(14)];
}

#pragma mark —— UITextField 协议
// 结束编辑
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}
// 开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.delegate && [self.delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.delegate textFieldDidBeginEditing:textField];
    }
}

@end
