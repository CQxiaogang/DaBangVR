//
//  LoadDataListContainerListViewController.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/12/19.
//  Copyright © 2018 jiaxin. All rights reserved.
//

#import "LoadDataListBaseViewTableViewController.h"
#import "JXCategoryListContainerView.h"

@interface GoodsShowTableViewController : LoadDataListBaseViewTableViewController <JXCategoryListContentViewDelegate>

@property (nonatomic, copy) void (^block)(NSArray *list,NSError *error);

@end

