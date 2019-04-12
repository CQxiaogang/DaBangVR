//
//  ShouldBeginLiveGoodsCell.h
//  DaBangVR
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShouldBeginLiveGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShouldBeginLiveGoodsCell : UICollectionViewCell
/** 商品图片 */
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
/** 商品名字 */
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
/** 选择的按钮 */
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (nonatomic, strong) ShouldBeginLiveGoodsModel *model;
@end

NS_ASSUME_NONNULL_END
