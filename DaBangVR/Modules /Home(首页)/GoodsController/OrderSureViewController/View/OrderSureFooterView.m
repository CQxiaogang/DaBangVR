//
//  DBDetailFooterView.m
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "OrderSureFooterView.h"

@interface OrderSureFooterView ()
@end
@implementation OrderSureFooterView

// 留言
- (IBAction)leaveMessage:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(leaveMessageBtnClickAction:)]) {
        [self.delegate leaveMessageBtnClickAction:sender];
    }
}
// 需要发票
- (IBAction)needTheInvoice:(id)sender {
}

@end
