//
//  GoodsDetailsView.h
//  DaBangVR
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailsModel.h"
#import "GoodsInfoView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GoodsInfoView : UIView

@property (nonatomic, strong) GoodsDetailsModel *goodsModel;

@end

NS_ASSUME_NONNULL_END
