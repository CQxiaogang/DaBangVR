//
//  SecondsKillTableView.m
//  DaBangVR
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "SecondsKillTableView.h"
#import "SecondsKillCell.h"

@implementation SecondsKillTableView
static NSString *CellID = @"CellID";

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;

        [self registerNib:[UINib nibWithNibName:@"SecondsKillCell" bundle:nil] forCellReuseIdentifier:CellID];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SecondsKillCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[SecondsKillCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 165;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 150;
}
@end
