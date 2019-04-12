//
//  EntertainmentViewController.m
//  DaBangVR
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "DidBeginLiveViewController.h"
// 七牛云
#import <PLMediaStreamingKit/PLMediaStreamingKit.h>

@interface DidBeginLiveViewController ()

/** 七牛云 */
@property (nonatomic, strong) PLMediaStreamingSession *session;

@end

@implementation DidBeginLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)setupUI{
    [super setupUI];
    PLVideoCaptureConfiguration *videoCaptureConfiguration = [PLVideoCaptureConfiguration defaultConfiguration];
    //摄像头的方向
    videoCaptureConfiguration.position = AVCaptureDevicePositionFront;
    PLAudioCaptureConfiguration *audioCaptureConfiguration = [PLAudioCaptureConfiguration defaultConfiguration];
    PLVideoStreamingConfiguration *videoStreamingConfiguration = [PLVideoStreamingConfiguration defaultConfiguration];
    PLAudioStreamingConfiguration *audioStreamingConfiguration = [PLAudioStreamingConfiguration defaultConfiguration];
    
    //  创建推荐session对象
    self.session = [[PLMediaStreamingSession alloc] initWithVideoCaptureConfiguration:videoCaptureConfiguration audioCaptureConfiguration:audioCaptureConfiguration videoStreamingConfiguration:videoStreamingConfiguration audioStreamingConfiguration:audioStreamingConfiguration stream:nil];
    
    [self.view addSubview:self.session.previewView];
    /**
     *liveTitle 直播标题
     *coverUrl  直播封面图片
     *goodsIds  勾选商品的id数组，用逗号：1,2,3 如果不传则为娱乐直播
     */
    NSDictionary *parameters = @{
                                 @"liveTitle":_parameters[@"liveTitle"],
                                 @"goodsIds" :_parameters[@"goodsIds"]
                                 };
    
    [NetWorkHelper POST:URl_create images:_parameters[@"coverUrl"] parameters:parameters success:^(id  _Nonnull responseObject) {
        NSURL *pushURL = [NSURL URLWithString:responseObject[@"publishURL"]];
        [self.session startStreamingWithPushURL:pushURL feedback:^(PLStreamStartStateFeedback feedback) {
            
        }];
    } failure:^(NSError * _Nonnull error) {}];
    
    UIButton *closeButton = [[UIButton alloc] init];
    closeButton.backgroundColor = KRedColor;
    [closeButton addTarget:self action:@selector(clickCloseButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(20);
        make.size.equalTo(CGSizeMake(100, 50));
    }];
}

-(void)clickCloseButton{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
