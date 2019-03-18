//
//  EvaluationCell.h
//  DaBangVR
//
//  Created by mac on 2019/1/9.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EvaluationCell : UITableViewCell
//商品图片
@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
//商品详情
@property (weak, nonatomic) IBOutlet UILabel *goodsDetails;
//商品数量
@property (weak, nonatomic) IBOutlet UILabel *goodsNum;
//商品价格
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
//商品邮费
@property (weak, nonatomic) IBOutlet UILabel *goodsPostage;
@property (weak, nonatomic) IBOutlet UITextView *evaluationTextView;

@property (nonatomic, strong) OrderGoodsModel *model;
// 回调textView信息
@property (nonatomic, copy) void (^textViewBlock)(NSString *text);

@end

NS_ASSUME_NONNULL_END
