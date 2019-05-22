//
//  GoodsDetailsView.m
//  DaBangVR
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "GoodsInfoView.h"

@interface GoodsInfoView ()
//销售价
@property (weak, nonatomic) IBOutlet UILabel *sellingPriceLabel;
//原价
@property (weak, nonatomic) IBOutlet UILabel *originalpriceLabel;
//详情
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
//邮费
@property (weak, nonatomic) IBOutlet UILabel *postagePriceLabel;

@end

@implementation GoodsInfoView

- (void)setGoodsModel:(GoodsDetailsModel *)goodsModel{
    _goodsModel = goodsModel;
    _sellingPriceLabel.text  = [NSString stringWithFormat:@"￥%@",goodsModel.sellingPrice];
    _originalpriceLabel.text = goodsModel.marketPrice;
    _goodsNameLabel.text = goodsModel.name;
    //当邮费为0的时候
    if ([goodsModel.logisticsPrice isEqualToString:@"0"]) {
        _postagePriceLabel.text = @"免邮费";
    }else{
        _postagePriceLabel.text = [NSString stringWithFormat:@"邮费:%@",goodsModel.logisticsPrice];
    }
}

@end
