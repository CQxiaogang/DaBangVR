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

@interface DBSeafoodShowViewController ()<SeafoodShowTableViewDelegate>

@property (nonatomic, strong) PageView *pageView;

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation DBSeafoodShowViewController

#pragma mark —— 懒加载
- (PageView *)pageView{
    if (!_pageView) {
        NSArray *arrTitle = self.data;
        NSArray *array = @[
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1503377311744&di=a784e64d1cce362c663f3480b8465961&imgtype=0&src=http%3A%2F%2Fww2.sinaimg.cn%2Flarge%2F85cccab3gw1etdit7s3nzg2074074twy.jpg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1545716423002&di=0bfc836baba9890320cb77ef1f401b7b&imgtype=0&src=http%3A%2F%2Fimg.mp.itc.cn%2Fupload%2F20161027%2Fe1a28553f0c947c391f776b89794d778_th.gif",
                           @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=485008701,3192247883&fm=26&gp=0.jpg",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1545716774663&di=c95751c22f5ec65e1bbeef8adc63b77a&imgtype=0&src=http%3A%2F%2Fimg.mp.itc.cn%2Fupload%2F20161022%2Fe76b02764dc34ff997d1c608df65cce4_th.gif",
                           @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1545716774662&di=6f6c0d13753ad97a6c3faf3a70ba4252&imgtype=0&src=http%3A%2F%2Fimg.mp.sohu.com%2Fupload%2F20170807%2F1f54ee17019c410f816bc84b485e754e_th.png"];
        NSMutableArray *arrView = [NSMutableArray new];
        for (int i=0; i<self.data.count; i++) {
            SeafoodShowTableView *tableView = [[SeafoodShowTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
            tableView.sfDelegate = self;
            tableView.data = (NSMutableArray *)array;
            tableView.tag = 10 + i;
            [arrView addObject:tableView];
        }
        _pageView = [[PageView alloc] initWithFrame:CGRectMake(0, kTopHeight, KScreenW, KScreenH) Titles:arrTitle ContentViews:arrView];
    }
    return _pageView;
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

    [NetWorkHelper POST:URL_seafood_title parameters:nil success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic= dic[@"data"];
        NSArray *goodsList = dataDic[@"goodsCategoryList"];
        for (NSDictionary *dic in goodsList) {
            SeafoodShowTitleModel *model = [SeafoodShowTitleModel modelWithDictionary:dic];
            
            [self.data addObject:model.name];
        }
        [self.view addSubview:self.pageView];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


- (void)selectCellShowGoods{
    GoodsDetailsViewController *GoodsDetailsVC = [GoodsDetailsViewController new];
    [self.navigationController pushViewController:GoodsDetailsVC animated:NO];
}
@end
