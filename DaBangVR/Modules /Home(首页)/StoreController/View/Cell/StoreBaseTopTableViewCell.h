//
//  StoreBaseTopTableViewCell.h
//  DaBangVR
//
//  Created by mac on 2019/5/27.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShufflingView.h"
#import "CategoryChooseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoreBaseTopTableViewCell : UITableViewCell

@property (nonatomic, strong) ShufflingView *shufflingView;
@property (nonatomic, strong) UILabel *recommendLabel;
@property (nonatomic, strong) CategoryChooseView *categoryChooseView;

@end

NS_ASSUME_NONNULL_END
