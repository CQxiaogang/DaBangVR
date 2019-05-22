//
//  ShortVideoViewController.m
//  DaBangVR
//
//  Created by mac on 2019/5/21.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "ShortVideoViewController.h"
#import "GoodsDetailsHeaderView.h"
#import "GoodsDetailsTableViewCell.h"
#import "VerticalListSectionModel.h"
#import "VerticalListCellModel.h"
#import "JXCategoryView.h"

static const CGFloat VerticalListCategoryViewHeight = 41;   //悬浮categoryView的高度
static const NSUInteger VerticalListPinSectionIndex = 1;    //悬浮固定section的index
static NSString *const cellID       = @"CellID";
static NSString *const cellHeaderID = @"cellHeaderID";

@interface ShortVideoViewController ()<JXCategoryViewDelegate>

@property(nonatomic, strong) JXCategoryTitleView *pinCategoryView;
@property(nonatomic, strong) NSArray <NSString *> *headerTitles;
@property (nonatomic, strong) NSArray <VerticalListSectionModel *> *dataSource;

@end

@implementation ShortVideoViewController
#pragma mark —— 懒加载


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodsDetailsTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    [self.tableView registerClass:[GoodsDetailsHeaderView class] forHeaderFooterViewReuseIdentifier:cellHeaderID];
    [self.view addSubview:self.tableView];
    [self loadingData];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kTopHeight);
        make.left.right.bottom.equalTo(0);
    }];
    
}

- (void)setupUI{
    [super setupUI];
    _pinCategoryView                 = [[JXCategoryTitleView alloc] init];
    self.pinCategoryView.frame       = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width/2, VerticalListCategoryViewHeight);
    self.pinCategoryView.titles      = @[@"商品", @"评价", @"详情", @"推荐"];
    self.pinCategoryView.cellWidth   = [UIScreen mainScreen].bounds.size.width/2/4;
    self.pinCategoryView.cellSpacing = 0;
    self.navigationItem.titleView    = self.pinCategoryView;
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.verticalMargin               = 0;
    lineView.indicatorLineWidth           = [UIScreen mainScreen].bounds.size.width/2/4-10;
    self.pinCategoryView.indicators       = @[lineView];
    self.pinCategoryView.delegate         = self;
}

-(void)loadingData{
    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    self.headerTitles = @[@"", @"评价", @"详情", @"推荐"];
    [self.headerTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        VerticalListSectionModel *sectionModel = [[VerticalListSectionModel alloc] init];
        sectionModel.sectionTitle = title;
        NSUInteger randomCount = arc4random()%10 + 5;
        NSMutableArray *cellModels = [NSMutableArray array];
        NSArray *imageNames = @[@"host", @"host", @"host", @"host"];
        for (int i = 0; i < randomCount; i ++) {
            VerticalListCellModel *cellModel = [[VerticalListCellModel alloc] init];
            cellModel.imageName = imageNames[idx];
            cellModel.itemName = title;
            [cellModels addObject:cellModel];
        }
        sectionModel.cellModels = cellModels;
        [dataSource addObject:sectionModel];
    }];
    self.dataSource = dataSource;
    [self.tableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource[section].cellModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //让cell不重用
    GoodsDetailsTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[GoodsDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    VerticalListSectionModel *sectionModel = self.dataSource[indexPath.section];
    VerticalListCellModel *cellModel = sectionModel.cellModels[indexPath.row];
    cell.cellImageView.image = [UIImage imageNamed:cellModel.imageName];
    cell.titleLabel.text = cellModel.itemName;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    GoodsDetailsHeaderView *headerView = [[GoodsDetailsHeaderView alloc] initWithFrame:CGRectMake(0, 0, tableView.mj_w, 30)];
    headerView.titleLabel.text = self.headerTitles[section];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //获取tableView当前展示的第一个cell属于哪个section
    NSArray <GoodsDetailsTableViewCell *> *cellArray = [self.tableView visibleCells];
    NSInteger nowSection = 0;
    if (cellArray) {
        GoodsDetailsTableViewCell *cell = [cellArray firstObject];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        nowSection = indexPath.section;
    }
    [self.pinCategoryView selectItemAtIndex:nowSection];
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index{
    //定位cell
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end
