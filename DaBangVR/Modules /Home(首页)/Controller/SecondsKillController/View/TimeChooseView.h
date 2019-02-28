//
//  TimeChooseView.h
//  DaBangVR
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface TimeChooseView : UIView
// 限时秒杀
@property (weak, nonatomic) IBOutlet UILabel *seckillLab;
// 结束时间
@property (weak, nonatomic) IBOutlet UILabel *endTime;
// 即将开抢
@property (weak, nonatomic) IBOutlet UILabel *rushLab;
// 参看商品标签
@property (weak, nonatomic) IBOutlet UILabel *seeGoodsLab;



@end

NS_ASSUME_NONNULL_END
