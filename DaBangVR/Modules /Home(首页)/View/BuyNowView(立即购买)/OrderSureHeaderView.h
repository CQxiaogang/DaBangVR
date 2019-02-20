//
//  OrderSureHeaderView.h
//  DaBangVR
//
//  Created by mac on 2019/1/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderDeptGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderSureHeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet YYAnimatedImageView *deptImgView;
@property (weak, nonatomic) IBOutlet UILabel *deptName;

@property (nonatomic, copy) OrderDeptGoodsModel *model;

@end

NS_ASSUME_NONNULL_END
