//
//  DBtableViewCell.h
//  DaBangVR
//
//  Created by mac on 2018/12/4.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MineTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleImageV;  // 标题图片
@property (weak, nonatomic) IBOutlet UILabel     *titleLabel;   // 标题
@property (weak, nonatomic) IBOutlet UILabel     *contentLabel; // 内容
@property (weak, nonatomic) IBOutlet UIImageView *otherImageV;  // 内容右边的图片

@end

NS_ASSUME_NONNULL_END
