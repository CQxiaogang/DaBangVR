//
//  StoreDetailsBottomView.m
//  DaBangVR
//
//  Created by mac on 2019/5/29.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "StoreDetailsBottomView.h"

@implementation StoreDetailsBottomView

-(void)awakeFromNib{
    [super awakeFromNib];
    //设置圆角
    self.goodsNumLabel.layer.cornerRadius = self.goodsNumLabel.mj_h/2;
    self.goodsNumLabel.layer.masksToBounds = YES;
    self.goodsNumLabel.hidden = YES;
}

- (IBAction)shoppingCarButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shoppingCarButtonClick:)]) {
        [self.delegate shoppingCarButtonClick:sender];
    }
}

- (IBAction)totalPriceButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(totalPriceButtonClick:)]) {
        [self.delegate totalPriceButtonClick:sender];
    }
}

-(void)setGoodsData:(NSArray<StoreDetailsShoppingCarModel *> *)goodsData{
    _goodsData = goodsData;
    
    _goodsNumLabel.hidden = NO;
    _goodsNumLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)goodsData.count];
    NSInteger price = 0;
    for (int i=0; i<goodsData.count; i++) {
        StoreDetailsShoppingCarModel *model = goodsData[i];
        price += [model.price integerValue];
    }
    [_shoppingCarButton setTitle:[NSString stringWithFormat:@"￥%ld",price] forState:UIControlStateNormal];
    //起送价
    NSInteger deliveryPrice = [_deptModel.deliveryPrice integerValue];
    //当前价格
    NSInteger currPrice = deliveryPrice - price;
    if (currPrice <= 0) {
        [_totalPriceButton setTitle:@"去结算" forState: UIControlStateNormal];
        [_totalPriceButton setBackgroundColor:KLightGreen];
        _totalPriceButton.userInteractionEnabled = YES;
    }else{
        [_totalPriceButton setTitle:[NSString stringWithFormat:@"还差￥%ld",currPrice] forState: UIControlStateNormal];
        _totalPriceButton.userInteractionEnabled = NO;
    }
}

-(void)setDeptModel:(DeptDetailsModel *)deptModel{
    _deptModel = deptModel;
    [_totalPriceButton setTitle:[NSString stringWithFormat:@"￥%@起送",deptModel.deliveryPrice] forState: UIControlStateNormal];
}

@end
