//
//  OrderProcessingTableViewCell.h
//  DaBangVR
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "OrderGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderProcessingTableViewCell : BaseTableViewCell
// 商品图片
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
// 商品详情
@property (weak, nonatomic) IBOutlet UILabel *goodsDestails;
// 商品数量
@property (weak, nonatomic) IBOutlet UILabel *goodsNum;
// 商品价格
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;

@property (nonatomic, strong) OrderGoodsModel *model;

@end

NS_ASSUME_NONNULL_END
