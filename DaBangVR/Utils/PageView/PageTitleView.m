//
//  TitleView.m
//  Demo
//
//  Created by mac on 2018/11/26.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "PageTitleView.h"
#import "UIColor+category.h"
#import "UIView+MJExtension.h"

@interface PageTitleView()
{
    int currentIndex;
}

@property (nonatomic, strong) UIView  *contentView;

@property (nonatomic, strong) UIView  *bottomLine;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) NSMutableArray *titleLabels;

@end

@implementation PageTitleView

-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
//        _contentView.backgroundColor = KRedColor;
    }
    return _contentView;
}

-(NSMutableArray *)titleLabels{
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray new];
    }
    return _titleLabels;
}

- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray *)titleArr
{
    self = [super initWithFrame:frame];
    if (self) {
        if (titleArr.count ==0) {
            return self;
        }
        self.titlesArr = titleArr;
        currentIndex = 0;
//        self.backgroundColor = KRedColor;
        // 1.设置ui界面
        [self setup_titleLabels];
        [self setup_bottonLine];
    }
    return self;
}

- (void)setup_titleLabels{
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(0);
    }];
    
    for (int i = 0; i<self.titlesArr.count; i++) {
        // 1.设置label
        _titleLabel = [[UILabel alloc] init];
        // 2.设置lable属性
        _titleLabel.text = self.titlesArr[i];
        _titleLabel.tag = i;
        _titleLabel.textAlignment =  NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
//        _titleLabel.backgroundColor = [UIColor redColor];
        
        // 设置字体大小
        _titleLabel.adaptiveFontSize = 14;
        // 根据内容显示label的大小
        [_titleLabel sizeToFit];
        // 改变label的位置
//        _titleLabel.mj_x = _titleLabel.mj_w*i;
//        _titleLabel.mj_y = self.mj_h/4;
//        _titleLabel.backgroundColor = KGrayColor;
        // 添加手势
        _titleLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabel:)];
        [_titleLabel addGestureRecognizer:tap];
        [self.titleLabels addObject:_titleLabel];
        [self.contentView addSubview:_titleLabel];
    }
    CGFloat spacing = self.contentView.mj_w/self.titlesArr.count;
    [self.titleLabels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:spacing leadSpacing:10 tailSpacing:10];
    kWeakSelf(self);
    [self.titleLabels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.mj_h/4);
    }];
}

- (void) setup_bottonLine{
    UILabel *fristLael = self.titleLabels[0];
    self.bottomLine = [[UIView alloc] init];
    fristLael.textColor = [UIColor orangeColor];
    self.bottomLine.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.bottomLine];
    __weak typeof(self) weakSelf = self;
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.titleLabel);
        make.height.equalTo(2);
        make.bottom.equalTo(0);
        make.centerX.equalTo(weakSelf.titleLabels[0]);
    }];
}

- (void)tapLabel:(UITapGestureRecognizer *)tap{
    // 1.获取当前lable
    UILabel *currentLabel = (UILabel *)tap.view;
    // 2.获取之前的label
    UILabel *oldLabel = self.titleLabels[currentIndex];
    // 解决重复点击所带来的bug
    if (currentLabel.tag != oldLabel.tag) {
        // 3.切换文字颜色
        currentLabel.textColor = [UIColor orangeColor];
        // 4.保持最新label的下表
        currentIndex = (float)currentLabel.tag;
        oldLabel.textColor = [UIColor blackColor];
        // 5.滚动条滚动的位置
        CGFloat scrollLinx = currentLabel.tag * self.bottomLine.mj_w;
        // 动画
        [UIView animateWithDuration:0.15 animations:^{
            CGRect temp = self.bottomLine.frame;
            temp.origin.x = scrollLinx;
            self.bottomLine.frame = temp;
        }];
        [self.delagate pageTitleView:self selectedIndex:currentIndex];
    }
}

-(void)setTitleWithProgress:(CGFloat)progress sourceIndex:(int)sourceIndex targetIndex:(int)targetIndex{
    // 1.取出sourceLabel/targetLabel
    UILabel *sourceLabel = _titleLabels[sourceIndex];
    UILabel *targetLabel = _titleLabels[targetIndex];
    // 2.处理滑块的逻辑
    CGFloat moveTotalX =targetLabel.mj_x - sourceLabel.mj_x;
    CGFloat moveX = moveTotalX * progress;
    CGRect temp  = self.bottomLine.frame;
    temp = CGRectMake(sourceLabel.mj_x + moveX, self.bottomLine.mj_y, self.bottomLine.mj_w, self.bottomLine.mj_h);
    self.bottomLine.frame = temp;
    sourceLabel.textColor = [UIColor blackColor];
    targetLabel.textColor = [UIColor orangeColor];
}

@end
