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

typedef void(^btnPulsBlock)(NSDictionary *goodsInfo, BOOL animated);
typedef void(^btnMinusBlock)(NSDictionary *goodsInfo, BOOL animated);

@protocol StoreDetailsRightTableViewCellDelegate <NSObject>

-(void)specificationButtonClick:(UIButton *)button;

@end

@interface StoreDetailsRightTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *salesLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *plusButton;
@property (weak, nonatomic) IBOutlet UIButton *minusButton;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (nonatomic, strong) DeptDetailsGoodsModel *model;
@property (nonatomic, weak) id <StoreDetailsRightTableViewCellDelegate> delegate;

@property (nonatomic, copy) btnPulsBlock  plusBlock;
@property (nonatomic, copy) btnMinusBlock minusBlock;
//@property (nonatomic, assign) NSInteger numCount;//计数器

@end
