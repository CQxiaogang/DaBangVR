//
//  modifyAddressViewCell.h
//  DaBangVR
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ModifyAddressViewCellDelegate <NSObject>

- (void)textFieldDidEndEditing:(UITextField *)textField;
- (void)textFieldDidBeginEditing:(UITextField *)textField;

@end

@interface modifyAddressViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentText;

@property (weak, nonatomic) id <ModifyAddressViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
