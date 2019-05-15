//
//  SecondsKillCell.m
//  DaBangVR
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "SecondsKillCell.h"
#import "SYLineProgressView.h"

@interface SecondsKillCell ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) SYLineProgressView *lineProgress;
@end

@implementation SecondsKillCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.lineProgress                    = [[SYLineProgressView alloc] initWithFrame:CGRectMake(0, 0, 99, 13)];
    self.lineProgress.lineColor          = KLightGreen;
    self.lineProgress.defaultColor       = RGBCOLOR(239, 239, 239);
    self.lineProgress.progressColor      = KLightGreen;
    self.lineProgress.label.textColor    = KWhiteColor;
    self.lineProgress.layer.cornerRadius = 7;
    self.lineProgress.label.hidden       = NO;
    [self addSubview:self.lineProgress];
    [self.lineProgress initializeProgress];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    kWeakSelf(self);
    [self.lineProgress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(99, 13));
        make.left.equalTo(weakself.goodsImgView.mas_right).offset(22);
        make.bottom.equalTo(weakself.goodsMarketPrice.mas_top).offset(-12);
    }];
    [_goodsMarketPrice sizeToFit];
    [_goodsSellingPrice sizeToFit];
}

- (void)setModel:(GoodsDetailsModel *)model{
    _model                     = model;
    _goodsDetails.text         = model.name;
    _goodsMarketPrice.text     = [NSString stringWithFormat:@"市场价:%@",model.marketPrice];
    _goodsSellingPrice.text    = [NSString stringWithFormat:@"￥:%@",model.sellingPrice];
    self.lineProgress.number   = model.remainingSecondsNumber;
    DLog(@"%f",[model.remainingSecondsNumber floatValue]/[model.secondsNumber floatValue]);
    self.lineProgress.progress = [model.remainingSecondsNumber floatValue]/[model.secondsNumber floatValue];
    [_goodsImgView setImageWithURL:[NSURL URLWithString:model.listUrl] placeholder:nil];
    
}

@end
