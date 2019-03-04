//
//  GoodsDetailsView.h
//  DaBangVR
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol GoodsDetailsViewDelegate <NSObject>

/**
 展示所以评论事件
 */
- (void)allCommentsAction;

/**
 选择商品规格事件

 @param sender 当前按钮
 */
- (void)chooseAttributesOfClickAction:(UIButton *)sender;

@end

@interface GoodsDetailsView : UIView

-(instancetype)initWithFrame:(CGRect)frame andDataSourse:(GoodsDetailsModel*)model;

@property (nonatomic, weak) id <GoodsDetailsViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
