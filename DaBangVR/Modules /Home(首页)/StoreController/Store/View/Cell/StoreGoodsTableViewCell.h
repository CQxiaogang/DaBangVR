//
//  StoreGoodsTableViewCell.h
//  DaBangVR
//
//  Created by mac on 2019/5/15.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "DeptModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoreGoodsTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *storeName;


@property (nonatomic, strong) DeptModel *model;

@end

NS_ASSUME_NONNULL_END
