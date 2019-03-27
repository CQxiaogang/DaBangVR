//
//  DBLiveViewController.m
//  DaBangVR
//
//  Created by mac on 2018/11/17.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "LiveViewController.h"
// Vendors
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"
// View
#import "LiveCollectionView.h"
#import "LiveTableView.h"

static NSString *cellID = @"cellID";

@interface LiveViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

/** 标题 */
@property (nonatomic, copy) NSArray <NSString *>*titles;
/** 第三方 */
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@end

@implementation LiveViewController

#pragma mark 懒加载

#pragma mark 系统回调方法
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏navigationBar
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)setupUI{
    [super setupUI];
    
    _titles = @[@"购物",@"娱乐"];
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, KScreenW, kNavBarHeight)];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor lightGreen];
    self.categoryView.delegate = self;
    self.categoryView.defaultSelectedIndex = 0;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc]initWithDelegate:self];
    self.listContainerView.frame = CGRectMake(0, kTopHeight, KScreenW, KScreenH-kTopHeight);
    self.listContainerView.defaultSelectedIndex = 0;
    [self.view addSubview:self.listContainerView];
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
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
    if (index == 0) {
        LiveCollectionView *collectionView = [[LiveCollectionView alloc] init];
        return collectionView;
    }else{
        LiveTableView *tableView = [[LiveTableView alloc] init];
        return tableView;
    }
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

@end

