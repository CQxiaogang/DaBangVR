//
//  MainViewController.h
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RootViewController : UIViewController

@property (nonatomic, strong) UITableView *tableView;

- (void)setupUI;

@end

NS_ASSUME_NONNULL_END
