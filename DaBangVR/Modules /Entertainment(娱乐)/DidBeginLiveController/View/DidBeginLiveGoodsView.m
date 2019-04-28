//
//  DidBeginLiveGoodsView.m
//  DaBangVR
//
//  Created by mac on 2019/4/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "DidBeginLiveGoodsView.h"
#import "DidBeginLiveGoodsTableViewCell.h"

static NSString *const cellID = @"cellID";

@interface DidBeginLiveGoodsView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DidBeginLiveGoodsView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView            = [[UITableView alloc] init];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = KClearColor;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"DidBeginLiveGoodsTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _goodsData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DidBeginLiveGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.model = _goodsData[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(80);
}

-(void)setGoodsData:(NSArray *)goodsData{
    _goodsData = goodsData;
    [_tableView reloadData];
}

@end
