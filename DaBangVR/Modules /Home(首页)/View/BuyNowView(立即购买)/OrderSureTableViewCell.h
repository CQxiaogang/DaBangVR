//
//  DBDetailContentCell.h
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderSureModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderSureTableViewCell : BaseTableViewCell
// 商品图片
@property (weak, nonatomic) IBOutlet YYAnimatedImageView *goodsImgView;
// 商品详情
@property (weak, nonatomic) IBOutlet UILabel *goodsDescribeLab;
// 促销价
@property (weak, nonatomic) IBOutlet UILabel *sellingPriceLab;
// 市场价格
@property (weak, nonatomic) IBOutlet UILabel *marketPriceLab;

@property (nonatomic, strong) OrderSureModel *model;

@end

NS_ASSUME_NONNULL_END
