//
//  informationModificationViewController.h
//  DaBangVR
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserGoodsAdressViewController : RootViewController

@property (nonatomic, copy) void (^ClickAdressBlock)(id data);

@end

NS_ASSUME_NONNULL_END
