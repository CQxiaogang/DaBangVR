//
//  MainViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

static NSString *const CellID = @"CellID";

#pragma mark —— 懒加载

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    self.view.backgroundColor = KWhiteColor;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)setupUI{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellEditingStyleNone;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.showsVerticalScrollIndicator = NO;
    self.tableView = tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    DLog(@"rootViewController");
    return 0;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    DLog(@"rootViewController");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    return cell;
}


@end
