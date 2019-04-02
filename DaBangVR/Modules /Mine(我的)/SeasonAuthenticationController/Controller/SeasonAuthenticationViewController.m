//
//  SeasonAuthenticationViewController.m
//  DaBangVR
//
//  Created by mac on 2019/4/2.
//  Copyright © 2019 DaBangVR. All rights reserved.
//
/** Controllers */
#import "SeasonAuthenticationViewController.h"
#import "SeasonAuthenticationViewController2.h"
/** 第三方操作身份证 */
#import "DDPhotoViewController.h"

@interface SeasonAuthenticationViewController ()
/** 身份证正面照片 */
@property (weak, nonatomic) IBOutlet UIImageView *iDCardImgView1;
/** 身份证反面照片 */
@property (weak, nonatomic) IBOutlet UIImageView *iDCardImgView2;
/** 手持身份证照片 */
@property (weak, nonatomic) IBOutlet UIImageView *iDCardImgView3;

@end

@implementation SeasonAuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主播认证";
    _authemticationButton.backgroundColor = KClearColor;
    [_authemticationButton setBackgroundImage:[UIImage imageWithGradualChangingColor:^(QQGradualChangingColor *graColor) {
        graColor.fromColor = KWhiteColor;
        graColor.toColor = KLightGreen;
        graColor.type = QQGradualChangeTypeUpLeftToDownRight;
    } size:_authemticationButton.size cornerRadius:QQRadiusMakeSame(_authemticationButton.mj_h/2)] forState:UIControlStateNormal];
    
    _getVerificationCodeBtn.backgroundColor = KClearColor;
    [_getVerificationCodeBtn setBackgroundImage:[UIImage imageWithGradualChangingColor:^(QQGradualChangingColor *graColor) {
        graColor.fromColor = KWhiteColor;
        graColor.toColor = KLightGreen;
        graColor.type = QQGradualChangeTypeUpLeftToDownRight;
    } size:_getVerificationCodeBtn.size cornerRadius:QQRadiusMakeSame(_authemticationButton.mj_h/2)] forState:UIControlStateNormal];
    
    //给图片添加事件
    _iDCardImgView1.userInteractionEnabled = YES;
    _iDCardImgView1.tag = 101;
    UITapGestureRecognizer *imgTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoCamera:)];
    [_iDCardImgView1 addGestureRecognizer:imgTap1];
    
    _iDCardImgView2.userInteractionEnabled = YES;
    _iDCardImgView2.tag = 102;
    UITapGestureRecognizer *imgTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoCamera:)];
    [_iDCardImgView2 addGestureRecognizer:imgTap2];
    
    _iDCardImgView3.userInteractionEnabled = YES;
    _iDCardImgView3.tag = 103;
    UITapGestureRecognizer *imgTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoCamera:)];
    [_iDCardImgView3 addGestureRecognizer:imgTap3];
}

- (void)gotoCamera:(UIGestureRecognizer *)sender {
    UIImageView *imgView = (UIImageView *)sender.view;
    [self AlertWithTitle:nil preferredStyle:UIAlertControllerStyleActionSheet message:nil andOthers:@[@"取消",@"拍照"] animated:YES action:^(NSInteger index) {
        if (index == 1) {
            DDPhotoViewController *vc = [[DDPhotoViewController alloc] init];
            if (imgView.tag == 101) {
                vc.imageblock = ^(UIImage *image) {
                    self.iDCardImgView1.image = image;
                };
            }else if (imgView.tag == 102){
                vc.imageblock = ^(UIImage *image) {
                    self.iDCardImgView2.image = image;
                };
            }else if (imgView.tag == 103){
                vc.imageblock = ^(UIImage *image) {
                    self.iDCardImgView3.image = image;
                };
            }
            [self presentViewController:vc animated:YES completion:nil];
            
        }
    }];
}

//认证按钮点击事件
- (IBAction)authemticationAction:(id)sender {
    
}
//添加身份证
- (IBAction)andIdentityCardBtn:(id)sender {
    SeasonAuthenticationViewController2 *vc = [SeasonAuthenticationViewController2 new];
    [self.navigationController pushViewController:vc animated:NO];
}
//获取验证码
- (IBAction)getVerificationCodeAction:(id)sender {
}

@end
