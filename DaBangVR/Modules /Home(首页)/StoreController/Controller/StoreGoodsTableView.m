//
//  StoreGoodsTableView.m
//  DaBangVR
//
//  Created by mac on 2019/5/15.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "StoreGoodsTableView.h"
#import "StoreGoodsTableViewCell.h"

static NSString *cellID = @"cellID";

@interface StoreGoodsTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation StoreGoodsTableView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.delegate   = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"StoreGoodsTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[StoreGoodsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    return cell;
}

- (void)setData:(NSInteger)data{
    _data = data;
    [self reloadData];
}

@end
