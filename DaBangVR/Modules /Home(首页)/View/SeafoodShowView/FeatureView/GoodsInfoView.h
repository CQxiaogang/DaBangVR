//
//  GoodsInfoView.h
//  DaBangVR
//
//  Created by mac on 2018/12/26.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@protocol goodsInfoViewDeletage <NSObject>

-(void)chooseBabyAction;
-(void)allCommentsAction;

@end

@interface GoodsInfoView : UIView
// 商品详情
@property (weak, nonatomic) IBOutlet UILabel *introduce;
// 促销价
@property (weak, nonatomic) IBOutlet UILabel *promotionPrice;
// 选择商品规格
@property (weak, nonatomic) IBOutlet UIButton *chooseBaby;
// 商品评论
@property (weak, nonatomic) IBOutlet UILabel *comments;
// 参看全部评论
@property (weak, nonatomic) IBOutlet UIButton *allComments;
// 一条评论
@property (weak, nonatomic) IBOutlet UILabel *aComments;
// 评论标签
@property (weak, nonatomic) IBOutlet UILabel *oneTag;
@property (weak, nonatomic) IBOutlet UILabel *twoTag;
@property (weak, nonatomic) IBOutlet UILabel *threeTag;
// 用户头像
@property (weak, nonatomic) IBOutlet UIImageView *userImgView;
// 用户名字
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) id<goodsInfoViewDeletage>delegate;
/* 通知 */
@property (weak, nonatomic) id dcObj;

- (void)setUpGoodsFeature:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
