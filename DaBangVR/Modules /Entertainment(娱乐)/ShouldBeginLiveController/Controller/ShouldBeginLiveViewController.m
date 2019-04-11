//
//  BeginLiveViewController.m
//  DaBangVR
//
//  Created by mac on 2019/4/11.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "ShouldBeginLiveViewController.h"
#import "HomeViewController.h"
#import "DidBeginLiveViewController.h"
@interface ShouldBeginLiveViewController ()
/** 开始直播按钮 */
@property (weak, nonatomic) IBOutlet UIButton *shouldBeginLiveBtn;
/**  直播时候选择主推商品 */
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ShouldBeginLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *topView = [[UILabel alloc] init];
    topView.text = @"直播";
    topView.textColor = KWhiteColor;
    topView.adaptiveFontSize = 15;
    topView.textAlignment = NSTextAlignmentCenter;
    topView.backgroundColor = KLightGreen;
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(kStatusBarHeight);
        make.height.equalTo(kNavBarHeight);
    }];
    UIButton *comeBackBtn = [[UIButton alloc] init];
    comeBackBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    [comeBackBtn addTarget:self action:@selector(comeBackButtonOfClick) forControlEvents:UIControlEventTouchUpInside];
    [comeBackBtn setImage:[UIImage imageNamed:@"comeBack"] forState:UIControlStateNormal];
    [self.view addSubview:comeBackBtn];
    [comeBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(kStatusBarHeight);
        make.width.equalTo(60);
        make.height.equalTo(kNavBarHeight);
    }];
}
/** 反正按钮 */
- (void)comeBackButtonOfClick{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/** 开始直播按钮 */
- (IBAction)shouldBeginLIveBtnOfClick:(id)sender {
    DidBeginLiveViewController *vc = [DidBeginLiveViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
