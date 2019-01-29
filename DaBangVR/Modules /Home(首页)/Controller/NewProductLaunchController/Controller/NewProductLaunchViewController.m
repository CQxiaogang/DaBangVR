//
//  NewProductLaunchViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/29.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "NewProductLaunchViewController.h"
// Views
#import "NewProductLaunchCell.h"

@interface NewProductLaunchViewController ()

@end

@implementation NewProductLaunchViewController
static NSString *CellID = @"CellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新品首发";
}

- (void)setupUI{
    [super setupUI];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewProductLaunchCell" bundle:nil] forCellReuseIdentifier:CellID];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(0);
    }];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NewProductLaunchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[NewProductLaunchCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 326;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =[[UIView alloc] init];
    view.backgroundColor = KRedColor;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

@end
