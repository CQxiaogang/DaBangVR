//
//  HomeBannerView.h
//  DaBangVR
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsRotationListModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol HomeBannerViewDelegate <NSObject>

-(void)imageDidSelected:(NSString *)goodsID;

@end
@interface HomeBannerView : UIView

-(instancetype)initWithFrame:(CGRect)frame andGoodsArray:(NSArray*)array;

@property (nonatomic, weak) id <HomeBannerViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
