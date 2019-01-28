//
//  BaseTableViewCell.h
//  DaBangVR
//
//  Created by mac on 2018/12/24.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsShowListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GoodsShowTableViewCell : BaseTableViewCell
// 商品图片
@property (weak, nonatomic) IBOutlet YYAnimatedImageView *headImgView;
// 商品详情
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;
// 价格
@property (weak, nonatomic) IBOutlet UILabel *sellingPriceLabel;
//
@property (strong, nonatomic) GoodsShowListModel *model;

@end

NS_ASSUME_NONNULL_END
