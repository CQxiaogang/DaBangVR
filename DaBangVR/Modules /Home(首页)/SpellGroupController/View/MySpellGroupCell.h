//
//  MySpellGroupCell.h
//  DaBangVR
//
//  Created by mac on 2019/1/17.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "OrderGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MySpellGroupCell : BaseTableViewCell
// 头像
@property (weak, nonatomic) IBOutlet UIImageView *headPortrait;
// 拼团人数
@property (weak, nonatomic) IBOutlet UILabel *spellGroupPepple;
// 商品图片
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
// 商品详情
@property (weak, nonatomic) IBOutlet UILabel *goodsDetails;
// 商品规格
@property (weak, nonatomic) IBOutlet UILabel *goodsSpec;
// 商品价格
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
// 商品数量
@property (weak, nonatomic) IBOutlet UILabel *goodsNum;
@property (weak, nonatomic) IBOutlet UILabel *goodsNum2;
// 商品总价
@property (weak, nonatomic) IBOutlet UILabel *goodsTotalPrice;

@property (nonatomic, strong) OrderGoodsModel *model;

@end

NS_ASSUME_NONNULL_END
