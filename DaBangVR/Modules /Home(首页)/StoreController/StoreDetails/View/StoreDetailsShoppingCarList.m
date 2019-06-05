//
//  StoreDetailsShoppingCarList.m
//  DaBangVR
//
//  Created by mac on 2019/6/4.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "StoreDetailsShoppingCarList.h"
#import "StoreDetailsShoppingCarTableViewCell.h"

#define VIEW_HEIGHT KScreenH * 0.5

static NSString *cellID = @"cellID";

@interface StoreDetailsShoppingCarList ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger count;
}

//内容view
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation StoreDetailsShoppingCarList

#pragma mark —— 懒加载
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenH - VIEW_HEIGHT, KScreenW, VIEW_HEIGHT)];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate   = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"StoreDetailsShoppingCarTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

#pragma mark —— 系统方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        count = 10;
        [self setupUI];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    kWeakSelf(self);
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (80*weakself.data.count > 480) {
            make.height.equalTo(480);
        }else{
            make.height.equalTo(80*weakself.data.count+kNavBarHeight);
        }
        make.left.right.bottom.equalTo(0);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(0);
        make.bottom.equalTo(-kNavBarHeight);
    }];
}

-(void)setupUI{
    
    //添加手势，点击背景视图消失
    UITapGestureRecognizer *tapBackGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [self addGestureRecognizer:tapBackGesture];
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.tableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StoreDetailsShoppingCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.model = _data[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(80);
}

- (void)removeView {
    __weak typeof(self) _weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor clearColor];
        _weakSelf.contentView.frame = CGRectMake(0, KScreenH, KScreenW, VIEW_HEIGHT);
    } completion:^(BOOL finished) {
        [_weakSelf removeFromSuperview];
    }];
}

- (void)showInView:(UIView *)view {
    [view addSubview:self];
    __weak typeof(self) _weakSelf = self;
    self.contentView.frame = CGRectMake(0, KScreenH, KScreenW, VIEW_HEIGHT);;
    
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        _weakSelf.contentView.frame = CGRectMake(0, KScreenH - VIEW_HEIGHT, KScreenW, VIEW_HEIGHT);
    }];
}

- (void)setData:(NSArray<StoreDetailsShoppingCarModel *> *)data{
    _data = data;
    [self.tableView reloadData];
}

@end
