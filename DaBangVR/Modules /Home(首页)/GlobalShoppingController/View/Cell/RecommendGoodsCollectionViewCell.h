//
//  RecommendGoodsCollectionViewCell.h
//  DaBangVR
//
//  Created by mac on 2019/2/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailsModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol RecommendGoodsCollectionViewCellDelegate <NSObject>

-(void)recommendGoodsAddShoppingCar:(UIButton *)sender;

@end
@interface RecommendGoodsCollectionViewCell : UICollectionViewCell
// 商品图片
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
// 商品详情
@property (weak, nonatomic) IBOutlet UILabel *goodsDescribe;
// 市场价格
@property (weak, nonatomic) IBOutlet UILabel *goodsMarketPrice;
// 销售价格
@property (weak, nonatomic) IBOutlet UILabel *goodsSellingPrice;
// 商品活动内容
@property (weak, nonatomic) IBOutlet UILabel *goodsActivity;

@property (nonatomic, strong) GoodsDetailsModel *model;

@property (nonatomic, weak) id<RecommendGoodsCollectionViewCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
