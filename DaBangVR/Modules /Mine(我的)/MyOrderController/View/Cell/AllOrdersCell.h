//
//  AllOrdersCell.h
//  DaBangVR
//
//  Created by mac on 2019/1/9.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderGoodsModel.h"
#import "OrderDeptGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol allOrdersCellDelegate <NSObject>

- (void)lowerRightCornerClickEvent:(NSString *)string;

@end

@interface AllOrdersCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet YYAnimatedImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UILabel *sizeLab;
// 商品规格
@property (weak, nonatomic) IBOutlet UILabel *goodsSpec;

@property (nonatomic, strong) id<allOrdersCellDelegate> delegate;

@property (nonatomic, strong) OrderGoodsModel *model;
@property (nonatomic, strong) OrderDeptGoodsModel *depModel;
@end

NS_ASSUME_NONNULL_END
