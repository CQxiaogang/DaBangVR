//
//  informationModificationHeaderView.h
//  DaBangVR
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol informationModificationHeaderDelegate <NSObject>

- (void) addNewAddress;

@end

@interface informationModificationHeaderView : UIView

@property (nonatomic, weak) id<informationModificationHeaderDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
