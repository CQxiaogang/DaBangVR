//
//  GoodsDetailsToStoreView.m
//  DaBangVR
//
//  Created by mac on 2019/5/22.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "GoodsDetailsToStoreView.h"

@implementation GoodsDetailsToStoreView

- (void)setModel:(GoodsDetailsModel *)model{
    _model               = model;
    _storeNameLabel.text = model.deptName;
    [_storeImgView setImageURL:[NSURL URLWithString:model.deptLogo]];
}

@end
