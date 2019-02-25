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

@interface GlobalShoppingViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) ShufflingView *shufflingView;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation GlobalShoppingViewController

static NSString *CellID = @"CellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect collectionViewFrame= CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 100);
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置UICollectionView为横向滚动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 每一行cell之间的间距
    flowLayout.minimumLineSpacing = 50;
    // 每一列cell之间的间距
    // flowLayout.minimumInteritemSpacing = 10;
    // 设置第一个cell和最后一个cell,与父控件之间的间距
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    
    //    flowLayout.minimumLineSpacing = 1;// 根据需要编写
    //    flowLayout.minimumInteritemSpacing = 1;// 根据需要编写
    //    flowLayout.itemSize = CGSizeMake(70, 70);// 该行代码就算不写,item也会有默认尺寸
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor redColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    _collectionView = collectionView;
    [self.view addSubview:collectionView];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellID];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 15;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    if (!cell ) {
        NSLog(@"cell为空,创建cell");
        cell = [[UICollectionViewCell alloc] init];
    }
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

-(void)setupUI{
    [super setupUI];
    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.bottom.equalTo(0);
//    }];
    // 设置顶部的搜索框
    [self setupNavagationBar];
    // 轮播
    _shufflingView = [[ShufflingView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, kFit(180)) andIndex:@"1"];
    self.tableView.tableHeaderView = _shufflingView;
//    [self.view addSubview:_shufflingView];
}

-(void)setupNavagationBar{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kFit(260), kFit(30))];
    view.layer.cornerRadius = view.mj_h/2;
    view.backgroundColor = KWhiteColor;
    self.navigationItem.titleView = view;
    
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(kFit(10), 0, kFit(200), view.mj_h)];
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

@end
