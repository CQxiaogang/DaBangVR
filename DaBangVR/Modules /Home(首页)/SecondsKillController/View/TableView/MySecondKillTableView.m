//
//  MySecondKillTableView.m
//  DaBangVR
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "MySecondKillTableView.h"
#import "RightSecondsKillCell.h"
#import "GoodsDetailsModel.h"

@interface MySecondKillTableView ()
@property (nonatomic, copy) NSArray *goodsData;
@end

@implementation MySecondKillTableView

static NSString *CellID = @"CellID";

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 加载数据
        [self loadingData];
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"RightSecondsKillCell" bundle:nil] forCellReuseIdentifier:CellID];
    }
    return self;
}

-(void)loadingData{
    kWeakSelf(self);
    NSDictionary *dic = @{
                          @"page"      :@"1",
                          @"limit"     :@"10",
                          @"buyType"   :@"6"
                          };
    [NetWorkHelper POST:URl_getOrderList parameters:dic success:^(id  _Nonnull responseObject) {
        NSDictionary *dataDic= KJSONSerialization(responseObject)[@"data"];
        _goodsData = dataDic[@"orderList"];
    } failure:^(NSError * _Nonnull error) {
        DLog(@"error%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _goodsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RightSecondsKillCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[RightSecondsKillCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    cell.model = _goodsData[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

@end
