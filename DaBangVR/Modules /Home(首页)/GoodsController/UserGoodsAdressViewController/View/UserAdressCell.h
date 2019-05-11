//
//  informationModificationCell.h
//  DaBangVR
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoChangeModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol UserAdressCellDelegate <NSObject>

/**
 默认地址选择
 */
- (void)defaultAdressSelect;

/**
 修改地址
 */
- (void)changeAdressClick:(UIButton *)button;

/**
 删除地址
 */
- (void)deleteAdress;

@end

@interface UserAdressCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userPhoneNum;
@property (weak, nonatomic) IBOutlet UILabel *adress;
@property (weak, nonatomic) IBOutlet UIButton *defaultAdress;
@property (weak, nonatomic) IBOutlet UIButton *changeAdress;
@property (weak, nonatomic) IBOutlet UIButton *deleteAdress;

@property (nonatomic, strong) UserInfoChangeModel *model;

@property (nonatomic, weak) id <UserAdressCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
