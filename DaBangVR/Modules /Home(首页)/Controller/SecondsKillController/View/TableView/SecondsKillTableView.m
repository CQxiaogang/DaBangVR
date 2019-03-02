//
//  SecondsKillTableView.m
//  DaBangVR
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "SecondsKillTableView.h"
#import "SecondsKillCell.h"

@interface SecondsKillTableView ()
@property (nonatomic, copy)NSArray *goodsData;
@end

@implementation SecondsKillTableView
static NSString *CellID = @"CellID";

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 加载数据
        [self laodingData];
        
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"SecondsKillCell" bundle:nil] forCellReuseIdentifier:CellID];
    }
    return self;
}

- (void)laodingData{
    kWeakSelf(self);
    NSDictionary *dic = @{
                          @"hoursTime":@"17",
                          @"page":@"1",
                          @"limit":@"10"
                          };
    [NetWorkHelper POST:URl_getSecondsKillGoodsList parameters:dic success:^(id  _Nonnull responseObject) {
        
        NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
        NSDictionary *goodsList = data[@"goodsList"];
        weakself.goodsData = [GoodsDetailsModel mj_objectArrayWithKeyValuesArray:goodsList];
        [self reloadData];
        
    } failure:^(NSError * _Nonnull error) {}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _goodsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SecondsKillCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[SecondsKillCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    cell.model = _goodsData[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(165);
}

@end
