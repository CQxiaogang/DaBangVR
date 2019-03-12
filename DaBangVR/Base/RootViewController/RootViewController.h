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
/* 微信订单支付统一入口
* orderTotalSn和orderSn只能二选一
* 1：立即购买=》直接支付     使用orderTotalSn
* 2：立即购买=》取消=》重新付款     使用orderTotalSn
* 3：立即购买=》取消=》查看订单=》订单详情=》去付款    使用orderSn
* 4：购物车=》去付款    使用orderTotalSn
* 5：购物车=》去付款=》取消=》重新付款    使用orderSn
* 6：购物车=》去付款=》取消=》查看订单=》订单详情=》去付款    使用orderSn*/
@property (nonatomic, copy) NSString *orderSnTotal;
@end

NS_ASSUME_NONNULL_END
