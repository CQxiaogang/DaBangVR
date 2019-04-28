//
//  DidBeginLiveGoodsTableViewCell.h
//  DaBangVR
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "GoodsDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DidBeginLiveGoodsTableViewCell : BaseTableViewCell

@property (nonatomic, strong) GoodsDetailsModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;

@end

NS_ASSUME_NONNULL_END
