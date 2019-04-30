//
//  liveShoppingCollectionViewCell.h
//  DaBangVR
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailsModel.h"

/* 上一次选择的属性 */
static NSArray *lastSeleArray;

NS_ASSUME_NONNULL_BEGIN

/* 上一次选择的数量 */
static NSInteger lastNum;

@interface LiveShoppingCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) GoodsDetailsModel *model;

@end

NS_ASSUME_NONNULL_END
