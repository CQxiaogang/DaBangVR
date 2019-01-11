//
//  DBFeatureChoseTopCell.h
//  DaBangVR
//
//  Created by mac on 2018/12/29.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBFeatureChoseTopCell : BaseTableViewCell

/** 取消点击回调 */
@property (nonatomic, copy) dispatch_block_t crossButtonClickBlock;

/* 商品价格 */
@property (strong , nonatomic)UILabel *goodPriceLabel;
/* 图片 */
@property (strong , nonatomic)UIImageView *goodImageView;
/* 选择属性 */
@property (strong , nonatomic)UILabel *chooseAttLabel;

@end

NS_ASSUME_NONNULL_END
