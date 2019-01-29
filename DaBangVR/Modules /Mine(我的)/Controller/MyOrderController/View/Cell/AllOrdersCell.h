//
//  AllOrdersCell.h
//  DaBangVR
//
//  Created by mac on 2019/1/9.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol allOrdersCellDelegate <NSObject>

- (void)lowerRightCornerClickEvent:(NSString *)string;

@end

@interface AllOrdersCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet YYAnimatedImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLab;
@property (weak, nonatomic) IBOutlet UILabel *stateLab;
@property (weak, nonatomic) IBOutlet UILabel *sizeLab;
@property (weak, nonatomic) IBOutlet UILabel *colorLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
// 右下角 button
@property (weak, nonatomic) IBOutlet UIButton *lowerRightCornerBtn;

@property (nonatomic, strong) id<allOrdersCellDelegate> delegate;

@property (nonatomic, strong) MyOrderModel *model;

@end

NS_ASSUME_NONNULL_END
