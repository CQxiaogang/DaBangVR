//
//  GoodsImageShowView.h
//  DaBangVR
//
//  Created by mac on 2019/5/22.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GoodsImageShowAndGoodsDetailsView : UIView

@property (nonatomic, copy) NSArray *imgList;

@property (nonatomic, strong) GoodsDetailsModel *goodsModel;

@end

NS_ASSUME_NONNULL_END
