//
//  ChannelMenuListView.m
//  DaBangVR
//
//  Created by mac on 2019/1/10.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "ChannelMenuListView.h"
#import "ChannelView.h"

@interface ChannelMenuListView ()

@property (nonatomic, strong) ChannelView *channelView;

@end

@implementation ChannelMenuListView
#pragma mark —— 懒加载

#pragma mark —— 系统方法
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    NSArray *imageArr = @[@"h_video",@"h_seafood",@"h_Assemble",@"h_Spike",@"h_Bigbang",@"h_Global",@"h_New",@"h_store",@"h_Search_moreF",@"h_Community"];
    NSArray *titleArr = @[@"视屏",@"海鲜",@"拼图",@"限时秒杀",@"大邦",@"全球购",@"新品首发",@"门店",@"分类搜索",@"社区",];
    
    for (int i=0; i<2; i++) {
        for (int j = 0; j<=4; j++) {
            _channelView = [[[NSBundle mainBundle] loadNibNamed:@"ChannelView" owner:nil options:nil] firstObject];
            CGFloat wide = Adapt(self.channelView.mj_w);
            CGFloat high = Adapt(self.channelView.mj_h);
            CGFloat margin  = (self.mj_w - (wide*5))/6;
            CGFloat x = j * (wide+margin)+ margin;
            CGFloat y = i * high;
            _channelView.frame = CGRectMake(x, y, wide, high);
            _channelView.channelBtn.tag = i*5 + j;
            if (i==0) {
                _channelView.channelTitle.text = titleArr[j];
                [_channelView.channelBtn setBackgroundImage:[UIImage imageNamed:imageArr[j]] forState:UIControlStateNormal];
            }else{
                _channelView.channelTitle.text = titleArr[j + 5];
                [_channelView.channelBtn setBackgroundImage:[UIImage imageNamed:imageArr[j + 5]] forState:UIControlStateNormal];
            }
            [self addSubview:_channelView];
        }
    }
}
@end
