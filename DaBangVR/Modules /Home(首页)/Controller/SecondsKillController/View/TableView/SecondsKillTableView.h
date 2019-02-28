//
//  SecondsKillTableView.h
//  DaBangVR
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecondsKillTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy)NSArray *goodsData;

@end

NS_ASSUME_NONNULL_END
