//
//  DBDetailHeaderView.h
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderSureModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol OrderSureTopViewDelegate <NSObject>

- (void)informationModification;

@end

@interface OrderSureTopView : UIView
// 收货人名字
@property (weak, nonatomic) IBOutlet UILabel *consigneeNameLab;
// 收货人手机号
@property (weak, nonatomic) IBOutlet UILabel *consigneePhoneLab;
// 地址
@property (weak, nonatomic) IBOutlet UILabel *addressLab;

@property (nonatomic, weak) id<OrderSureTopViewDelegate> delegate;

@property (nonatomic, strong) UserAddressModel *model;

@end

NS_ASSUME_NONNULL_END
