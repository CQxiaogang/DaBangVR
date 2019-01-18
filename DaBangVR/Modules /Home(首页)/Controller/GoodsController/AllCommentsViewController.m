//
//  allCommentsViewController.m
//  DaBangVR
//
//  Created by mac on 2018/12/26.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "AllCommentsViewController.h"
// Cells
#import "AllCommentsCell.h"
// Models
#import "AllCommentsModel.h"

@interface AllCommentsViewController ()
// 数据源
@property (nonatomic, copy) NSMutableArray *data;

@end

@implementation AllCommentsViewController
static NSString *CellID = @"CellID";
#pragma mark —— 懒加载
- (NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray new];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    
}

- (void)getData:(NSString *)goodsId{
    
    [NetWorkHelper POST:URl_comment_list_two parameters:@{@"goodsId":goodsId} success:^(id  _Nonnull responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSDictionary *dataDic = dic[@"data"];
        NSArray *commentArr = dataDic[@"commentVoList"];
        for (NSDictionary *dic in commentArr) {
            AllCommentsModel *model = [AllCommentsModel modelWithDictionary:dic];
            [self.data addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}

- (void)setupUI{
    [super setupUI];
    [self.tableView registerNib:[UINib nibWithNibName:@"AllCommentsCell" bundle:nil] forCellReuseIdentifier:CellID];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kTopHeight);
        make.left.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AllCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[AllCommentsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    cell.model = self.data[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.mj_w, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, 30)];
    label.text = @"最新评论";
    label.textColor = KGrayColor;
    label.adaptiveFontSize = 12;
    [headerView addSubview:label];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

@end
