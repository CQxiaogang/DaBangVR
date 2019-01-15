//
//  GoodsShowViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/15.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "GoodsShowViewController.h"
// 第三方
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"
#import "LoadDataListContainerListViewController.h"
// Models
#import "SeafoodShowTitleModel.h"

@interface GoodsShowViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) NSMutableArray  *titles;
@property (nonatomic, strong) NSMutableArray  *IDs;
@end

@implementation GoodsShowViewController

- (void)getRandomTitles {
    self.titles = [NSMutableArray new];
    [NetWorkHelper POST:URL_goods_title parameters:nil success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic= dic[@"data"];
        NSArray *goodsList = dataDic[@"goodsCategoryList"];
        for (NSDictionary *dic in goodsList) {
            SeafoodShowTitleModel *model = [SeafoodShowTitleModel modelWithDictionary:dic];
            [self.titles addObject:model];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (NSMutableArray *)titles{
    if (!_titles) {
        _titles = [NSMutableArray new];
    }
    return _titles;
}
// 系统回掉
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NetWorkHelper POST:URL_goods_title parameters:nil success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic= dic[@"data"];
        NSArray *goodsList = dataDic[@"goodsCategoryList"];
        for (NSDictionary *dic in goodsList) {
            SeafoodShowTitleModel *model = [SeafoodShowTitleModel modelWithDictionary:dic];
            [self.titles addObject:model];
        }
        //得到数据在设置ui
        [self setupChildUI];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void) setupChildUI{
    
    NSMutableArray *names = [NSMutableArray new];
    _IDs = [NSMutableArray new];
    for (SeafoodShowTitleModel *model in self.titles) {
        [names addObject:model.name];
        [_IDs addObject:model.id];
    }
    
    CGFloat categoryViewHeight = 50;
    CGFloat width = KScreenW;
    CGFloat height = KScreenH - kNavBarHeight -categoryViewHeight;
    
    self.categoryView = [[JXCategoryTitleView alloc] init];
    self.categoryView.frame = CGRectMake(0, kTopHeight, KScreenW, categoryViewHeight);
    self.categoryView.delegate = self;
    self.categoryView.titles = names;
    self.categoryView.defaultSelectedIndex = 0;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithParentVC:self delegate:self];
    self.listContainerView.frame = CGRectMake(0, categoryViewHeight+kTopHeight, width, height);
    self.listContainerView.defaultSelectedIndex = 0;
    [self.view addSubview:self.listContainerView];
    self.listContainerView.backgroundColor = KRandomColor;
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
    LoadDataListContainerListViewController *listVC = [[LoadDataListContainerListViewController alloc] init];
    listVC.ID = _IDs[index];
    return listVC;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}




@end
