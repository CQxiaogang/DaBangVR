//
//  StoreDetailsViewController.h
//  DaBangVR
//
//  Created by mac on 2019/5/27.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "RootViewController.h"
#import "JXPagerView.h"
#import "JXCategoryTitleView.h"
#import "StoreDetailsTopView.h"

static const CGFloat JXTableHeaderViewHeight = 210;
static const CGFloat JXheightForHeaderInSection = 40;

NS_ASSUME_NONNULL_BEGIN

@interface StoreDetailsPagingViewController : RootViewController<JXPagerViewDelegate>

@property (nonatomic, strong) JXPagerView *pagerView;
@property (nonatomic, strong) StoreDetailsTopView *storeDetailsTopView;
@property (nonatomic, strong, readonly) JXCategoryTitleView *categoryView;
@property (nonatomic, assign) BOOL isNeedFooter;
@property (nonatomic, assign) BOOL isNeedHeader;
@property (nonatomic,   copy) NSString *deptId;
-(JXPagerView *)preferredPagingView;
@end

NS_ASSUME_NONNULL_END
