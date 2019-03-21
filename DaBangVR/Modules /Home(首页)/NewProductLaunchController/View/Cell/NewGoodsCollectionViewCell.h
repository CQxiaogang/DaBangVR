//
//  NewGoodsCollectionViewCell.h
//  DaBangVR
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewGoodsCollectionViewCell : UICollectionViewCell
// 商品背景
@property (weak, nonatomic) IBOutlet UIView *goodsBackgroud;
// 商品图片
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
// 商品详情
@property (weak, nonatomic) IBOutlet UILabel *goodsDescribe;
// 商品价格
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
// 商品销量
@property (weak, nonatomic) IBOutlet UILabel *goodsSales;
@property (weak, nonatomic) IBOutlet UIButton *nowBuy;

@property (nonatomic, strong) GoodsDetailsModel *model;

@end

NS_ASSUME_NONNULL_END
