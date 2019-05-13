//
//  ShufflingView.h
//  DaBangVR
//
//  Created by mac on 2019/2/20.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeBannerView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ShufflingViewDelegate <NSObject>

-(void)goodsRotationSelectedAndJumpUrl:(NSString *)jumpUrl andParentId:(NSString *)parentId;

@end
@interface ShufflingView : UIView<HomeBannerViewDelegate>
-(instancetype)initWithFrame:(CGRect)frame andIndex:(NSString *)index;

@property (nonatomic, weak) id<ShufflingViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
