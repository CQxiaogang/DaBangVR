//
//  MineCollectionViewController.m
//  DaBangVR
//
//  Created by mac on 2019/2/12.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "MineCollectionViewController.h"
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"

@interface MineCollectionViewController ()

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) NSArray <NSString *> *titles;

@end

@implementation MineCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏";
    _titles = @[@"全部", @"降价中", @"低库存", @"已失效"];
    
    self.categoryView = [[JXCategoryTitleView alloc] init];
    self.categoryView.frame = CGRectMake(0, kTopHeight, KScreenW, 40);
    self.categoryView.delegate = self;
    self.categoryView.titles = _titles;
    self.categoryView.titleSelectedColor = [UIColor lightGreen];
    self.categoryView.titleColor = KGrayColor;
    self.categoryView.defaultSelectedIndex = 0;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = [UIColor lightGreen];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
}

@end
