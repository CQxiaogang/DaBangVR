//
//  StoreDetailsTopView.h
//  DaBangVR
//
//  Created by mac on 2019/5/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeptDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoreDetailsTopView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *deptBackGroundImagwView;
@property (weak, nonatomic) IBOutlet UILabel *deptName;
//营业时间
@property (weak, nonatomic) IBOutlet UILabel *businessHours;
@property (weak, nonatomic) IBOutlet UILabel *deptAdress;

@property (nonatomic, strong) DeptDetailsModel *deptDetailsModel;

@end

NS_ASSUME_NONNULL_END
