//
//  EvaluationOfSuccessViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/10.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "EvaluationOfSuccessViewController.h"
// Views
#import "EvaluationSuccessView.h"

@interface EvaluationOfSuccessViewController ()

@property (nonatomic, strong) EvaluationSuccessView *evaluatinSuccessView;

@end

@implementation EvaluationOfSuccessViewController
#pragma mark —— 懒加载
-(EvaluationSuccessView *)evaluatinSuccessView{
    if (!_evaluatinSuccessView) {
        _evaluatinSuccessView = [[[NSBundle mainBundle] loadNibNamed:@"EvaluationSuccessView" owner:nil options:nil] firstObject];
    }
    return _evaluatinSuccessView;
}
#pragma mark —— 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价成功";
}
-(void)setupUI{
    [self.view addSubview:self.evaluatinSuccessView];
    [self.evaluatinSuccessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(kTopHeight+10);
        make.height.equalTo(210);
    }];
}

@end
