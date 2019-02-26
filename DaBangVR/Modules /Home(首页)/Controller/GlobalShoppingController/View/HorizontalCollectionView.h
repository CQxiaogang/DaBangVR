//
//  HorizontalCollectionView.h
//  DaBangVR
//
//  Created by mac on 2019/2/25.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HorizontalCollectionView : UICollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout nibWithNibName:(NSString *)NibName;

@end

NS_ASSUME_NONNULL_END
