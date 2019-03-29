//
//  LoadDataListContainerListViewController.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/12/19.
//  Copyright © 2018 jiaxin. All rights reserved.
//

#import "LoadDataListBaseTableViewController.h"
#import "JXCategoryListContainerView.h"

@interface GoodsShowTableViewController : LoadDataListBaseTableViewController <JXCategoryListContentViewDelegate>

@property (nonatomic, copy) void (^block)(NSArray *list,NSError *error);

@end

