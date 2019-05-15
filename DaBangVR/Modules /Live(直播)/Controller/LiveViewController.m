//
//  DBLiveViewController.m
//  DaBangVR
//
//  Created by mac on 2018/11/17.
//  Copyright © 2018 DaBangVR. All rights reserved.
//
/** Controllers */
#import "LiveViewController.h"
#import "RecreationLiveCollectionViewController.h"
#import "ShoppingLiveTableViewController.h"
/** Vendors */
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"
#import "JXCategoryTitleView.h"
/** View */
#import "LiveCollectionView.h"
#import "LiveTableView.h"
/** Models */
#import "LiveModel.h"
/** 放直播 */
#import "PLPlayViewController.h"
static NSString *cellID = @"cellID";

@interface LiveViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate , RecreationLiveCollectionViewControllerDelegate, ShoppingLiveTableViewControllerDelegate>

/** 标题 */
@property (nonatomic, copy) NSArray <NSString *>*titles;
/** 第三方 */
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
/** 娱乐数据源 */
@property (nonatomic, copy) NSArray *recreationLiveData;
/** 购物数据源 */
@property (nonatomic, copy) NSArray *shoppngLiveData;
/** 娱乐View */
@property (nonatomic, strong) LiveCollectionView *collectionView;
@end

@implementation LiveViewController

#pragma mark 懒加载

- (LiveCollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[LiveCollectionView alloc] initWithFrame:self.view.frame itemCount:_recreationLiveData];
        _collectionView.MDelegate = self;
    }
    return _collectionView;
}

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
    
    self.titles = @[@"娱乐",@"购物"];
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, KScreenW, kNavBarHeight)];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor lightGreen];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = KWhiteColor;
    self.categoryView.defaultSelectedIndex = 0;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = KLightGreen;
    self.categoryView.indicators = @[lineView];
    [self.view addSubview:self.categoryView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc]initWithDelegate:self];
    self.listContainerView.frame = CGRectMake(0, kTopHeight, KScreenW, KScreenH-kTopHeight);
    self.listContainerView.defaultSelectedIndex = 0;
    [self.view addSubview:self.listContainerView];
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
    
//    kWeakSelf(self);
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_enter(group);
//    [NetWorkHelper POST:URl_getLiveStreamsList parameters:nil success:^(id  _Nonnull responseObject) {
//        NSDictionary *dic = KJSONSerialization(responseObject)[@"data"];
//        weakself.recreationLiveData = [LiveModel mj_objectArrayWithKeyValuesArray:dic[@"playList"]];
//        dispatch_group_leave(group);
//    } failure:nil];
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        weakself.titles = @[@"娱乐",@"购物"];
//        weakself.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, KScreenW, kNavBarHeight)];
//        self.categoryView.titles = self.titles;
//        self.categoryView.backgroundColor = [UIColor lightGreen];
//        self.categoryView.delegate = self;
//        self.categoryView.defaultSelectedIndex = 0;
//        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
//        self.categoryView.indicators = @[lineView];
//        [self.view addSubview:self.categoryView];
//
//        self.listContainerView = [[JXCategoryListContainerView alloc]initWithDelegate:self];
//        self.listContainerView.frame = CGRectMake(0, kTopHeight, KScreenW, KScreenH-kTopHeight);
//        self.listContainerView.defaultSelectedIndex = 0;
//        [self.view addSubview:self.listContainerView];
//        self.categoryView.contentScrollView = self.listContainerView.scrollView;
//    });
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
        RecreationLiveCollectionViewController *vc = [[RecreationLiveCollectionViewController alloc] init];
        vc.MDelegate = self;
        return vc;
        
    }else{
        ShoppingLiveTableViewController *vc = [[ShoppingLiveTableViewController alloc] init];
        vc.MDelegate = self;
        return vc;
    }
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

#pragma mark —— RecreationLiveCollectionViewControllerDelegate
-(void)collectionViewSelectItemAtIndexPathForModel:(LiveModel *)model{
    PLPlayViewController *playController = [[PLPlayViewController alloc] init];
    playController.url = [NSURL URLWithString:model.hdlPlayURL];
    playController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:playController animated:NO];
}

#pragma mark —— ShoppingLiveTableViewControllerDelegate
-(void)tableViewDidSelectRowAtIndexPathForModel:(LiveModel *)model{
    PLPlayViewController *playController = [[PLPlayViewController alloc] init];
    playController.url = [NSURL URLWithString:model.hdlPlayURL];
    playController.anchorId = model.anchorId;
    playController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:playController animated:YES];
}

@end

