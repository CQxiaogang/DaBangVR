//
//  OrderProcessingFooterView.h
//  DaBangVR
//
//  Created by mac on 2019/3/18.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDeptGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderProcessingFooterView : UITableViewHeaderFooterView
// 收货地址
@property (weak, nonatomic) IBOutlet UILabel *address;
// 配送方式
@property (weak, nonatomic) IBOutlet UILabel *logisticsName;
// 订单编号
@property (weak, nonatomic) IBOutlet UILabel *orderNum;
// 订单时间
@property (weak, nonatomic) IBOutlet UILabel *orderTime;
@property (nonatomic, strong) OrderDeptGoodsModel *model;
@end

NS_ASSUME_NONNULL_END
