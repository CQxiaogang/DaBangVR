//
//  SpellGroupTableViewController.h
//  DaBangVR
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadDataListBaseTableViewController.h"
#import "JXCategoryListContainerView.h"

@protocol SpellGroupTableViewDelegate <NSObject>

- (void)didSelectGoodsShowDetails:(NSString *_Nullable)index;

@end
NS_ASSUME_NONNULL_BEGIN

@interface SpellGroupTableViewController : LoadDataListBaseTableViewController<JXCategoryListContentViewDelegate>

@property (nonatomic, copy) NSString *currentView;

@property (nonatomic, weak) id <SpellGroupTableViewDelegate> aDelegate;

@end

NS_ASSUME_NONNULL_END
