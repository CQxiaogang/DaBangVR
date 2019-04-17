//
//  RecreationLiveCollectionViewController.h
//  DaBangVR
//
//  Created by mac on 2019/3/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "LoadDataListBaseViewController.h"
#import "JXCategoryListContainerView.h"
/** Models */
#import "LiveModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol RecreationLiveCollectionViewControllerDelegate <NSObject>

- (void)collectionViewSelectItemAtIndexPathForModel:(LiveModel *)model;

@end

@interface RecreationLiveCollectionViewController : LoadDataListBaseViewController<JXCategoryListContentViewDelegate>

@property (nonatomic, weak) id <RecreationLiveCollectionViewControllerDelegate> MDelegate;

@end
NS_ASSUME_NONNULL_END
