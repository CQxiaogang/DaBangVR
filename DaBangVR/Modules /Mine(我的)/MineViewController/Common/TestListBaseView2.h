//
//  TestListBaseView2.h
//  DaBangVR
//
//  Created by mac on 2019/2/12.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPagerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TestListBaseView2 : UIView<JXPagerViewListViewDelegate>

@property (nonatomic,strong)UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
