//
//  DidBeginLiveTopView.h
//  DaBangVR
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DidBeginLiveTopViewDelegate <NSObject>

-(void)dismissAction;

@end

@interface DidBeginLiveTopView : UIView
@property (nonatomic, weak) id<DidBeginLiveTopViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
