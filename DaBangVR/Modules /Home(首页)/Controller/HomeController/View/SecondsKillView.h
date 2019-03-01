//
//  timeLimitSecondsKill.h
//  DaBangVR
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecondsKillView : UIView
// 商品图片
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
// 商品价格
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;

@property (nonatomic, strong) GoodsDetailsModel *model;

@end

NS_ASSUME_NONNULL_END
