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
#import "CommentsListModel.h"

@interface AllCommentsViewController ()
// 数据源
@property (nonatomic, copy) NSMutableArray *commentsData;

@end

@implementation AllCommentsViewController
static NSString *CellID = @"CellID";
#pragma mark —— 懒加载
- (NSMutableArray *)commentsData{
    if (!_commentsData) {
        _commentsData = [NSMutableArray new];
    }
    return _commentsData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    
}

- (void)getData:(NSString *)goodsId{
    
    [NetWorkHelper POST:URl_getCommentListTwo parameters:@{@"goodsId":goodsId} success:^(id  _Nonnull responseObject) {
        
        NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
        NSDictionary *commentVoList = data[@"commentVoList"];
        self.commentsData = [CommentsListModel mj_objectArrayWithKeyValuesArray:commentVoList];
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
    return self.commentsData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AllCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[AllCommentsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    cell.model = self.commentsData[indexPath.row];
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
