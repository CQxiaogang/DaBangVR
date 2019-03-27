//
//  DBTabBarViewController.h
//  DaBangVR
//
//  Created by mac on 2018/11/17.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MainTableViewDelegate <NSObject>

- (void)didClickButtonWithIndex:(NSInteger)index;

@end

@interface MainTabBarController : UITabBarController

@property(nonatomic, weak) id<MainTableViewDelegate>MDelegate;

@end

NS_ASSUME_NONNULL_END
