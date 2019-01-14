//
//  BaseTableView.m
//  DaBangVR
//
//  Created by mac on 2018/12/24.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "SeafoodShowTableView.h"
#import "SeafoodShowTableViewCell.h"
// Models
#import "SeafoodShowListModel.h"

static NSString *CellID = @"CellID";

@interface SeafoodShowTableView ()

@property(nonatomic ,strong) NSMutableArray *data;

@end
@implementation SeafoodShowTableView

- (NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray new];
    }
    return _data;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self registerNib:[UINib nibWithNibName:@"SeafoodShowTableViewCell" bundle:nil] forCellReuseIdentifier:CellID];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SeafoodShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[SeafoodShowTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    cell.model = self.data[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 137;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.aDelegate selectCellShowGoods];
}

- (void)setIndex:(NSInteger)index{
    // 把 data 清空在重新加载数据
    [self.data removeAllObjects];
    // 网络请求
    [NetWorkHelper POST:URL_goods_list parameters:@{@"categoryId":_IDs[index]} success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic= dic[@"data"];
        NSArray *goodsList = dataDic[@"goodsList"];
        for (NSDictionary *dic in goodsList) {
            SeafoodShowListModel *model = [SeafoodShowListModel modelWithDictionary:dic];
            [self.data addObject:model];
        }
        [self reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
@end
