//
//  DBMyViewController.h
//  DaBangVR
//
//  Created by mac on 2018/11/17.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSDictionary *dic;

@end

NS_ASSUME_NONNULL_END
