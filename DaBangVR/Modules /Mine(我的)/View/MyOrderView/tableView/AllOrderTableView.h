//
//  AllOrderTableView.h
//  DaBangVR
//
//  Created by mac on 2019/1/9.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol allOrderTableViewDelegate <NSObject>
// 所以订单中右下角 button
- (void) allOrderTableViewButtonOfAction:(NSString *)string;
// cell 点击事件
- (void) didSelectRowAtIndexPath;

@end
@interface AllOrderTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) id<allOrderTableViewDelegate> allDelegate;

@end

NS_ASSUME_NONNULL_END
