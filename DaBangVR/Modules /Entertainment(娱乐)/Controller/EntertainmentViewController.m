//
//  EntertainmentViewController.m
//  DaBangVR
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "EntertainmentViewController.h"
// 七牛云
#import <PLMediaStreamingKit/PLMediaStreamingKit.h>

@interface EntertainmentViewController ()

/** 七牛云 */
@property (nonatomic, strong) PLMediaStreamingSession *session;

@end

@implementation EntertainmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PLVideoCaptureConfiguration *videoCaptureConfiguration = [PLVideoCaptureConfiguration defaultConfiguration];
    //摄像头的方向
    videoCaptureConfiguration.position = AVCaptureDevicePositionFront;
    PLAudioCaptureConfiguration *audioCaptureConfiguration = [PLAudioCaptureConfiguration defaultConfiguration];
    PLVideoStreamingConfiguration *videoStreamingConfiguration = [PLVideoStreamingConfiguration defaultConfiguration];
    PLAudioStreamingConfiguration *audioStreamingConfiguration = [PLAudioStreamingConfiguration defaultConfiguration];

    //  创建推荐session对象
    self.session = [[PLMediaStreamingSession alloc] initWithVideoCaptureConfiguration:videoCaptureConfiguration audioCaptureConfiguration:audioCaptureConfiguration videoStreamingConfiguration:videoStreamingConfiguration audioStreamingConfiguration:audioStreamingConfiguration stream:nil];

    [self.view addSubview:self.session.previewView];

    NSDictionary *parameters = @{
                                 @"streamKey" :@"test1",
                                 @"streamName":@"test1"
                                 };
    [NetWorkHelper POST:URl_create parameters:parameters success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = KJSONSerialization(responseObject);
        NSURL *pushURL = [NSURL URLWithString:dic[@"publishURL"]];
        [self.session startStreamingWithPushURL:pushURL feedback:^(PLStreamStartStateFeedback feedback) {
//            if (feedback == PLStreamStartStateSuccess) {
//                NSLog(@"Streaming started.");
//            }
//            else {
//                NSLog(@"Oops.");
//            }
        }];
    } failure:nil];
}

@end
