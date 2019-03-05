//
//  SpellGroupCell.h
//  DaBangVR
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "SpellGroupModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SpellGroupCell : BaseTableViewCell
// 商品图片
@property (weak, nonatomic) IBOutlet YYAnimatedImageView *goodsImgView;
// 当前状态 直播/热卖
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
// 商品描述
@property (weak, nonatomic) IBOutlet UILabel *describeLab;
// 原价
@property (weak, nonatomic) IBOutlet UILabel *marketPriceLab;
// 销售价格
@property (weak, nonatomic) IBOutlet UILabel *sellingPriceLab;
@property (weak, nonatomic) IBOutlet UIButton *spellListBtn;

@property (nonatomic, strong) SpellGroupModel *model;

@end

NS_ASSUME_NONNULL_END
