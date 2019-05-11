//
//  modifyAddressViewController.h
//  DaBangVR
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AreaView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ModifyAddressViewController : RootViewController<AreaSelectDelegate>

@property (nonatomic, copy) NSString *adressID;

@end

NS_ASSUME_NONNULL_END
