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

- (void)showMoreGoods:(UIButton *)sender;

@end
@interface HomeNewAndHotGoodsView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *firstImgView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImgView;
@property (weak, nonatomic) IBOutlet UIButton *showMoreGoodsBtn;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;

@property (nonatomic, weak) id<HomeNewAndHotGoodsViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
