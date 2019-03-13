//
//  RightSecondsKillCell.h
//  DaBangVR
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "OrderGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RightSecondsKillCell : BaseTableViewCell
// 取消提醒
@property (weak, nonatomic) IBOutlet UIButton *CancelReminderBtn;
// 商品图片
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
// 商品详情
@property (weak, nonatomic) IBOutlet UILabel *goodsDetails;
// 商品促销价
@property (weak, nonatomic) IBOutlet UILabel *goodsSellingPrice;
// 商品市场价
@property (weak, nonatomic) IBOutlet UILabel *goodsMarketPrice;
// 关注数量
@property (weak, nonatomic) IBOutlet UILabel *attentionNum;
@property (nonatomic, strong) OrderGoodsModel *model;
@end

NS_ASSUME_NONNULL_END
