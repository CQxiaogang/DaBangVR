//
//  BaseTableView.h
//  DaBangVR
//
//  Created by mac on 2018/12/24.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SeafoodShowTableViewDelegate <NSObject>

- (void)selectCellShowGoods;

@end

@interface SeafoodShowTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

// 数据源
@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, weak) id<SeafoodShowTableViewDelegate> sfDelegate;

@end

NS_ASSUME_NONNULL_END
