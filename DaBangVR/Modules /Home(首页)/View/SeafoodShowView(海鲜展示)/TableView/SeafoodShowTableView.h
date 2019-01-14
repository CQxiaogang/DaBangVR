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
// 选择的cell
- (void)selectCellShowGoods;

@end

@interface SeafoodShowTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

// 数据源，存储网络参数
@property (nonatomic, strong) NSArray *IDs;
// 当前选择的index
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, weak) id<SeafoodShowTableViewDelegate> aDelegate;

@end

NS_ASSUME_NONNULL_END
