//
//  GoodsRecommendCollectionViewCell.h
//  DaBangVR
//
//  Created by mac on 2019/5/22.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsShowListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GoodsRecommendCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsDetailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;

@property (nonatomic, strong) GoodsShowListModel *model;

@end

NS_ASSUME_NONNULL_END
