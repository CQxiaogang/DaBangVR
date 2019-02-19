//
//  MineCollectionTableViewCell.h
//  DaBangVR
//
//  Created by mac on 2019/2/12.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineCollectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineCollectionTableViewCell : BaseTableViewCell

@property (nonatomic, strong) MineCollectionModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsDetail;
// 原价
@property (weak, nonatomic) IBOutlet UILabel *originalPrice;
// 促销价
@property (weak, nonatomic) IBOutlet UILabel *PromotionPrice;

@end

NS_ASSUME_NONNULL_END
