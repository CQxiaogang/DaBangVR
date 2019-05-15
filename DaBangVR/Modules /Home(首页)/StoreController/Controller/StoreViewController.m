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
#import "StoreGoodsTableView.h"

@interface StoreViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ShufflingView *shufflingView;
@property (nonatomic, strong) CategoryChooseView *categoryChooseView;
@property (nonatomic, strong) UILabel *recommendLabel;
@property (nonatomic, strong) StoreGoodsTableView *goodsTableView;

@end

@implementation StoreViewController
#pragma mark —— 懒加载
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView                 = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//        _scrollView.backgroundColor = KRedColor;
        [_scrollView addSubview:self.shufflingView];
        [_scrollView addSubview:self.categoryChooseView];
        [_scrollView addSubview:self.recommendLabel];
        
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

-(UILabel *)recommendLabel{
    if (!_recommendLabel) {
        _recommendLabel                  = [UILabel new];
        _recommendLabel.text             = @"——— 推荐商家 ———";
        _recommendLabel.textColor        = KGrayColor;
        _recommendLabel.textAlignment    = NSTextAlignmentCenter;
        _recommendLabel.adaptiveFontSize = 12;
    }
    return _recommendLabel;
}

-(StoreGoodsTableView *)goodsTableView{
    if (!_goodsTableView) {
        _goodsTableView = [[StoreGoodsTableView alloc] init];
        _goodsTableView.backgroundColor = KRedColor;
        
    }
    return _goodsTableView;
}

#pragma mark —— 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    self.goodsTableView.data = 10;
    [self.scrollView addSubview:self.goodsTableView];
    [self.goodsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(self.recommendLabel.mas_bottom).offset(10);
    }];
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
    
    [self.recommendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(KScreenW, 20));
        make.centerX.equalTo(weakself.view.mas_centerX);
        make.top.equalTo(weakself.categoryChooseView.mas_bottom).offset(10);
    }];
    
    
}

@end
