//
//  ShoppingCarViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "ShoppingCarViewController.h"
// Cells
#import "DBDetailContentCell.h"

@interface ShoppingCarViewController ()

@end
@implementation ShoppingCarViewController
static NSString *CellID = @"CellID";
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"购物车";
    
    [self setNagationBar];
}

- (void)setupUI{
    [super setupUI];
    [self.tableView registerNib:[UINib nibWithNibName:@"DBDetailContentCell" bundle:nil] forCellReuseIdentifier:CellID];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kTopHeight);
        make.left.right.equalTo(0);
        make.bottom.equalTo(0);
    }];
    
    // 设置底部 view
    UIView *bottemView = [[UIView alloc] init];
    bottemView.backgroundColor = KGrayColor;
    [self.view addSubview:bottemView];
    [bottemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(kTabBarHeight);
    }];
}

- (void) setNagationBar{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn.widthAnchor constraintEqualToConstant:25].active = YES;
    [rightBtn.heightAnchor constraintEqualToConstant:25].active = YES;
    [rightBtn setImage:[UIImage imageNamed:@"c_share"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DBDetailContentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[DBDetailContentCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}


@end
