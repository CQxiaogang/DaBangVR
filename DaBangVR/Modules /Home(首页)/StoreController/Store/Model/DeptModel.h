//
//  DeptModel.h
//  DaBangVR
//
//  Created by mac on 2019/5/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeptModel : NSObject

@property (nonatomic, copy) NSString *deptId;
@property (nonatomic, copy) NSString *name;
//店铺logo
@property (nonatomic, copy) NSString *logo;
//活动
@property (nonatomic, copy) NSString *activityName;
//店铺销售量
@property (nonatomic, copy) NSString *deptSalesVolume;
//到达时间
@property (nonatomic, copy) NSString *reachTime;
//距离
@property (nonatomic, copy) NSString *distance;
@end

NS_ASSUME_NONNULL_END
