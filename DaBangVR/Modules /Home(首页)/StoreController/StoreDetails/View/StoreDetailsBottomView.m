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
    //设置goodsNumLabel
    NSInteger currCount = 0;
    for (int i = 0; i<goodsData.count; i++) {
        StoreDetailsShoppingCarModel *model = goodsData[i];
        NSInteger count = [model.number integerValue];
        currCount = count+currCount;
    }
    if (currCount > 0) {
        _goodsNumLabel.hidden = NO;
        _goodsNumLabel.text = [NSString stringWithFormat:@"%ld",currCount];
    }else{
        _goodsNumLabel.hidden = YES;
    }
    
    //购物车总价
    NSInteger totalPrice = 0;
    for (int i=0; i<goodsData.count; i++) {
        StoreDetailsShoppingCarModel *model = goodsData[i];
        NSInteger  price = [model.price integerValue];
        NSInteger  count = [model.number integerValue];
        NSInteger  currPrice = price * count;
        totalPrice = totalPrice + currPrice;
    }
    
    if (totalPrice) {
        [_shoppingCarButton setTitle:[NSString stringWithFormat:@"￥%ld",totalPrice] forState:UIControlStateNormal];
    }else{
        [_shoppingCarButton setTitle:@"购物车是空的" forState:UIControlStateNormal];
    }
    
    
    //起送价
    NSInteger deliveryPrice = [_deptModel.deliveryPrice integerValue];
    //当前价格
    NSInteger currPrice = deliveryPrice - totalPrice;
    if (currPrice <= 0) {
        [_totalPriceButton setTitle:@"去结算" forState: UIControlStateNormal];
        [_totalPriceButton setBackgroundColor:KLightGreen];
        _totalPriceButton.userInteractionEnabled = YES;
    }else{
        [_totalPriceButton setTitle:[NSString stringWithFormat:@"还差￥%ld",currPrice] forState: UIControlStateNormal];
        [_totalPriceButton setBackgroundColor:KRedColor];
        _totalPriceButton.userInteractionEnabled = NO;
    }
}

-(void)setDeptModel:(DeptDetailsModel *)deptModel{
    _deptModel = deptModel;
    [_totalPriceButton setTitle:[NSString stringWithFormat:@"￥%@起送",deptModel.deliveryPrice] forState: UIControlStateNormal];
}

-(void)setCount:(NSUInteger)count{
    _count = count;
    
}

@end
