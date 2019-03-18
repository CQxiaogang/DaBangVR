//
//  OrderProcessingHeaderView.h
//  DaBangVR
//
//  Created by mac on 2019/3/15.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDeptGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderProcessingHeaderView : UITableViewHeaderFooterView
// 店铺图片
@property (weak, nonatomic) IBOutlet UIImageView *deptImgView;
// 店铺名字
@property (weak, nonatomic) IBOutlet UILabel *deptName;

@property (nonatomic, strong) OrderDeptGoodsModel *model;

@end

NS_ASSUME_NONNULL_END
