//
//  PageView.m
//  DaBangVR
//
//  Created by mac on 2019/1/9.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "PageView.h"
#import "PageTitleView.h"
#import "PageContentView.h"

@interface PageView ()<PageTitleViewDelegate,pageContentViewDelegate>

@property (nonatomic, strong) PageTitleView *pageTitleView;
@property (nonatomic, strong) PageContentView *pageContentView;

@end
@implementation PageView
- (instancetype)initWithFrame:(CGRect)frame Titles:(NSArray *)titles ContentViews:(NSMutableArray *)views
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleArray = titles;
        self.contentViewArray = views;
        [self addSubview:self.pageTitleView];
        [self addSubview:self.pageContentView];
    }
    return self;
}

- (PageTitleView *)pageTitleView{
    if (!_pageTitleView) {
        _pageTitleView = [[PageTitleView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w, 40) Titles:self.titleArray];
        _pageTitleView.delagate = self;
    }
    return _pageTitleView;
}

- (PageContentView *)pageContentView{
    if (!_pageContentView) {
        _pageContentView = [[PageContentView alloc] initWithFrame:CGRectMake(0, _pageTitleView.mj_h, self.mj_w, self.mj_h-_pageTitleView.mj_h) childSv:self.contentViewArray];
        _pageContentView.delegate = self;
    }
    return _pageContentView;
}
#pragma mark —— pageTitleView deletage
- (void)pageTitleView:(UIView *)titleView selectedIndex:(int)index{
    [self.pageContentView setCurrentIndex:index];
    
    if ([self.delegate respondsToSelector:@selector(itemDidSelectedWithIndex:)]) {
        [self.delegate itemDidSelectedWithIndex:index];
    }
}

#pragma mark —— pageCotentViw deletage
- (void)pageContentView:(UIView *)contentView progress:(CGFloat)p sourceIndex:(int)s targetIndex:(int)t{
    [self.pageTitleView setTitleWithProgress:p sourceIndex:s targetIndex:t];
}

-(void)itemDidSelectedWithIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(itemDidSelectedWithIndex:)]) {
        [self.delegate itemDidSelectedWithIndex:index];
    }
}

@end
