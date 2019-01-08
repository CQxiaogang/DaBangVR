//
//  modifyAddressViewCell.h
//  DaBangVR
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "modifyAddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface modifyAddressViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentText;

@property (nonatomic, strong) modifyAddressModel *infoModel;

@end

NS_ASSUME_NONNULL_END
