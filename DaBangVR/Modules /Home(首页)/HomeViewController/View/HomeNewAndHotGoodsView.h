//
//  prefectureView.h
//  DaBangVR
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HomeNewAndHotGoodsViewDelegate <NSObject>

/**
 展示更新品Button

 @param sender 当前操作的Button
 */
-(void)showMoreGoods:(UIButton *)sender;

/**
 选择商品到商品详情界面

 @param imageView 当面操作的imageView
 */
-(void)goodsImgViewGoGoodsDetailsView:(UIImageView *)imageView;

@end
@interface HomeNewAndHotGoodsView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *firstImgView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImgView;
/** 更多新品Button */
@property (weak, nonatomic) IBOutlet UIButton    *showMoreGoodsBtn;
/** 商品图片 */
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;

@property (nonatomic, weak) id<HomeNewAndHotGoodsViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
