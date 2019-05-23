//
//  GoodsDetailsRecommendCollectionView.h
//  DaBangVR
//
//  Created by mac on 2019/5/22.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol GoodsDetailsRecommendCollectionViewDelegate <NSObject>

-(void)contentCollectionViewDidScroll:(UICollectionView *)contentCollectionView;

@end

@interface GoodsDetailsRecommendCollectionView : UICollectionView<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, copy) NSArray *recomentdDataSource;

@property (nonatomic, weak) id<GoodsDetailsRecommendCollectionViewDelegate> aDelegate;

@end

NS_ASSUME_NONNULL_END
