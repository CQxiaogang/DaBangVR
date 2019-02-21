//
//  MyOrderTableViewController.h
//  DaBangVR
//
//  Created by mac on 2019/1/29.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "LoadDataListBaseViewController.h"
#import "JXCategoryListContainerView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol MyOrderTableVCDelegate <NSObject>

-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MyOrderTableViewController : LoadDataListBaseViewController<JXCategoryListContentViewDelegate>

@property (nonatomic, weak)id<MyOrderTableVCDelegate>aDelegate;

@end

NS_ASSUME_NONNULL_END
