//
//  GoodsListsModel.h
//  DaBangVR
//
//  Created by mac on 2019/2/27.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountryListModel : NSObject
// 国家 ID
@property (nonatomic, copy) NSString *id;
// 国家名称
@property (nonatomic, copy) NSString *name;
// 国家图片
@property (nonatomic, copy) NSString *categoryImg;
@end

NS_ASSUME_NONNULL_END
