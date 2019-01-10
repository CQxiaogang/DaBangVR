//
//  AllOrderTableView.m
//  DaBangVR
//
//  Created by mac on 2019/1/9.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "AllOrderTableView.h"
//
#import "AllOrdersCell.h"

@interface AllOrderTableView ()<allOrdersCellDelegate>

@property (nonatomic, strong) NSArray *array;

@end
@implementation AllOrderTableView

static NSString *CellID = @"CellID";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self registerNib:[UINib nibWithNibName:@"AllOrdersCell" bundle:nil] forCellReuseIdentifier:CellID];
        self.delegate = self;
        self.dataSource = self;
        _array = @[@"确认收货",@"立即付款",@"删除订单",@"去评价"];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    AllOrdersCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.delegate = self;
    if (!cell) {
        cell = [[AllOrdersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    [cell.lowerRightCornerBtn setTitle:_array[indexPath.row] forState:UIControlStateNormal];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.allDelegate && [self.allDelegate respondsToSelector:@selector(didSelectRowAtIndexPath)]) {
        [self.allDelegate didSelectRowAtIndexPath];
    }
}

#pragma mark —— allOrdersCell Delegate
-(void)lowerRightCornerClickEvent:(NSString *)string{
    if (self.allDelegate && [self.allDelegate respondsToSelector:@selector(allOrderTableViewButtonOfAction:)]) {
        [self.allDelegate allOrderTableViewButtonOfAction:string];
    }
}

@end
