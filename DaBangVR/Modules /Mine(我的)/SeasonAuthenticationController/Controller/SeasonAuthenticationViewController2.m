//
//  SeasonAuthenticationViewController2.m
//  DaBangVR
//
//  Created by mac on 2019/4/2.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "SeasonAuthenticationViewController2.h"

@interface SeasonAuthenticationViewController2 ()
/** 立即提交 */
@property (weak, nonatomic) IBOutlet UIButton *infoSubmitBtn;

@end

@implementation SeasonAuthenticationViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"身份认证";
    
//    [_infoSubmitBtn setBackgroundImage:[UIImage imageWithGradualChangingColor:^(QQGradualChangingColor *graColor) {
//        graColor.fromColor = KWhiteColor;
//        graColor.toColor = KLightGreen;
//        graColor.type = QQGradualChangeTypeUpLeftToDownRight;
//    } size:_infoSubmitBtn.size cornerRadius:QQRadiusMakeSame(_infoSubmitBtn.size.height/2)] forState:UIControlStateNormal];
    
}
//立即提交
- (IBAction)infoSubmitAction:(id)sender {
    
}

@end
