//
//  DBDetailHeaderView.h
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyNowModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol DBDetailHeaderViewDelegate <NSObject>

- (void)informationModification;

@end

@interface DBDetailHeaderView : UIView
// 收货人名字
@property (weak, nonatomic) IBOutlet UILabel *consigneeNameLab;
// 收货人手机号
@property (weak, nonatomic) IBOutlet UILabel *consigneePhoneLab;
// 地址
@property (weak, nonatomic) IBOutlet UILabel *addressLab;

@property (nonatomic, weak) id<DBDetailHeaderViewDelegate> delegate;

@property (nonatomic, strong) BuyNowModel *model;

@end

NS_ASSUME_NONNULL_END
