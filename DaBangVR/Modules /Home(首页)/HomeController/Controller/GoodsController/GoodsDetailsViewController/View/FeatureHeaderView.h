//
//  DBFeatureHeaderView.h
//  Demo
//
//  Created by mac on 2018/12/28.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBFeatureItem.h"

NS_ASSUME_NONNULL_BEGIN
@class DBFeatureItem;
@interface FeatureHeaderView : UICollectionReusableView
/** 标题数据 */
@property (nonatomic, strong) NSString *headTitle;

@end

NS_ASSUME_NONNULL_END
