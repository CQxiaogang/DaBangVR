//
//  MySpellGroupCell.m
//  DaBangVR
//
//  Created by mac on 2019/1/17.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "MySpellGroupCell.h"

@implementation MySpellGroupCell

- (void)awakeFromNib {
    [super awakeFromNib];    
}

-(void)setModel:(OrderGoodsModel *)model{
    _model = model;
    [_goodsImgView setImageWithURL:[NSURL URLWithString:model.listUrl?model.listUrl:model.chartUrl] placeholder:kDefaultImg];
    _goodsDetails.text = model.goodsName;
    _goodsPrice.text = [NSString stringWithFormat:@"￥ %@",model.retailPrice];
    _goodsNum.text = [NSString stringWithFormat:@"x%@",model.number];
    _goodsNum2.text = [NSString stringWithFormat:@"共%@件商品",model.number];
    _goodsSpec.text = model.goodsSpecNames;
}

@end
