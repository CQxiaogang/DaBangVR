//
//  liveShoppingCollectionViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "LiveShoppingCollectionViewCell.h"
/** 商品信息Cell */
#import "LiveGoddsInfoTableViewCell.h"

static NSString *cellID = @"cellID";

@interface LiveShoppingCollectionViewCell ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>
/** 显示商品的详情 */
@property (nonatomic, strong) UITableView *tableView;
/** 显示商品的规格 */
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation LiveShoppingCollectionViewCell
#pragma mark —— 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"LiveGoddsInfoTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}
#pragma mark —— 系统方法
- (void)awakeFromNib {
    [super awakeFromNib];
    //设置UI
    [self setupUI];
}

-(void)setupUI{
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(0);
        make.height.equalTo(70);
    }];
}

#pragma mark —— UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveGoddsInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(70);
}
#pragma mark —— UICollectionView

@end
