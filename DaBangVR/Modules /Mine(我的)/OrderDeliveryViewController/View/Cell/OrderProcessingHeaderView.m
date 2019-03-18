//
//  OrderProcessingHeaderView.m
//  DaBangVR
//
//  Created by mac on 2019/3/15.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "OrderProcessingHeaderView.h"

@implementation OrderProcessingHeaderView

- (void)setModel:(OrderDeptGoodsModel *)model{
    _model = model;
    _deptImgView.image = [UIImage imageNamed:model.deptLogo];
    _deptName.text = model.deptName;
}

@end
