//
//  MainViewController.h
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RootViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

- (void)setupUI;
- (void)loadingData;

@property (nonatomic, copy) NSString *identifier;
// 当前商品ID
@property (nonatomic, copy) NSString *index;
// 区分哪个界面进入。比如秒杀->seconds 商品->buy
@property (nonatomic, copy) NSString *submitType;
// 订单状态
@property (nonatomic, copy) NSString *orderSnTotal;
@end

NS_ASSUME_NONNULL_END
