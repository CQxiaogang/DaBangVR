//
//  LiveCollectionView.h
//  DaBangVR
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryListContainerView.h"
NS_ASSUME_NONNULL_BEGIN

@protocol LiveCollectionViewDelegate <NSObject>

- (void)collectionViewDidSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface LiveCollectionView : UICollectionView<JXCategoryListContentViewDelegate>

@property (nonatomic, weak) id<LiveCollectionViewDelegate>MDelegate;

-(instancetype)initWithFrame:(CGRect)frame itemCount:(NSArray *)arr;

@end

NS_ASSUME_NONNULL_END
