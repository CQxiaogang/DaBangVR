//
//  DBLiveTableViewCell.h
//  DaBangVR
//
//  Created by mac on 2018/11/22.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingLiveTableViewCell : BaseTableViewCell
/** 直播封面 */
@property (weak, nonatomic) IBOutlet UIImageView *snapshotPlayImgView;
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headImgView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nickName;
/** 直播时候推荐的商品 */
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView1;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView2;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView3;

@property (nonatomic, strong) LiveModel *model;

@end

NS_ASSUME_NONNULL_END
