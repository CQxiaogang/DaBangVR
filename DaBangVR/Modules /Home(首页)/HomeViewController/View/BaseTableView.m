//
//  BaseTableView.m
//  DaBangVR
//
//  Created by mac on 2019/3/1.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "BaseTableView.h"
#import "HomeTableViewCell.h"

@interface BaseTableView ()

@end

@implementation BaseTableView
static NSString *CellID = @"CellID";

-(instancetype)init{
    self = [super init];
    if (self) {
        self.scrollEnabled = NO;
        self.dataSource = self;
        self.delegate = self;
        [self registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:CellID];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _goodsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    cell.model = _goodsData[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(118.5);
}

-(void)setGoodsData:(NSArray *)goodsData{
    _goodsData = goodsData;
    [self reloadData];
}

@end
