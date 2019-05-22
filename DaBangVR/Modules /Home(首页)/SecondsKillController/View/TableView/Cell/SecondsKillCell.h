//
//  SecondsKillCell.h
//  DaBangVR
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "GoodsInfoView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecondsKillCell : BaseTableViewCell
// 商品图片
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
// 商品详情
@property (weak, nonatomic) IBOutlet UILabel *goodsDetails;
// 商品市场价格
@property (weak, nonatomic) IBOutlet UILabel *goodsMarketPrice;
// 商品销售价格
@property (weak, nonatomic) IBOutlet UILabel *goodsSellingPrice;
// 立即购买
@property (weak, nonatomic) IBOutlet UIButton *BuyNowBtn;

@property (nonatomic, strong) GoodsDetailsModel *model;

@end

NS_ASSUME_NONNULL_END
