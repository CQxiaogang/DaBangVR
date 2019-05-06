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
static NSArray * _Nullable lastSeleArray;
/* 当前选中的数量 */
static NSInteger curNum;

NS_ASSUME_NONNULL_BEGIN

@protocol LiveShoppingCollectionViewCellDelegate <NSObject>

-(void)nowBuyButtonAndGoodsInfo:(NSArray *)info;
-(void)addShoppongCarButtonOfAction;

@end

@interface LiveShoppingCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) GoodsDetailsModel *model;

@property (nonatomic, weak) id <LiveShoppingCollectionViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
