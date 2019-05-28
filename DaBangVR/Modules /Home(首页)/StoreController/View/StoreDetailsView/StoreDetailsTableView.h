//
//  StoreDetailsTableView.h
//  DaBangVR
//
//  Created by mac on 2019/5/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPagerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoreDetailsTableView : UIView<JXPagerViewListViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;


@end

NS_ASSUME_NONNULL_END
