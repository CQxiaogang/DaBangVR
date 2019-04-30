//
//  LiveGoddsInfoTableViewCell.h
//  DaBangVR
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface LiveGoodsInfoTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsDetails;
/** 商品编好 */
@property (weak, nonatomic) IBOutlet UILabel *number;

@end

NS_ASSUME_NONNULL_END
