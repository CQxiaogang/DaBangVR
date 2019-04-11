//
//  MerchantsSettledViewController.m
//  DaBangVR
//
//  Created by mac on 2019/4/10.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "MerchantsSettledViewController.h"
// Vendors
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"
#import "MerchantsSettledViewController2.h"

@interface MerchantsSettledViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@end

@implementation MerchantsSettledViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商家入驻";
}

-(void)setupUI{
    [super setupUI];
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.backgroundColor = KRedColor;
    [self.view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(kTopHeight);
        make.height.equalTo(150);
    }];
    
    self.categoryView = [[JXCategoryTitleView alloc] init];
    self.categoryView.delegate = self;
    self.categoryView.titles = @[@"平台介绍",@"开店流程",@"开店要就",@"资费查询"];
    self.categoryView.backgroundColor = KBlackColor;
    self.categoryView.titleColor = KWhiteColor;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
    [self.categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(imgView.mas_bottom).offset(0);
        make.height.equalTo(50);
    }];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithDelegate:self];
    [self.view addSubview:self.listContainerView];
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(self.categoryView.mas_bottom).offset(0);
    }];
}
#pragma mark —— JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}

#pragma mark —— JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    MerchantsSettledViewController2 *listVC = [[MerchantsSettledViewController2 alloc] init];
    return listVC;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return 4;
}
@end
