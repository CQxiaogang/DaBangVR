//
//  DBtableViewCell.h
//  DaBangVR
//
//  Created by mac on 2018/11/21.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewCell : BaseTableViewCell
//商品图片
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
//商品详情
@property (weak, nonatomic) IBOutlet UILabel *goodsDetails;
//商品价格
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
//商品销量
@property (weak, nonatomic) IBOutlet UILabel *goodsSales;
//销量
@property (weak, nonatomic) IBOutlet UILabel *salesVolumeLabel;
@property (weak, nonatomic) IBOutlet UIView *backGround_View;

@property (nonatomic, strong) GoodsDetailsModel *model;

@end

NS_ASSUME_NONNULL_END
