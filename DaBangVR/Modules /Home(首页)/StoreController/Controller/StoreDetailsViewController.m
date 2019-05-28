//
//  StoreDetailsViewController.m
//  DaBangVR
//
//  Created by mac on 2019/5/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "StoreDetailsViewController.h"
#import "UIWindow+JXSafeArea.h"

@interface StoreDetailsViewController ()
@property (nonatomic, strong) UIView *naviBGView;
@property (nonatomic, assign) CGFloat pinHeaderViewInsetTop;
@end

@implementation StoreDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.storeDetailsTopView.frame = CGRectMake(0, 0, KScreenW, kFit(JXTableHeaderViewHeight));
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //pagingView依然是从导航栏下面开始布局的
    self.pagerView.frame = CGRectMake(0, kTopHeight, KScreenW, KScreenH-kTopHeight);
}

@end
