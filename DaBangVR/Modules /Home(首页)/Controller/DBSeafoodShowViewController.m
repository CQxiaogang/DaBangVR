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
// Views
#import "PageView.h"

@interface DBSeafoodShowViewController ()<SeafoodShowTableViewDelegate,PageViewDelegate>

@property (nonatomic, strong) PageView *pageView;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) SeafoodShowTableView *showTableView;
@property (nonatomic, strong) NSMutableArray *viewS;

@end

@implementation DBSeafoodShowViewController
static NSInteger _index;
#pragma mark —— 懒加载
- (PageView *)pageView{
    if (!_pageView) {
        NSMutableArray *names = [NSMutableArray new];
        NSMutableArray *IDs = [NSMutableArray new];
        for (SeafoodShowTitleModel *model in self.data) {
            [names addObject:model.name];
            [IDs addObject:model.id];
        }
        for (int i=0; i<self.data.count; i++) {
            _showTableView = [[SeafoodShowTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
            _showTableView.aDelegate = self;
            _showTableView.tag = 10 + i;
            [self.viewS addObject:_showTableView];
        }
        _showTableView.IDs = IDs;
        _showTableView.index = 0;
        _pageView = [[PageView alloc] initWithFrame:CGRectMake(0, kTopHeight, KScreenW, KScreenH) Titles:names ContentViews:self.viewS];
        _pageView.delegate = self;
    }
    return _pageView;
}

- (NSMutableArray *)viewS{
    if (!_viewS) {
        _viewS  = [NSMutableArray new];
    }
    return _viewS;
}

- (NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray new];
    }
    return _data;
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
            [self.data addObject:model];
        }
        [self.view addSubview:self.pageView];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark —— SeafoodShowTableView 代理
- (void)selectCellShowGoods{
    GoodsDetailsViewController *GoodsDetailsVC = [GoodsDetailsViewController new];
    [self.navigationController pushViewController:GoodsDetailsVC animated:NO];
}

#pragma mark —— pageView 代理
-(void)itemDidSelectedWithIndex:(NSInteger)index{
    _showTableView.index = index;
}
@end
