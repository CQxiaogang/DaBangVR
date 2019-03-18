//
//  OrderProcessingTableViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "OrderProcessingTableViewCell.h"

@implementation OrderProcessingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(OrderGoodsModel *)model{
    _model = model;
    [_goodsImgView setImageWithURL:[NSURL URLWithString:model.listUrl?model.listUrl:model.goodsListUrl] placeholder:kDefaultImg];
    _goodsDestails.text = model.goodsName;
    _goodsNum.text = [NSString stringWithFormat:@"x%@",model.goodsNumber];
    _goodsPrice.text = [NSString stringWithFormat:@"￥%@",model.retailPrice];
}

@end
