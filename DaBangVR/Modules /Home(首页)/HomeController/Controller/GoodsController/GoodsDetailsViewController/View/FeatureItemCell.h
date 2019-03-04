//
//  DBFeatureItemCell.h
//  Demo
//
//  Created by mac on 2018/12/28.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DBFeatureList;
@interface FeatureItemCell : UICollectionViewCell
/* 内容数据 */
@property (nonatomic, copy) DBFeatureList *content;
@end

NS_ASSUME_NONNULL_END
