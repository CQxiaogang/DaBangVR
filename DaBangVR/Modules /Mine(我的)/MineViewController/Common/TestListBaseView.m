//
//  TestListBaseView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "TestListBaseView.h"
#import "MJRefresh.h"
#import "TestTableViewCell.h"
#import "DetailViewController.h"
#import "MineTableViewCell.h"

@interface TestListBaseView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
@property (nonatomic, strong) NSIndexPath *lastSelectedIndexPath;
@end

@implementation TestListBaseView

-(NSArray<NSString *> *)imgData{
    if (!_imgData) {
        _imgData = @[@"p_news",@"p_collections",@"p_balance",@"p_Grade",@"p_Red_envelopes",@"p_Real_name",@"p_Live_broadcast",@"p_feedback"];
    }
    return _imgData;
}

- (NSArray *)titleData{
    if (!_titleData) {
        _titleData = @[@"消息",@"收藏",@"商家认证",@"主播认证"];
    }
    return _titleData;
}

- (void)dealloc
{
    self.scrollCallback = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isHeaderRefreshed = NO;
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStyleGrouped];
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.tableFooterView = [UIView new];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.tableView registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 1)];
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.tableView.frame = self.bounds;
}

- (void)setIsNeedHeader:(BOOL)isNeedHeader {
    _isNeedHeader = isNeedHeader;

    __weak typeof(self)weakSelf = self;
    if (self.isNeedHeader) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.tableView.mj_header endRefreshing];
            });
        }];
    }else {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_header removeFromSuperview];
        self.tableView.mj_header = nil;
    }
}

- (void)setIsNeedFooter:(BOOL)isNeedFooter {
    _isNeedFooter = isNeedFooter;

    __weak typeof(self)weakSelf = self;
    if (self.isNeedFooter) {
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.dataSource addObject:@"加载更多成功"];
                [weakSelf.tableView reloadData];
                [weakSelf.tableView.mj_footer endRefreshing];
            });
        }];
    }else {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_footer removeFromSuperview];
        self.tableView.mj_footer = nil;
    }
}

- (void)beginFirstRefresh {
    if (!self.isHeaderRefreshed) {
        [self beginRefreshImmediately];
    }
}

- (void)beginRefreshImmediately {
    if (self.isNeedHeader) {
        [self.tableView.mj_header beginRefreshing];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.isHeaderRefreshed = YES;
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        });
    }else {
        self.isHeaderRefreshed = YES;
        [self.tableView reloadData];
    }
}

- (void)selectCellAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.infoString = self.dataSource[indexPath.row];
    [self.naviController pushViewController:detailVC animated:YES];

    if (self.lastSelectedIndexPath == indexPath) {
        return;
    }
    if (self.lastSelectedIndexPath != nil) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.lastSelectedIndexPath];
        [cell setSelected:NO animated:NO];
    }
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:YES animated:NO];
    self.lastSelectedIndexPath = indexPath;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titleData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.title.text = self.titleData[indexPath.row];
    cell.imgView.image = [UIImage imageNamed:self.imgData[indexPath.row]];
    [cell.content removeFromSuperview];
    [cell.otherImageV removeFromSuperview];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kFit(40);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectRowAtIndexPath:)]) {
        [self.delegate didSelectRowAtIndexPath:indexPath];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, .5)];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        return kFit(5);
    }
    return 1;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.scrollCallback ?: self.scrollCallback(scrollView);
}

#pragma mark - JXPagingViewListViewDelegate

- (UIView *)listView {
    return self;
}

- (UIScrollView *)listScrollView {
    return self.tableView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

@end
