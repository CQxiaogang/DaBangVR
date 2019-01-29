//
//  HBK_ShoppingCartModel.h
//  HBK_ShoppingCart
//
//  Created by 黄冰珂 on 2017/11/23.
//  Copyright © 2017年 黄冰珂. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HBK_GoodsModel;

@interface HBK_StoreModel : NSObject

@property (nonatomic, copy)   NSString *deptId;
@property (nonatomic, copy)   NSString *deptName;
@property (nonatomic, strong) NSArray  *gcvList;

@property (nonatomic, strong) NSMutableArray *goodsArray;
@property (nonatomic, assign) BOOL isSelect;

@end



@interface HBK_GoodsModel : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *goodsId;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *deptId;
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *retailPrice;
@property (nonatomic, copy) NSString *marketPrice;
@property (nonatomic, copy) NSString *number;
@property (nonatomic, copy) NSString *goodsSpecNames;
@property (nonatomic, copy) NSString *goodsSpecIds;
@property (nonatomic, copy) NSString *checked;
@property (nonatomic, copy) NSString *listUrl;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *deptName;
@property (nonatomic, copy) NSString *goodsSellingPrice;
@property (nonatomic, copy) NSString *goodsMarketPrice;
@property (nonatomic, copy) NSString *goodsLogisticsPrice;
@property (nonatomic, copy) NSString *remainingInventory;
@property (nonatomic, copy) NSString *goodsListUrl;
@property (nonatomic, copy) NSString *productionRetailPrice;
@property (nonatomic, copy) NSString *productionNarketPrice;
@property (nonatomic, copy) NSString *productionLogisticsPrice;
@property (nonatomic, copy) NSString *productionNumber;
@property (nonatomic, copy) NSString *headUrl;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *cartNumber;

@property (nonatomic, assign) BOOL isSelect;



@end
