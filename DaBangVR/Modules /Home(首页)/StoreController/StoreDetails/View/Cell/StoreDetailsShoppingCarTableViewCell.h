//
//  StoreDetailsShoppingCarTableViewCell.h
//  DaBangVR
//
//  Created by mac on 2019/6/4.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreDetailsShoppingCarModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StoreDetailsShoppingCarTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsSpecificationsLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;

@property (nonatomic, strong) StoreDetailsShoppingCarModel *model;

@end

NS_ASSUME_NONNULL_END
