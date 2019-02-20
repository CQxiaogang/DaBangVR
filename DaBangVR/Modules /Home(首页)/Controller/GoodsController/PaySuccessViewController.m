//
//  PaySuccessViewController.m
//  DaBangVR
//
//  Created by mac on 2019/2/20.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "PaySuccessViewController.h"
// Views
#import "PaySuccessView.h"

@interface PaySuccessViewController ()

@end

@implementation PaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"付款成功";
    PaySuccessView *paysuccessV = [[[NSBundle mainBundle] loadNibNamed:@"PaySuccessView" owner:nil options:nil] firstObject];
    [self.view addSubview:paysuccessV];
    [paysuccessV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(kTopHeight);
        make.height.equalTo(kFit(250));
    }];
}

@end
