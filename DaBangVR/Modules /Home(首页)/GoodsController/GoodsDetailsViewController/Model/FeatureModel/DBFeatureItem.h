//
//  DBFeatureItem.h
//  Demo
//
//  Created by mac on 2018/12/28.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBFeatureList.h"
#import "DBFeatureTitleItem.h"

NS_ASSUME_NONNULL_BEGIN
//@class DBFeatureTitleItem,DBFeatureList;
@interface DBFeatureItem : NSObject

/* 名字 */
@property (nonatomic, strong) NSString *name;
/* 数组 */
@property (nonatomic, strong) NSArray<DBFeatureList *> *goodsSpecList;

@end

NS_ASSUME_NONNULL_END
