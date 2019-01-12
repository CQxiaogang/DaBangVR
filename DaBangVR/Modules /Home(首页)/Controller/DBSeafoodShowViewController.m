//
//  DBSeafoodShowViewController.m
//  DaBangVR
//
//  Created by mac on 2018/12/18.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "SeafoodShowTableView.h"
#import "GoodsDetailsViewController.h"
#import "DBSeafoodShowViewController.h"
// Models
#import "SeafoodShowTitleModel.h"

@interface DBSeafoodShowViewController ()
<
PageTitleViewDelegate,
pageContentViewDelegate,
SeafoodShowTableViewDelegate
>

@property (nonatomic, strong) SeafoodShowTitleModel *seafoodShowTitleModel;

@end

@implementation DBSeafoodShowViewController

// 懒加载
- (PageTitleView *)pageTitleView{
    if (!_pageTitleView) {
        NSArray *arrTitle = @[@"生鲜",@"海鲜干货",@"海捕大虾",@"新鲜海产",@"海鲜零食"];
        _pageTitleView = [[PageTitleView alloc] initWithFrame:CGRectMake(0, kTopHeight, self.view.mj_w, 44) Titles:arrTitle];
        _pageTitleView.delagate = self;
    }
    return _pageTitleView;
}

- (PageContentView *)pageContentView{
    if (!_pageContentView) {
       
        NSArray *array = @[
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1503377311744&di=a784e64d1cce362c663f3480b8465961&imgtype=0&src=http%3A%2F%2Fww2.sinaimg.cn%2Flarge%2F85cccab3gw1etdit7s3nzg2074074twy.jpg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1545716423002&di=0bfc836baba9890320cb77ef1f401b7b&imgtype=0&src=http%3A%2F%2Fimg.mp.itc.cn%2Fupload%2F20161027%2Fe1a28553f0c947c391f776b89794d778_th.gif",
                           @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=485008701,3192247883&fm=26&gp=0.jpg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1545716774663&di=c95751c22f5ec65e1bbeef8adc63b77a&imgtype=0&src=http%3A%2F%2Fimg.mp.itc.cn%2Fupload%2F20161022%2Fe76b02764dc34ff997d1c608df65cce4_th.gif",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1545716774662&di=6f6c0d13753ad97a6c3faf3a70ba4252&imgtype=0&src=http%3A%2F%2Fimg.mp.sohu.com%2Fupload%2F20170807%2F1f54ee17019c410f816bc84b485e754e_th.png"];
        NSMutableArray *arrView = [NSMutableArray new];
        for (int i=0; i<5; i++) {
            SeafoodShowTableView *tableView = [[SeafoodShowTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
            tableView.sfDelegate = self;
            tableView.data = (NSMutableArray *)array;
            tableView.tag = 10 + i;
            [arrView addObject:tableView];
        }
        _pageContentView = [[PageContentView alloc] initWithFrame:self.view.bounds childSv:arrView];
        _pageContentView.delegate = self;
    }
    return _pageContentView;
}
// 系统回掉
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.pageTitleView];
//    [self.view addSubview:self.pageContentView];
//    kWeakSelf(self);
//    [self.pageContentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakself.pageTitleView.mas_bottom).offset(0);
//        make.left.right.bottom.equalTo(@(0));
//    }];
    self.seafoodShowTitleModel = [[SeafoodShowTitleModel alloc] init];
}

#pragma mark —— pageTitleView delegate
-(void)pageTitleView:(UIView *)titleView selectedIndex:(int)index{
    [self.pageContentView setCurrentIndex:index];
}

#pragma mark —— pageContentView delegate
- (void)pageContentView:(UIView *)contentView progress:(CGFloat)p sourceIndex:(int)s targetIndex:(int)t{
    [self.pageTitleView setTitleWithProgress:p sourceIndex:s targetIndex:t];
}

- (void)selectCellShowGoods{
    GoodsDetailsViewController *GoodsDetailsVC = [GoodsDetailsViewController new];
    [self.navigationController pushViewController:GoodsDetailsVC animated:NO];
}
@end
