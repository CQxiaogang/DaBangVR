//
//  GoodsShowViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/15.
//  Copyright © 2019 DaBangVR. All rights reserved.
//
// Controllers
#import "GoodsShowViewController.h"
#import "GoodsDetailsViewController.h"
// Vendors
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"
#import "GoodsShowTableViewController.h"
// Models
#import "GoodsShowTitleModel.h"

@interface GoodsShowViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate,LoadDataListBaseViewControllerDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) NSMutableArray  *titles;
@property (nonatomic, strong) NSMutableArray  *IDs;
@end

@implementation GoodsShowViewController

- (NSMutableArray *)titles{
    if (!_titles) {
        _titles = [NSMutableArray new];
    }
    return _titles;
}
// 系统回掉
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NetWorkHelper POST:URL_getGoodsCategoryList parameters:@{@"parentId":@"1036096",@"token":kToken} success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic= dic[@"data"];
        NSArray *goodsList = dataDic[@"goodsCategoryList"];
        for (NSDictionary *dic in goodsList) {
            GoodsShowTitleModel *model = [GoodsShowTitleModel modelWithDictionary:dic];
            [self.titles addObject:model];
        }
        // 得到数据在设置 UI
        [self setupChildUI];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void) setupChildUI{
    
    NSMutableArray *names = [NSMutableArray new];
    _IDs = [NSMutableArray new];
    for (GoodsShowTitleModel *model in self.titles) {
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
    GoodsShowTableViewController *listVC = [[GoodsShowTableViewController alloc] init];
    listVC.delegate = self;
    listVC.index = _IDs[index];
    return listVC;
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

#pragma mark —— LoadDataListBaseViewController 协议
// cell 的点击
- (void)didSelectGoodsShowDetails:(NSString *)index{
    
    GoodsDetailsViewController *vc = [[GoodsDetailsViewController alloc] init];
    vc.identifier = @"海鲜";
    vc.index = index;
    [self.navigationController pushViewController:vc animated:NO];
    
}



@end
