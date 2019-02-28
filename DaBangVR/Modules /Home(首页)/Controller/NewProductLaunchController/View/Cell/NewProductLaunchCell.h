//
//  NewProductLaunchCell.h
//  DaBangVR
//
//  Created by mac on 2019/1/29.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "NewGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol NewProductLaunchCellDelegate <NSObject>

/**
 点击cell，进行操作

 @param indexPath 当前操作的indexPath
 */
-(void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath tableViewCell:(id)cell;

@end
@interface NewProductLaunchCell : BaseTableViewCell
// 背景图片
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;
// 商品数量
@property (weak, nonatomic) IBOutlet UILabel *goodsNum;

@property (nonatomic, strong) NewGoodsModel *model;

@property (nonatomic, weak) id<NewProductLaunchCellDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
