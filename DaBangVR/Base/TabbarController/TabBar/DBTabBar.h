//
//  DBTabBar.h
//  DaBangVR
//
//  Created by mac on 2018/11/17.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DBTabBar;
@protocol DBTabBarDelegate <NSObject>

@optional

- (void)tabBarDidClickPlusButton:(DBTabBar *)tabBar;

@end

@interface DBTabBar : UITabBar

//此处代理名字不能为delegate，因为会和UITabbar本身的delegate冲突
@property (nonatomic, weak) id<DBTabBarDelegate> myDelegate;

@end

NS_ASSUME_NONNULL_END
