//
//  ShoppingLiveTableViewController.h
//  DaBangVR
//
//  Created by mac on 2019/3/29.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "LoadDataListBaseTableViewController.h"
#import "JXCategoryListContainerView.h"
/** Models */
#import "LiveModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ShoppingLiveTableViewControllerDelegate <NSObject>

- (void)tableViewDidSelectRowAtIndexPathForModel:(LiveModel *)model;

@end
@interface ShoppingLiveTableViewController : LoadDataListBaseTableViewController<JXCategoryListContentViewDelegate>
@property (nonatomic, weak) id<ShoppingLiveTableViewControllerDelegate>MDelegate;

@end

NS_ASSUME_NONNULL_END
