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
-(void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end
@interface NewProductLaunchCell : BaseTableViewCell
// 背景图片
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;
// 商品数量
@property (weak, nonatomic) IBOutlet UILabel *goodsNum;

@property (nonatomic, strong) NewGoodsModel *model;

@property (nonatomic, weak) id<NewProductLaunchCellDelegate>delegate;


/**
 cell回调，用于操作当前tableView的cell，和当前collectionView的indexPath。
 当点击商品push到详情的时候，需要得到被操作的商品在哪个cell上。
 */
@property (nonatomic, copy) void (^cellBlock)(NewProductLaunchCell *cell, NSIndexPath *indexPath);

@end

NS_ASSUME_NONNULL_END
