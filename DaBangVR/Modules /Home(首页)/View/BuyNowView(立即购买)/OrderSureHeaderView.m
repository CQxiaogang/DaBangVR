//
//  OrderSureHeaderView.m
//  DaBangVR
//
//  Created by mac on 2019/1/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "OrderSureHeaderView.h"

@interface OrderSureHeaderView ()

@property (nonatomic, strong) NSMutableArray <OrderSureDeptGoodsModel *> *list;

@end

@implementation OrderSureHeaderView


- (void)setModel:(OrderSureDeptGoodsModel *)model{
    _deptName.text = model.deptName;
    [_deptImgView setImageWithURL:[NSURL URLWithString:model.deptLogo] placeholder:[UIImage imageNamed:@""]];
}
@end
