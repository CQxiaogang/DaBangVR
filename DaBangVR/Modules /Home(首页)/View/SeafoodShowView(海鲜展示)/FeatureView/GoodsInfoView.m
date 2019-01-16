//
//  GoodsInfoView.m
//  DaBangVR
//
//  Created by mac on 2018/12/26.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "GoodsInfoView.h"


@implementation GoodsInfoView

- (IBAction)chooseBabyAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseBabyAction)]) {
        [self.delegate chooseBabyAction];
    }
}

- (IBAction)allCommentsAction:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(allCommentsAction)]) {
        [self.delegate allCommentsAction];
    }
}

- (void)setUpGoodsFeature:(NSArray *)array{
    NSString *goodsInfoStr = [NSString stringWithFormat:@"你选择的是：%@",[array componentsJoinedByString:@","]];
    [_chooseBaby setTitle:goodsInfoStr forState:UIControlStateNormal];
}

- (void)setModel:(GoodsDetailsModel *)model{
    _promotionPrice.text = model.sellingPrice;
    _introduce.text  = model.describe;
}

@end
