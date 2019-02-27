//
//  CountryGoodsCollectionViewCell.h
//  DaBangVR
//
//  Created by mac on 2019/2/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol CountryGoodsCollectionViewCellDelegate <NSObject>

- (void)countryGoodsAddShoppingCar:(UIButton *)sender;

@end
@interface CountryGoodsCollectionViewCell : UICollectionViewCell
// 商品图片
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
// 商品详情
@property (weak, nonatomic) IBOutlet UILabel *goodsDescribe;
// 商品价格
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
// 发货区域
@property (weak, nonatomic) IBOutlet UILabel *sendGoodsArea;

@property (nonatomic, strong) GoodsDetailsModel *model;
@property (nonatomic, weak) id<CountryGoodsCollectionViewCellDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
