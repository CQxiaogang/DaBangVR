//
//  GlobalShoppingViewController.m
//  DaBangVR
//
//  Created by mac on 2019/2/25.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "GlobalShoppingViewController.h"
// Views;
#import "ShufflingView.h"
#import "HorizontalCollectionView.h"
// 宏
#define margin kFit(10)
@interface GlobalShoppingViewController ()

@property (nonatomic, strong) ShufflingView *shufflingView;
@property (nonatomic, strong) HorizontalCollectionView *CountryCollectionView;
@property (nonatomic, strong) HorizontalCollectionView *GoodsCollectionView;
@property (nonatomic, strong) HorizontalCollectionView *RecommendGoodsCollectionView;
@property (nonatomic, strong) UIView *collectionHeaderView;
@end

@implementation GlobalShoppingViewController
static NSString *CellID = @"CellID";
static NSString *HeaerCollectionViewCellID = @"HeaerCollectionViewCellID";
#pragma mark —— 懒加载
-(HorizontalCollectionView *)CountryCollectionView{
    if (!_CountryCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置UICollectionView为横向滚动
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 每一行cell之间的间距
        layout.minimumLineSpacing = margin;
        // 设置第一个cell和最后一个cell,与父控件之间的间距
        layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        layout.itemSize = CGSizeMake(kFit(70), kFit(90));
        _CountryCollectionView = [[HorizontalCollectionView alloc] initWithFrame:CGRectMake(0, margin, KScreenW, kFit(90)) collectionViewLayout:layout nibWithNibName:@"CountryCollectionViewCell"];
        // 解决tableview 和 collectionview 手势冲突问题
        /*意思是：如果手势A失败，手势B才起作用 eg:先让tableView滚在让scrollView滚*/
        [self.tableView.panGestureRecognizer requireGestureRecognizerToFail:_CountryCollectionView.panGestureRecognizer];
    }
    return _CountryCollectionView;
}

-(HorizontalCollectionView *)GoodsCollectionView{
    if (!_GoodsCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置UICollectionView为横向滚动
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 每一行cell之间的间距
        layout.minimumLineSpacing = kFit(10);
        // 设置第一个cell和最后一个cell,与父控件之间的间距
        layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        layout.itemSize = CGSizeMake(kFit(173), kFit(90));
        _GoodsCollectionView = [[HorizontalCollectionView alloc] initWithFrame:CGRectMake(0, margin, KScreenW, kFit(90)) collectionViewLayout:layout nibWithNibName:@"CountryGoodsCollectionViewCell"];
    }
    return _GoodsCollectionView;
}

-(HorizontalCollectionView *)RecommendGoodsCollectionView{
    if (!_RecommendGoodsCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(kFit(172), kFit(234));
        layout.minimumInteritemSpacing = margin;
        layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin);
        _RecommendGoodsCollectionView = [[HorizontalCollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH) collectionViewLayout:layout nibWithNibName:@"RecommendGoodsCollectionViewCell"];
        // 禁止滑动
        _RecommendGoodsCollectionView.scrollEnabled = NO;
    }
    return _RecommendGoodsCollectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)setupUI{
    [super setupUI];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(0);
    }];
    // 设置顶部的搜索框
    [self setupNavagationBar];
    // 轮播
    _shufflingView = [[ShufflingView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, kFit(180)) andIndex:@"5"];
    self.tableView.tableHeaderView = _shufflingView;
}

-(void)setupNavagationBar{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kFit(260), kFit(30))];
    view.layer.cornerRadius = view.mj_h/2;
    view.backgroundColor = KWhiteColor;
    self.navigationItem.titleView = view;
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(margin, 0, kFit(200), view.mj_h)];
    [searchBtn setTitle:@"搜索关键字" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor lightGreen] forState:UIControlStateNormal];
    // 文字居左
    searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    searchBtn.adaptiveFontSize = 14;
    [searchBtn addTarget:self action:@selector(searchOfAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:searchBtn];
    
    UIImageView *searchImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kFit(view.mj_w-view.mj_h-5), kFit(5), kFit(20), kFit(20))];
    searchImgView.image = [UIImage imageNamed:@"h_Search"];
    [view addSubview:searchImgView];
}

// 搜索事件
- (void)searchOfAction{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        [cell addSubview:self.CountryCollectionView];
    }else if (indexPath.row == 1){
        [cell addSubview:self.GoodsCollectionView];
    }else if (indexPath.row == 2){
        kWeakSelf(self);
        _collectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.RecommendGoodsCollectionView.mj_w, kFit(80))];
        UIView *searchView = [[UIView alloc] init];
        CGFloat searchH = kFit(30);
        searchView.layer.cornerRadius = searchH/2;
        searchView.layer.borderColor = [[UIColor lightGreen] CGColor];
        searchView.layer.borderWidth = .5f;
        searchView.layer.masksToBounds = YES;
        [_collectionHeaderView addSubview:searchView];
        [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.collectionHeaderView.mas_centerY);
            make.left.equalTo(margin);
            make.size.equalTo(CGSizeMake(searchH*4, searchH));
        }];
        UIImageView *searchImgView = [[UIImageView alloc] init];
        searchImgView.image = [UIImage imageNamed:@"h_Search"];
        [searchView addSubview:searchImgView];
        [searchImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(kFit(20), kFit(20)));
            make.centerY.equalTo(searchView.mas_centerY);
            make.left.equalTo(margin);
        }];
        
        UIImageView *changerImgView = [[UIImageView alloc] init];
        changerImgView.image = [UIImage imageNamed:@"s-switch"];
        [_collectionHeaderView addSubview:changerImgView];
        [changerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakself.collectionHeaderView.mas_centerY);
            make.right.equalTo(-margin);
            make.size.equalTo(CGSizeMake(kFit(40), kFit(40)));
        }];
        [cell addSubview:_collectionHeaderView];
        [self.RecommendGoodsCollectionView setOrigin:CGPointMake(0, _collectionHeaderView.mj_y+_collectionHeaderView.mj_h)];
        [cell addSubview:self.RecommendGoodsCollectionView];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        [self.RecommendGoodsCollectionView reloadData];
        // 根据collectionView内容得到高度
        CGSize size = self.RecommendGoodsCollectionView.collectionViewLayout.collectionViewContentSize;
        // 重新计算collectionView的大小
        [self.RecommendGoodsCollectionView setSize:size];
        return size.height + _collectionHeaderView.mj_h;
    }
   return 100;
}

@end
