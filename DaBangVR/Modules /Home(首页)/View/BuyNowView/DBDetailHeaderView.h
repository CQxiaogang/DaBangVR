//
//  DBDetailHeaderView.h
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DBDetailHeaderViewDelegate <NSObject>

- (void)informationModification;

@end

@interface DBDetailHeaderView : UIView

@property (nonatomic, weak) id<DBDetailHeaderViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
