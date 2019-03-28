//
//  RecreationLiveCollectionViewController.h
//  DaBangVR
//
//  Created by mac on 2019/3/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "LoadDataListBaseViewController.h"
#import "JXCategoryListContainerView.h"
NS_ASSUME_NONNULL_BEGIN

@protocol RecreationLiveCollectionViewControllerDelegate <NSObject>

- (void)collectionViewDidSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface RecreationLiveCollectionViewController : LoadDataListBaseViewController<JXCategoryListContentViewDelegate>

@property (nonatomic, weak) id <RecreationLiveCollectionViewControllerDelegate> MDelegate;

@end
NS_ASSUME_NONNULL_END
