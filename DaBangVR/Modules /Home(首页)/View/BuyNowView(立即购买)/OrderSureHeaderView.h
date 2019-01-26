//
//  OrderSureHeaderView.h
//  DaBangVR
//
//  Created by mac on 2019/1/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderSureModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderSureHeaderView : UIView
@property (weak, nonatomic) IBOutlet YYAnimatedImageView *deptImgView;
@property (weak, nonatomic) IBOutlet UILabel *deptName;

@property (nonatomic, copy) OrderSureModel *model;

@end

NS_ASSUME_NONNULL_END
