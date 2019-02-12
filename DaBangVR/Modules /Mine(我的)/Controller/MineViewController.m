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
    CGFloat topSafeMargin = [UIApplication.sharedApplication.keyWindow jx_layoutInsets].top;
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
    naviTitleLabel.frame = CGRectMake(0, topSafeMargin, KScreenW, 44);
    [self.naviBGView addSubview:naviTitleLabel];

    //让mainTableView可以显示范围外
//    self.pagerView.mainTableView.clipsToBounds = NO;
    //让头图的布局往上移动naviHeight高度，填充导航栏下面的内容
    self.userHeaderView.frame = CGRectMake(0, 0, KScreenW, kFit(JXTableHeaderViewHeight+naviHeight-kStatusBarHeight));
    //示例里面的PagingViewTableHeaderView，为了适应示例里面所有的情况。在导航栏隐藏示例关于横竖屏切换的情况，实在有点改不动了。不过不影响真实使用场景。可以根据自己真实的使用场景自己适配。这里的示例就不处理了。
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
