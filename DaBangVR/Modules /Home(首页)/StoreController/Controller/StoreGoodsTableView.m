//
//  StoreGoodsTableView.m
//  DaBangVR
//
//  Created by mac on 2019/5/15.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "StoreGoodsTableView.h"
#import "StoreGoodsTableViewCell.h"
#import "StoreGoodsTableViewHeaderView.h"

static NSString *const cellID   = @"cellID";
static NSString *const headerID = @"headerID";

@interface StoreGoodsTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation StoreGoodsTableView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.delegate      = self;
        self.dataSource    = self;
        [self registerNib:[UINib nibWithNibName:@"StoreGoodsTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
        [self registerNib:[UINib nibWithNibName:@"StoreGoodsTableViewHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:headerID];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count+10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[StoreGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(103);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    StoreGoodsTableViewHeaderView *headerView = [[StoreGoodsTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 35)];
    headerView.backgroundColor = KRandomColor;
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kFit(35);
}

- (void)setData:(NSArray *)data{
    _data = data;
    [self reloadData];
}

@end
