//
//  StoreDetailsTableView.h
//  DaBangVR
//
//  Created by mac on 2019/5/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPagerView.h"
#import "DeptDetailsGoodsCategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^animationBlock)(CABasicAnimation *animation);

@interface StoreDetailsTableView : UIView<JXPagerViewListViewDelegate>

@property (nonatomic, strong) UIScrollView *contenView;

@property (nonatomic, copy) void (^shoppingCarInfo)(NSArray *dataSource, NSInteger count);

@property (nonatomic, strong) NSString *deptId;

@property (nonatomic, copy) animationBlock animationBlock;

@property (nonatomic, copy) void(^cellBlock)(BOOL animation);

@end

NS_ASSUME_NONNULL_END
