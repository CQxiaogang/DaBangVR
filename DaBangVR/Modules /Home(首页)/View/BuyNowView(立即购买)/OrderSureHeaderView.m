//
//  OrderSureHeaderView.m
//  DaBangVR
//
//  Created by mac on 2019/1/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "OrderSureHeaderView.h"
#import "OrderSureDeptGoodsModel.h"

@interface OrderSureHeaderView ()

@property (nonatomic, strong) NSMutableArray <OrderSureDeptGoodsModel *> *list;

@end

@implementation OrderSureHeaderView


- (void)setModel:(OrderSureModel *)model{
    _list = [[NSMutableArray alloc] init];
    _list = [OrderSureDeptGoodsModel mj_objectArrayWithKeyValuesArray:model.deptGoodsList];
    _deptName.text = _list[0].deptName;
    [_deptImgView setImageWithURL:[NSURL URLWithString:_list[0].deptLogo] placeholder:[UIImage imageNamed:@""]];
}
@end
