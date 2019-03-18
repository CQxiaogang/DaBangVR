//
//  OrderProcessingFooterView.m
//  DaBangVR
//
//  Created by mac on 2019/3/18.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "OrderProcessingFooterView.h"

@implementation OrderProcessingFooterView


- (void)setModel:(OrderDeptGoodsModel *)model{
    _model = model;
    _address.text = model.address;
    _logisticsName.text = model.logisticsName;
    _orderNum.text = model.orderSn;
    _orderTime.text = [self timeWithTimeIntervalString:model.orderTime];
}

// 时间戳转换为日期格式(毫秒的时间戳)
- (NSString *)timeWithTimeIntervalString:(NSString *)timeString{
    NSTimeInterval interval    =[timeString doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

@end
