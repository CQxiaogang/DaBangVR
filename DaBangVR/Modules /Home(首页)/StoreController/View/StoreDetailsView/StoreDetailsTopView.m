//
//  StoreDetailsTopView.m
//  DaBangVR
//
//  Created by mac on 2019/5/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "StoreDetailsTopView.h"

@implementation StoreDetailsTopView

-(void)setDeptDetailsModel:(DeptDetailsModel *)deptDetailsModel{
    _deptDetailsModel = deptDetailsModel;
    _deptName.text    = deptDetailsModel.name;
    _deptAdress.text  = deptDetailsModel.productionAddress;
    _businessHours.text = [NSString stringWithFormat:@"%@-%@",[self timeWithTimeIntervalString:deptDetailsModel.operateStartTime],[self timeWithTimeIntervalString:deptDetailsModel.operateEndTime]];
    [_deptBackGroundImagwView setImageURL:[NSURL URLWithString:deptDetailsModel.logo]];
}

// 时间戳转换为日期格式(毫秒的时间戳)
- (NSString *)timeWithTimeIntervalString:(NSString *)timeString{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm"];
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

@end
