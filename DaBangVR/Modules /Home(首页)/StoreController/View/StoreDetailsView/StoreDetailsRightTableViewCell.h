//
//  RightTableViewCell.h
//  Linkage
//
//  Created by LeeJay on 16/8/22.
//  Copyright © 2016年 LeeJay. All rights reserved.
//  代码下载地址https://github.com/leejayID/Linkage

#import <UIKit/UIKit.h>
#import "DeptDetailsGoodsModel.h"

#define kCellIdentifier_Right @"RightTableViewCell"

@interface StoreDetailsRightTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) DeptDetailsGoodsModel *model;

@end
