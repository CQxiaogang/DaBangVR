//
//  LoadDataListBaseCollectionViewController.h
//  DaBangVR
//
//  Created by mac on 2019/3/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoadDataListBaseViewControllerDelegate <NSObject>

- (void)collectionViewSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface LoadDataListBaseViewController : UIViewController

@property (nonatomic, strong) UICollectionView *collectionView;

- (void)loadingData;

@property (nonatomic, weak) id <LoadDataListBaseViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
