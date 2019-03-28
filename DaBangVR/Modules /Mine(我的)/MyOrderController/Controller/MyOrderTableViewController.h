//
//  MyOrderTableViewController.h
//  DaBangVR
//
//  Created by mac on 2019/1/29.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "LoadDataListBaseViewTableViewController.h"
#import "JXCategoryListContainerView.h"
#import "OrderDeptGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol MyOrderTableVCDelegate <NSObject>


/**
 cell 点击

 @param indexPath 当前的indexPath
 @param model 选择的数据
 */
-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath OrderDeptGoodsModel:(OrderDeptGoodsModel *)model;

/**
 订单状态的改变。例:待付款->代发货，待发货->待收货

 @param string Button的title,根据title来进行操作
 */
- (void)lowerRightCornerClickEvent:(NSString *)string;

@end

@interface MyOrderTableViewController : LoadDataListBaseViewTableViewController<JXCategoryListContentViewDelegate>

@property (nonatomic, weak)id<MyOrderTableVCDelegate>aDelegate;

@end

NS_ASSUME_NONNULL_END
