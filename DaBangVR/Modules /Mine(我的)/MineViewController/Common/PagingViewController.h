//
//  OCExampleViewController.h
//  JXPagingView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPagerView.h"
#import "TestListBaseView.h"
#import "TestListBaseView2.h"
#import "JXCategoryTitleView.h"
#import "MineHeaderView.h"

static const CGFloat JXTableHeaderViewHeight = 220;
static const CGFloat JXheightForHeaderInSection = 40;

@interface PagingViewController : RootViewController <JXPagerViewDelegate>

@property (nonatomic, strong) JXPagerView *pagerView;
@property (nonatomic, strong) MineHeaderView *userHeaderView;
@property (nonatomic, strong, readonly) JXCategoryTitleView *categoryView;
@property (nonatomic, assign) BOOL isNeedFooter;
@property (nonatomic, assign) BOOL isNeedHeader;
- (JXPagerView *)preferredPagingView;

@end
