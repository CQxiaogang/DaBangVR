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

@property (nonatomic, strong) NSMutableArray *imageStrArray;

@end

@implementation ChannelMenuListView
#pragma mark —— 懒加载
-(NSMutableArray *)imageStrArray{
    if (!_imageStrArray) {
        _imageStrArray = [NSMutableArray new];
    }
    return _imageStrArray;
}
#pragma mark —— 系统方法
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}
- (void)setupUI{
    NSArray *imageArr = (NSArray *)self.imageStrArray;
    
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
            // 添加点击事件
            [_channelView.channelBtn addTarget:self action:@selector(channelBtnOfClick:) forControlEvents:UIControlEventTouchUpInside];
            // 图片和文字的设置
            if (i==0) {
                _channelView.channelTitle.text = titleArr[j];
                if (imageArr.count != 0) {
                    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageArr[j]]];
                    [_channelView.channelBtn setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
                }
                
                
            }else{
                _channelView.channelTitle.text = titleArr[j + 5];
                if (imageArr.count != 0) {
                    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageArr[j + 5]]];
                    [_channelView.channelBtn setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
                }
            }
            [self addSubview:_channelView];
        }
    }
}

- (void)channelBtnOfClick:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(channelBtnOfClick:)]) {
        [self.delegate channelBtnOfClick:sender];
    }
}

- (void)setChanelArray:(NSArray *)chanelArray{
    for (ChannelModel *model in chanelArray) {
        NSString *string = model.iconUrl;
        [self.imageStrArray addObject:string];
    }
    
    [self setupUI];
}

@end
