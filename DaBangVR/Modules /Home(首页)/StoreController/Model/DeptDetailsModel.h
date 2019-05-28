//
//  DeptDetailsModel.h
//  DaBangVR
//
//  Created by mac on 2019/5/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeptDetailsModel : NSObject
//店面名
@property (nonatomic, copy) NSString *name;
//手机号
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *productionProvince;
@property (nonatomic, copy) NSString *productionCity;
@property (nonatomic, copy) NSString *productionCounty;
@property (nonatomic, copy) NSString *productionAddress;
//邮箱
@property (nonatomic, copy) NSString *email;
//营业时间
@property (nonatomic, copy) NSString *operateStartTime;
@property (nonatomic, copy) NSString *operateEndTime;
@property (nonatomic, copy) NSString *logo;
@end

NS_ASSUME_NONNULL_END
