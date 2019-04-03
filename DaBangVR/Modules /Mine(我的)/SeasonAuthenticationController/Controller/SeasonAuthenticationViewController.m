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
/** 七牛云存储 */
#import <QiniuSDK.h>

@interface SeasonAuthenticationViewController ()
/** 身份证正面照片 */
@property (weak, nonatomic) IBOutlet UIImageView *iDCardImgView1;
/** 身份证反面照片 */
@property (weak, nonatomic) IBOutlet UIImageView *iDCardImgView2;
/** 手持身份证照片 */
@property (weak, nonatomic) IBOutlet UIImageView *iDCardImgView3;
/** 真是姓名 */
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
/** 身份证号 */
@property (weak, nonatomic) IBOutlet UITextField *iDCardNameTextField;
/** 手机号码 */
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
/** 装提交信息的字典 */
@property (nonatomic, strong) NSMutableDictionary *infoDic;
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
    //初始化
    _infoDic = [[NSMutableDictionary alloc] init];
}

- (void)uploadWithFile:(NSString *)file withProgress:(QNUpProgressHandler)progress success:(void(^)(NSString*url))success failure:(void(^)(void))failure{
    
}

- (void)gotoCamera:(UIGestureRecognizer *)sender {
    UIImageView *imgView = (UIImageView *)sender.view;
    [self AlertWithTitle:nil preferredStyle:UIAlertControllerStyleActionSheet message:nil andOthers:@[@"取消",@"拍照"] animated:YES action:^(NSInteger index) {
        if (index == 1) {
            
            [NetWorkHelper POST:URl_getUploadConfigToken parameters:nil success:^(id  _Nonnull responseObject) {
                NSDictionary *dic = KJSONSerialization(responseObject)[@"data"];
                NSString *token = dic[@"token"];
                QNUploadManager *upManager = [[QNUploadManager alloc] init];
                
                DDPhotoViewController *vc = [[DDPhotoViewController alloc] init];
                if (imgView.tag == 101) {
                    vc.imageblock = ^(UIImage *image) {
                        self.iDCardImgView1.image = image;
                        NSData *data = UIImageJPEGRepresentation(image, 0.000001);
                        [upManager putData:data key:@"idcardFace" token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                            NSString *imgStr = [NSString stringWithFormat:@"http://test.fuxingsc.com/%@",resp[@"idcardFace"]];
                            [self.infoDic setObject:imgStr forKey:@"idcardFace"];
                        } option:[QNUploadOption defaultOptions]];
                    };
                }else if (imgView.tag == 102){
                    vc.imageblock = ^(UIImage *image) {
                        self.iDCardImgView2.image = image;
                        NSData *data = UIImageJPEGRepresentation(image, 0.000001);
                        [upManager putData:data key:@"idcardBack" token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                            NSString *imgStr = [NSString stringWithFormat:@"http://test.fuxingsc.com/%@",resp[@"idcardBack"]];
                            [self.infoDic setObject:imgStr forKey:@"idcardBack"];
                        } option:[QNUploadOption defaultOptions]];
                    };
                }else if (imgView.tag == 103){
                    vc.imageblock = ^(UIImage *image) {
                        self.iDCardImgView3.image = image;
                    };
                }
                [self presentViewController:vc animated:YES completion:nil];
            } failure:nil];
        }
    }];
}

//认证按钮点击事件
- (IBAction)authemticationAction:(id)sender {
    [_infoDic setObject:@"王孝刚" forKey:@"name"];
    [_infoDic setObject:@"500227199212128218" forKey:@"idCard"];
    [_infoDic setObject:@"17687686919" forKey:@"phone"];
    //主播协议：0不同意 1同意
    [_infoDic setObject:@"1" forKey:@"agreedAgreement"];
    [NetWorkHelper POST:URl_appAnchor parameters:self.infoDic success:^(id  _Nonnull responseObject) {
    } failure:^(NSError * _Nonnull error) {}];
}

//照片获取本地路径转换
- (NSString *)getImagePath:(UIImage *)Image {
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(Image) == nil) {
        data = UIImageJPEGRepresentation(Image, 1.0);
    } else {
        data = UIImagePNGRepresentation(Image);
    }
    
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/theFirstImage.png"];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    return filePath;
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
