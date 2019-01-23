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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    
    YYTextView *textView = [[YYTextView alloc] init];
    textView.backgroundColor = KFontColor;
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
    self.textViewBlock(textView.text);
}

@end
