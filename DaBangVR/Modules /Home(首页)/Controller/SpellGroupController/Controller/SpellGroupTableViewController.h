//
//  SpellGroupTableViewController.h
//  DaBangVR
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadDataListBaseViewController.h"
#import "JXCategoryListContainerView.h"

@protocol SpellGroupTableViewDelegate <NSObject>

- (void)didSelectGoodsShowDetails:(NSString *)index;

@end
NS_ASSUME_NONNULL_BEGIN

@interface SpellGroupTableViewController : LoadDataListBaseViewController<JXCategoryListContentViewDelegate>

@property (nonatomic, copy) NSString *currentView;

@property (nonatomic, weak) id <SpellGroupTableViewDelegate> aDelegate;

@end

NS_ASSUME_NONNULL_END
