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
// Cells
#import "MineCollectionTableViewCell.h"

@interface MineCollectionViewController ()

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, strong) NSArray <NSString *> *titles;

@end

@implementation MineCollectionViewController

static NSString *CellID = @"CellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏";
    
    [NetWorkHelper POST:URl_getGoodsCollectList parameters:nil success:^(id  _Nonnull responseObject) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
//    _titles = @[@"全部", @"降价中", @"低库存", @"已失效"];
//
//    self.categoryView = [[JXCategoryTitleView alloc] init];
//    self.categoryView.frame = CGRectMake(0, kTopHeight, KScreenW, 40);
//    self.categoryView.delegate = self;
//    self.categoryView.titles = _titles;
//    self.categoryView.titleSelectedColor = [UIColor lightGreen];
//    self.categoryView.titleColor = KGrayColor;
//    self.categoryView.defaultSelectedIndex = 0;
//    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
//    lineView.indicatorLineViewColor = [UIColor lightGreen];
//    self.categoryView.indicators = @[lineView];
//    [self.view addSubview:self.categoryView];
}

- (void)setupUI{
    [super setupUI];
    [self.tableView registerNib:[UINib nibWithNibName:@"MineCollectionTableViewCell" bundle:nil] forCellReuseIdentifier:CellID];
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, .5)];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(kTopHeight);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(91);
}

@end
