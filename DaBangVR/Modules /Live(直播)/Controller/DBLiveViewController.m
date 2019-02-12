//
//  DBLiveViewController.m
//  DaBangVR
//
//  Created by mac on 2018/11/17.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "DBLiveViewController.h"
#import "WaterfallColectionLayout.h"

static NSString *cellID = @"cellID";

@interface DBLiveViewController ()
<
 UITableViewDelegate,
 UITableViewDataSource,
 UICollectionViewDelegate,
 UICollectionViewDataSource
>
{
    /*
     判断程序是不是第一次调用，防止构建视图
     程序会同时调用viewDidLoad和viewWillAppear方法，两个方法都存在视图构建方法
     为什么视图构建方法不放在viewDidLoad或viewWillAppear中
     1.viewWillAppear每次进入程序都会调用，而viewDidLoad只调用一次，所以计算量大的不能放在viewWillAppear中。但是在程序每次进入时候的时候需要构建部分视图，所以为了防止重复构建就以bool值来判断程序的状态
     */
     BOOL isFrist;
}

//定义collectionView,瀑布流显示
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewLayout *layout;

@property (nonatomic, strong) NSArray *heightArr;

@property (nonatomic, strong) NSMutableArray *viewList;

@end

@implementation DBLiveViewController

#pragma mark 懒加载

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        CGFloat collectV_Y = 0;
        CGFloat collectV_W = self.view.mj_w;
        CGFloat collectV_H = self.view.mj_h - 49 - 44 - 20;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, collectV_Y, collectV_W, collectV_H) collectionViewLayout:self.layout];
        //设置背景颜色，不然显示为黑色
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        _collectionView.delegate = self;
        
        _collectionView.dataSource = self;
        //去掉滚动条
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
        
    }
    return _collectionView;
}

-(UICollectionViewLayout *)layout{
    if (!_layout) {
        _layout = [[WaterfallColectionLayout alloc] initWithItemsHeightBlock:^CGFloat(NSIndexPath *index) {
            return [self.heightArr[index.item] floatValue];
        }];
    }
    return _layout;
}

-(NSArray *)heightArr{
    if (!_heightArr) {
        //随机生成高度
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i<100; i++) {
            [arr addObject:@(arc4random()%100+300)];
        }
        _heightArr = [arr copy];
    }
    return _heightArr;
}

- (NSMutableArray *)viewList{
    if (!_viewList) {
        _viewList = [NSMutableArray new];
        
        [_viewList addObject:self.tableView];
        
        [_viewList addObject:self.collectionView];
    }
    return _viewList;
}

#pragma mark 系统回调方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setupUI{
    [super setupUI];
    
    CGFloat tableV_Y = 0;
    CGFloat tableV_W = self.view.mj_w;
    CGFloat tableV_H = self.view.mj_h - 49 - 44 - 20;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableV_Y, tableV_W, tableV_H)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DBLiveTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    
    if (!isFrist) {
        //设置UI
        [self setUp_UI];
        isFrist = NO;
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏navigationBar
    [self.navigationController setNavigationBarHidden:YES];
    
    if (isFrist) {
        
    }
    
    isFrist = YES;
}

#pragma mark 设置UI
- (void)setUp_UI{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor lightGreen];
}

#pragma mark tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
}

#pragma mark collectionView

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.heightArr.count;;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell  = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    // 解决添加view到cell上，view重用问题
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    /////////////////////////////////
    
    CGFloat topV_H = 60;
    CGFloat topV_Y = cell.mj_h - topV_H;
    CGFloat topV_W = cell.mj_w;
    
    UIImageView * top_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, topV_Y, topV_W, topV_H)];
        
    top_imageView.backgroundColor = [UIColor blueColor];
    
    [cell addSubview:top_imageView];
    
    cell.backgroundColor = [UIColor randomColor];
    
    return cell;
}
@end

