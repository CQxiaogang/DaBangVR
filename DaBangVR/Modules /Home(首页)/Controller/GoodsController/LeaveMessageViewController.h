//
//  LeaveMessageViewController.h
//  DaBangVR
//
//  Created by mac on 2019/1/23.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "RootViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LeaveMessageViewController : RootViewController

@property (nonatomic, copy) void (^textViewBlock)(NSString * string);

@end

NS_ASSUME_NONNULL_END
