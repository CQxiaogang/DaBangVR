//
//  timeLimitSecondsKill.m
//  DaBangVR
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "HomeSecondsKillView.h"
/* 动画倒计时 */
#import "HSFTimeDownView.h"
#import "HSFTimeDownConfig.h"

@interface HomeSecondsKillView ()

@property (nonatomic, strong) HSFTimeDownView *timeLabel_hsf;

@end

@implementation HomeSecondsKillView
// 抢购btn点击事件
- (IBAction)rushGoodsBtn:(id)sender {
    
}

-(void)awakeFromNib{
    [super awakeFromNib];
    //动画倒计时
    HSFTimeDownConfig *config = [[HSFTimeDownConfig alloc]init];
    HSFTimeDownView *timeLabel_hsf = [[HSFTimeDownView alloc] initWityFrame:CGRectMake(0, 0, 150, 15) config:config timeChange:^(NSInteger time) {
        
    } timeEnd:^{}];
    _timeLabel_hsf  = timeLabel_hsf;
    [self addSubview:_timeLabel_hsf];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_timeLabel_hsf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.goodsImgView.mas_centerX);
        make.centerY.equalTo(self.goodsImgView.mas_centerY);
        make.size.equalTo(CGSizeMake(150, 15));
    }];
}

- (void)setModel:(GoodsDetailsModel *)model{
    _model = model;
    [_goodsImgView setImageWithURL:[NSURL URLWithString:model.listUrl] placeholder:kDefaultImg];
    _goodsPrice.text = [NSString stringWithFormat:@"￥ %@",model.sellingPrice];
    
    /**** 倒计时 ****/
    NSString *endTime = self.model.secondsEndTime;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endDate = [dateFormatter dateFromString:[self timeWithTimeIntervalString:endTime]]; //结束时间
    NSDate *endDate_tomorrow = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([endDate timeIntervalSinceReferenceDate])];
    NSDate *startDate = [NSDate date];
    NSTimeInterval timeInterval =[endDate_tomorrow timeIntervalSinceDate:startDate];
    
    [_timeLabel_hsf setcurentTime:timeInterval];
}

// 时间戳转换为日期格式(毫秒的时间戳)
- (NSString *)timeWithTimeIntervalString:(NSString *)timeString{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

@end
