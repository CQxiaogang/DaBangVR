//
//  SecondsKillTableView.h
//  DaBangVR
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SecondsKillTableViewDelegate <NSObject>

-(void) curentGooodsID:(NSString *)ID;

@end

@interface SecondsKillTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) id<SecondsKillTableViewDelegate>aDelegate;

@property (nonatomic, copy) NSString *hoursTime;

@end

NS_ASSUME_NONNULL_END
