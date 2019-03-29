//
//  LoadDataListBaseViewController.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/28.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoadDataListBaseTableViewControllerDelegate <NSObject>

- (void)didSelectGoodsShowDetails:(NSString *) index;

@end

@interface LoadDataListBaseTableViewController : UITableViewController

@property (nonatomic, strong) NSString *index;
- (void)loadDataForFirst;

@property (nonatomic, weak) id <LoadDataListBaseTableViewControllerDelegate> delegate;

@end
