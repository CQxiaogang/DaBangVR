//
//  MerchantsSettledViewController2.m
//  DaBangVR
//
//  Created by mac on 2019/4/10.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "MerchantsSettledViewController2.h"

@interface MerchantsSettledViewController2 ()

@end

@implementation MerchantsSettledViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = KRandomColor;
    
    UIButton *nowOpenShopBtn = [[UIButton alloc] init];
    nowOpenShopBtn.adaptiveFontSize = 15;
    nowOpenShopBtn.layer.cornerRadius = kFit(20);
    [nowOpenShopBtn setBackgroundColor:KLightGreen];
    [nowOpenShopBtn setTitle:@"立即开店" forState:UIControlStateNormal];
    [self.view addSubview:nowOpenShopBtn];
    [nowOpenShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(40);
        make.bottom.right.equalTo(-40);
        make.height.equalTo(40);
    }];
}
#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}
@end
