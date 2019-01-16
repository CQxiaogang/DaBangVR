//
//  LoadDataListBaseViewController.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/28.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoadDataListBaseViewControllerDelegate <NSObject>

- (void)didSelectGoodsShowDetails:(NSString *) index;

@end

@interface LoadDataListBaseViewController : UITableViewController

@property (nonatomic, strong) NSString *ID;
- (void)loadDataForFirst;

@property (nonatomic, weak) id <LoadDataListBaseViewControllerDelegate> delegate;

@end
