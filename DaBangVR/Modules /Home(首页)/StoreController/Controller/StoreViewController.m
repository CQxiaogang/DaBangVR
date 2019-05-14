//
//  StoreViewController.m
//  DaBangVR
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "StoreViewController.h"
#import "ShufflingView.h"
#import "CategoryChooseView.h"

@interface StoreViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ShufflingView *shufflingView;
@property (nonatomic, strong) CategoryChooseView *categoryChooseView;

@end

@implementation StoreViewController
#pragma mark —— 懒加载
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.backgroundColor = KRedColor;
        [_scrollView addSubview:self.shufflingView];
        [_scrollView addSubview:self.categoryChooseView];
    }
    return _scrollView;
}

-(ShufflingView *)shufflingView{
    if (!_shufflingView) {
        _shufflingView = [[ShufflingView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 180) andIndex:@"1"];
    }
    return _shufflingView;
}

-(CategoryChooseView *)categoryChooseView{
    if (!_categoryChooseView) {
        _categoryChooseView = [[CategoryChooseView alloc] init];
    }
    return _categoryChooseView;
}

#pragma mark —— 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    kWeakSelf(self);
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kTopHeight);
        make.left.right.bottom.equalTo(0);
    }];
    
    [self.categoryChooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(weakself.shufflingView.mas_bottom).offset(0);
        make.size.equalTo(CGSizeMake(KScreenW, 100));
    }];
}

@end
