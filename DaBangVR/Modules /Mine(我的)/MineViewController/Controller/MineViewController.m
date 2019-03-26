//
//  NaviBarHiddenViewController.m
//  JXPagerViewExample-OC
//
//  Created by jiaxin on 2018/9/12.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "MineViewController.h"
#import "UIWindow+JXSafeArea.h"

@interface MineViewController ()
@property (nonatomic, strong) UIView *naviBGView;
@property (nonatomic, assign) CGFloat pinHeaderViewInsetTop;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat naviHeight = [UIApplication.sharedApplication.keyWindow jx_navigationHeight];
    self.pinHeaderViewInsetTop = naviHeight;

    self.naviBGView = [[UIView alloc] init];
    self.naviBGView.alpha = 0;
    self.naviBGView.backgroundColor = [UIColor lightGreen];
    self.naviBGView.frame = CGRectMake(0, kStatusBarHeight, KScreenW, kNavBarHeight);
    [self.view addSubview:self.naviBGView];

    UILabel *naviTitleLabel = [[UILabel alloc] init];
    naviTitleLabel.text = @"个人中心";
    naviTitleLabel.textColor = KWhiteColor;
    naviTitleLabel.textAlignment = NSTextAlignmentCenter;
    naviTitleLabel.adaptiveFontSize = 17;
    naviTitleLabel.frame = CGRectMake(0, 0, KScreenW, kNavBarHeight);
    [self.naviBGView addSubview:naviTitleLabel];

    self.userHeaderView.frame = CGRectMake(0, 0, KScreenW, kFit(JXTableHeaderViewHeight));
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    //pagingView依然是从导航栏下面开始布局的
    self.pagerView.frame = CGRectMake(0, kStatusBarHeight, KScreenW, KScreenH-kTabBarHeight);
}

- (void)mainTableViewDidScroll:(UIScrollView *)scrollView {
    CGFloat thresholdDistance = 100;
    CGFloat percent = scrollView.contentOffset.y/thresholdDistance;
    percent = MAX(0, MIN(1, percent));
    self.naviBGView.alpha = percent;
}
@end
