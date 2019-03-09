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


/**
 cell 点击

 @param indexPath 当前的indexPath
 @param state 当前订单状态,例如201->待付款
 */
-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath orderState:(NSInteger)state;

/**
 订单状态的改变。例:待付款->代发货，待发货->待收货

 @param string Button的title,根据title来进行操作
 */
- (void)lowerRightCornerClickEvent:(NSString *)string;

@end

@interface MyOrderTableViewController : LoadDataListBaseViewController<JXCategoryListContentViewDelegate>

@property (nonatomic, weak)id<MyOrderTableVCDelegate>aDelegate;

@end

NS_ASSUME_NONNULL_END
