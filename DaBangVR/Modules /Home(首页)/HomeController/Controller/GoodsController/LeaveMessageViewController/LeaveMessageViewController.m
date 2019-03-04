//
//  LeaveMessageViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/23.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "LeaveMessageViewController.h"

@interface LeaveMessageViewController ()<YYTextViewDelegate>

@end

@implementation LeaveMessageViewController
static NSString *leaveMessage;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"买家留言";
    
    YYTextView *textView = [[YYTextView alloc] init];
    textView.text = leaveMessage;
    textView.backgroundColor = KGray3Color;
    textView.delegate = self;
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.top.equalTo(kTopHeight+20);
        make.height.equalTo(120);
    }];
}

-(void)textViewDidEndEditing:(YYTextView *)textView{
    leaveMessage = textView.text;
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    self.textViewBlock(leaveMessage);
}

@end
