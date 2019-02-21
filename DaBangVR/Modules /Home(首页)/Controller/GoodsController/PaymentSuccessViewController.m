//
//  PaySuccessViewController2.m
//  DaBangVR
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "PaymentSuccessViewController.h"
#import "MyOrderViewController.h"
// Views
#import "PaySuccessView.h"

@interface PaymentSuccessViewController ()<PaySuccessViewDelegate>

@end

@implementation PaymentSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"付款成功";
    PaySuccessView *paysuccessV = [[[NSBundle mainBundle] loadNibNamed:@"PaySuccessView" owner:nil options:nil] firstObject];
    paysuccessV.delegate = self;
    [self.view addSubview:paysuccessV];
    [paysuccessV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(kTopHeight);
        make.height.equalTo(kFit(250));
    }];
}

#pragma mark —— PaySuccess 代理
-(void)buttonClickAction:(NSInteger)tag{
    if (tag == 10) {
        MyOrderViewController *vc = [[MyOrderViewController alloc] init];
        [self.navigationController pushViewController:vc animated:NO];
    }else{
        DLog(@"继续购物");
    }
}

@end
