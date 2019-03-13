//
//  BaseViewController.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/9.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"

#define WindowsSize [UIScreen mainScreen].bounds.size

@protocol ContentBaseViewControllerDelegate <NSObject>

@end

@interface ContentBaseViewController : RootViewController

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) JXCategoryBaseView *categoryView;

@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@property (nonatomic, assign) BOOL isNeedIndicatorPositionChangeItem;

@property (nonatomic, assign) BOOL shouldHandleScreenEdgeGesture;

@property (nonatomic, weak) id<ContentBaseViewControllerDelegate> delegate;

- (JXCategoryBaseView *)preferredCategoryView;

- (CGFloat)preferredCategoryViewHeight;

- (id<JXCategoryListContentViewDelegate>)preferredListAtIndex:(NSInteger)index;

- (void)didSelectRowAtIndexPath:(NSString *)index;
@end
