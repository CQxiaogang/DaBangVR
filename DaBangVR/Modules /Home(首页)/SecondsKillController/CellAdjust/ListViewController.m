//
//  ListViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "ListViewController.h"
// Models
#import "GoodsDetailsModel.h"
// Cells
#import "SecondsKillCell.h"

#define COLOR_WITH_RGB(R,G,B,A) [UIColor colorWithRed:R green:G blue:B alpha:A]

@interface ListViewController ()

@property (nonatomic, copy)NSArray *goodsData;

@end

@implementation ListViewController
static NSString *CellID = @"CellID";
- (void)viewDidLoad {
    [super viewDidLoad];

//    self.view.backgroundColor = COLOR_WITH_RGB(arc4random()%255/255.0, arc4random()%255/255.0, arc4random()%255/255.0, 1);
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SecondsKillCell" bundle:nil] forCellReuseIdentifier:CellID];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self loadingData:[NSString stringWithFormat:@"%ld",(long)_timeIndex]];
}

- (void)loadingData:(NSString *)hoursTime{
    kWeakSelf(self);
    NSDictionary *dic = @{
                          @"hoursTime":hoursTime,
                          @"page":@"1",
                          @"limit":@"10"
                          };
    [NetWorkHelper POST:URl_getSecondsKillGoodsList parameters:dic success:^(id  _Nonnull responseObject) {
        
        NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
        NSDictionary *goodsList = data[@"goodsList"];
        weakself.goodsData = [GoodsDetailsModel mj_objectArrayWithKeyValuesArray:goodsList];
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {}];
}
#pragma mark - JXCategoryListContentViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _goodsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondsKillCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.model = _goodsData[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(165);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.aDelegate && [self.aDelegate respondsToSelector:@selector(didSelectRowAtIndexPath:)]) {
        GoodsDetailsModel *model = _goodsData[indexPath.row];
        [self.aDelegate didSelectRowAtIndexPath:model.id];
    }
}

- (UIView *)listView {
    return self.view;
}

- (void)listDidAppear {}

- (void)listDidDisappear {}

@end
