//
//  evaluationViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/9.
//  Copyright © 2019 DaBangVR. All rights reserved.
//
// Controllers
#import "EvaluationViewController.h"
#import "EvaluationOfSuccessViewController.h"
// Views
#import "EvaluationCell.h"

@interface EvaluationViewController ()

@end

@implementation EvaluationViewController

static NSString *CellID = @"CellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价";
}

-(void)setupUI{
    [super setupUI];
    
    kWeakSelf(self);
    UIButton *submitBtn = [[UIButton alloc] init];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    submitBtn.titleLabel.adaptiveFontSize = 17;
    submitBtn.titleLabel.textColor = KWhiteColor;
    submitBtn.backgroundColor = [UIColor lightGreen];
    [submitBtn addTarget:self action:@selector(submitButtonOfAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.bottom.equalTo(-20);
        make.size.equalTo(CGSizeMake(weakself.view.mj_w - 20, 40));
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"EvaluationCell" bundle:nil] forCellReuseIdentifier:CellID];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kTopHeight);
        make.left.right.equalTo(0);
        make.bottom.equalTo(submitBtn.mas_top).offset(0);
    }];
    
    // 设置 navagationbar 的按钮
    [self setupNavagationBar];
}

- (void)setupNavagationBar{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn.widthAnchor constraintEqualToConstant:25
     ].active = YES;
    [btn.heightAnchor constraintEqualToConstant:25].active = YES;
    [btn setImage:[UIImage imageNamed:@"e-more"] forState:UIControlStateNormal];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = btnItem;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EvaluationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[EvaluationCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 438;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}
#pragma mark —— button 点击事件
// 提交 button 的点击事件
- (void)submitButtonOfAction{
    EvaluationOfSuccessViewController *vc = [[EvaluationOfSuccessViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}

@end
