//
//  ListViewController.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryListContainerView.h"
#import "LoadDataListBaseTableViewController.h"

@protocol ListViewControllerDelegate <NSObject>

- (void)didSelectRowAtIndexPath:(NSString *)index;

@end

@interface ListViewController : LoadDataListBaseTableViewController <JXCategoryListContentViewDelegate>

@property (nonatomic, assign) NSInteger timeIndex;

@property (nonatomic, weak) id<ListViewControllerDelegate> aDelegate;

@end
