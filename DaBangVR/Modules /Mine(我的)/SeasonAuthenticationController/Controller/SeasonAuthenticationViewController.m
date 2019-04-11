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
#import "AFNetworking.h"

@interface SeasonAuthenticationViewController ()<UITextFieldDelegate>
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
/** 倒计时 */
@property (nonatomic, assign) NSInteger timeOut;
@end

@implementation SeasonAuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主播认证";
    //初始化
    _infoDic = [[NSMutableDictionary alloc] init];
    //textField遵守协议
    _nameTextField.delegate = self;
    _phoneNumTextField.delegate = self;
    _iDCardNameTextField.delegate = self;
    //区分UITextField
    _nameTextField.tag = 100;
    _phoneNumTextField.tag = 101;
    _iDCardNameTextField.tag = 102;
    //数字键盘
    _phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    _iDCardNameTextField.keyboardType = UIKeyboardTypeNumberPad;
}

-(void)setupUI{
    [super setupUI];
    //给按钮设置渐变色
    _authemticationButton.backgroundColor = KClearColor;
    [_authemticationButton setBackgroundImage:[UIImage imageWithGradualChangingColor:^(QQGradualChangingColor *graColor) {
        graColor.fromColor = KWhiteColor;
        graColor.toColor = KLightGreen;
        graColor.type = QQGradualChangeTypeUpLeftToDownRight;
    } size:_authemticationButton.size cornerRadius:QQRadiusMakeSame(_authemticationButton.mj_h/2)] forState:UIControlStateNormal];
    //给按钮设置渐变色
    _getVerificationCodeBtn.backgroundColor = KClearColor;
    [_getVerificationCodeBtn setBackgroundImage:[UIImage imageWithGradualChangingColor:^(QQGradualChangingColor *graColor) {
        graColor.fromColor = KWhiteColor;
        graColor.toColor = KLightGreen;
        graColor.type = QQGradualChangeTypeUpLeftToDownRight;
    } size:_getVerificationCodeBtn.size cornerRadius:QQRadiusMakeSame(_authemticationButton.mj_h/2)] forState:UIControlStateNormal];
    
    //给图片添加点击事件
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
                    //身份证正面
                    self.iDCardImgView1.image = image;
                    [NetWorkHelper POST:URl_appAnchor images:image success:^(id  _Nonnull responseObject) {
                        NSDictionary *dic = KJSONSerialization(responseObject);
                        NSLog(@"%@",dic);
                    } failure:nil];
                };
            }else if (imgView.tag == 102){
                vc.imageblock = ^(UIImage *image) {
                    //身份证反面
                    self.iDCardImgView2.image = image;
                    NSData *data = UIImageJPEGRepresentation(image, 0.000001);
                    [self.infoDic setObject:data forKey:@"idCardBack"];
                };
            }else if (imgView.tag == 103){
                //手持身份证
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
//    [_infoDic setObject:@"王孝刚" forKey:@"name"];
//    [_infoDic setObject:@"500227199212128218" forKey:@"idCard"];
//    [_infoDic setObject:@"17687686919" forKey:@"phone"];
    //主播协议：0不同意 1同意
    [_infoDic setObject:@"1" forKey:@"agreedAgreement"];
    [NetWorkHelper POST:URl_appAnchor parameters:self.infoDic success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = KJSONSerialization(responseObject);
        DLog(@"%@",dic);
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
    [self sentPhoneCodeTimeMethod];
}

#pragma mark —— UITextField 协议
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 101) {
        if (![self validateContactNumber:textField.text]) {
            [SVProgressHUD showInfoWithStatus:@"请输入正确的格式"];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD dismissWithDelay:1.0];
        }
    }
}

/**
 验证码手机号
 
 @param mobileNum 手机号
 @return YES 通过 NO 不通过
 */
- (BOOL)validateContactNumber:(NSString *)mobileNum
{
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 16[6], 17[5, 6, 7, 8], 18[0-9], 170[0-9], 19[89]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705,198
     * 联通号段: 130,131,132,155,156,185,186,145,175,176,1709,166
     * 电信号段: 133,153,180,181,189,177,1700,199
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|6[6]|7[05-8]|8[0-9]|9[89])\\d{8}$";
    
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478]|9[8])\\d{8}$)|(^1705\\d{7}$)";
    
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|66|7[56]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    
    NSString *CT = @"(^1(33|53|77|8[019]|99)\\d{8}$)|(^1700\\d{7}$)";
    
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    // NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if(([regextestmobile evaluateWithObject:mobileNum] == YES)
       || ([regextestcm evaluateWithObject:mobileNum] == YES)
       || ([regextestct evaluateWithObject:mobileNum] == YES)
       || ([regextestcu evaluateWithObject:mobileNum] == YES)) {
        return YES;
    } else {
        return NO;
    }
}
/**
 倒计时方法 在点击获取验证码按钮的方法里调用此方法即可实现, 需要在倒计时里修改按钮相关的请在此方法里yourButton修改
 */
- (void)sentPhoneCodeTimeMethod{
    kWeakSelf(self);
    //倒计时时间 - 60S
    __block NSInteger timeOut = 59;
    self.timeOut = timeOut;
    //执行队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //计时器 -》 dispatch_source_set_timer自动生成
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (timeOut <= 0) {
            dispatch_source_cancel(timer);
            //主线程设置按钮样式
            dispatch_async(dispatch_get_main_queue(), ^{
                // 倒计时结束
                [weakself.getVerificationCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [weakself.getVerificationCodeBtn setEnabled:YES];
                [weakself.getVerificationCodeBtn setUserInteractionEnabled:YES];
            });
        }else{
            //开始计时
            //剩余秒数 seconds
            NSInteger seconds = timeOut % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.1ld", seconds];
            //主线程设置按钮样式
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *title = [NSString stringWithFormat:@"%@",strTime];
                [weakself.getVerificationCodeBtn setTitle:title forState:UIControlStateNormal];
                [weakself.getVerificationCodeBtn setUserInteractionEnabled:NO];
                [weakself.getVerificationCodeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            });
            timeOut--;
        }
    });
    dispatch_resume(timer);
}
@end
