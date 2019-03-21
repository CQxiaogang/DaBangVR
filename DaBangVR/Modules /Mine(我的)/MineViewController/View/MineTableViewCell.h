//
//  DBtableViewCell.h
//  DaBangVR
//
//  Created by mac on 2018/12/4.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;  // 标题图片
@property (weak, nonatomic) IBOutlet UILabel     *title;   // 标题
@property (weak, nonatomic) IBOutlet UILabel     *content; // 内容
@property (weak, nonatomic) IBOutlet UIImageView *otherImageV;  // 内容右边的图片

@property (nonatomic, strong) UserInfoModel *model;

@end

NS_ASSUME_NONNULL_END
