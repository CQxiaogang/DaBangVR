//
//  StoreGoodAttributesView.m
//  DaBangVR
//
//  Created by mac on 2019/6/3.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "StoreGoodAttributesView.h"
#import "CollectionHeaderLayout.h"
#import "FeatureItemCell.h"
#import "FeatureHeaderView.h"
#import "FeatureChoseTopCell.h"
#import "DeptDetailsGoodsSpecList.h"
#import "DeptDetailsGoodsDeliveryProductInfoListModel.h"
#import "PPNumberButton.h"

#define STORE_VIEW_HEIGHT KScreenH * 0.5

static NSString *const DBFeatureItemCellID = @"DBFeatureItemCell";
static NSString *const DBFeatureHeaderViewID = @"DBFeatureHeaderView";
static NSString *const DBFeatureChoseTopCellID = @"DBFeatureChoseTopCell";

@interface StoreGoodAttributesView ()<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, HorizontalCollectionLayoutDelegate, PPNumberButtonDelegate>
//内容view
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UITableView *tableView;

/* 选择属性 */
@property (strong , nonatomic)NSMutableArray *seleArray;
@property (strong, nonatomic) NSMutableArray *goodsDetailsArr;

@property (nonatomic, strong) PPNumberButton *numberButton;
//订单确认按钮
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UILabel *numLabel;

@property (nonatomic, strong) NSMutableDictionary *goodsDicInfo;

@end

@implementation StoreGoodAttributesView
#pragma mark —— 懒加载
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenH - STORE_VIEW_HEIGHT, KScreenW, STORE_VIEW_HEIGHT)];
        _contentView.backgroundColor = [UIColor whiteColor];
        // 添加手势，遮盖整个视图的手势，解决传递响应链
        UITapGestureRecognizer *contentViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
        // cancelsTouchesInView 解决collectionView和手势的冲突
        contentViewTapGesture.cancelsTouchesInView = false;
        [_contentView addGestureRecognizer:contentViewTapGesture];
    }
    return _contentView;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        CollectionHeaderLayout *layout = [CollectionHeaderLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        //自定义layout初始化
        layout.delegate = self;
        layout.lineSpacing = 8.0;
        layout.interitemSpacing = 10;
        layout.headerViewHeight = 35;
        layout.footerViewHeight = 5;
        _collectionView.delegate   = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[FeatureItemCell class] forCellWithReuseIdentifier:DBFeatureItemCellID]; //cell
        [_collectionView registerClass:[FeatureHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DBFeatureHeaderViewID]; //头部
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"]; //尾部
    }
    return _collectionView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.rowHeight      = 100;
        _tableView.delegate       = self;
        _tableView.dataSource     = self;
        _tableView.scrollEnabled  = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[FeatureChoseTopCell class] forCellReuseIdentifier:DBFeatureChoseTopCellID];
    }
    return _tableView;
}

- (NSMutableArray *)goodsDetailsArr{
    if (!_goodsDetailsArr) {
        _goodsDetailsArr = [NSMutableArray new];
    }
    return _goodsDetailsArr;
}

-(PPNumberButton *)numberButton{
    if (!_numberButton) {
        _numberButton = [PPNumberButton numberButtonWithFrame:CGRectZero];
        _numberButton.shakeAnimation = YES;
        _numberButton.minValue = 1;
        _numberButton.inputFieldFont = 16;
        _numberButton.increaseTitle = @"＋";
        _numberButton.decreaseTitle = @"－";
        lastNum = (lastNum == 0) ? 1:lastNum;
        _numberButton.currentNumber = lastNum;
        _numberButton.delegate = self;
        kWeakSelf(self);
        _numberButton.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
            lastNum = num;
            [weakself.tableView reloadData];
        };
    }
    return _numberButton;
}

- (UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.backgroundColor = KRedColor;
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sureBtn.frame = CGRectMake(0, self.contentView.frame.size.height - 40, KScreenW, 40);
        [_sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _sureBtn;
}

-(UILabel *)numLabel{
    if (!_numLabel) {
        _numLabel = [UILabel new];
        _numLabel.text = @"数量";
        _numLabel.textAlignment = NSTextAlignmentRight;
        _numLabel.font = [UIFont systemFontOfSize:15];
    }
    return _numLabel;
}

-(NSMutableDictionary *)goodsDicInfo{
    if (!_goodsDicInfo) {
        _goodsDicInfo = [NSMutableDictionary dictionary];
    }
    return _goodsDicInfo;
}

#pragma mark —— 系统方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBasicView];
    }
    return self;
}

-(void)setupBasicView{
    //添加手势，点击背景视图消失
    UITapGestureRecognizer *tapBackGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [self addGestureRecognizer:tapBackGesture];
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.tableView];
    [self.contentView addSubview:self.collectionView];
    [self.contentView addSubview:self.numLabel];
    [self.contentView addSubview:self.numberButton];
    [self.contentView addSubview:self.sureBtn];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    kWeakSelf(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(weakself.contentView).offset(0);
        make.size.equalTo(CGSizeMake(KScreenW, 100));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.tableView.mas_bottom).offset(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(weakself.numLabel.mas_top).offset(0);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakself.sureBtn.mas_top).offset(0);
        make.left.mas_equalTo(weakself.contentView).offset(0);
        make.size.mas_equalTo(CGSizeMake(50, 40));
    }];
    
    [self.numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakself.numLabel.mas_right).offset(0);
        make.bottom.mas_equalTo(weakself.sureBtn.mas_top).offset(0);
        make.size.mas_equalTo(CGSizeMake(150, 40));
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakself.contentView).offset(0);
        make.size.mas_equalTo(CGSizeMake(KScreenW, 40));
    }];
}

#pragma mark —— UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //反正重复添加
    if (self.goodsDetailsArr) {
        [self.goodsDetailsArr removeAllObjects];
    }
    FeatureChoseTopCell *cell = [tableView dequeueReusableCellWithIdentifier:DBFeatureChoseTopCellID forIndexPath:indexPath];
    //cell不能点击
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.seleArray.count != self.model.specList.count) {
        [cell.goodImageView setImageURL:[NSURL URLWithString:self.model.listUrl]];
        cell.goodPriceLabel.text  = [NSString stringWithFormat:@"¥ %.2f",[_model.sellingPrice floatValue]*lastNum];;
        cell.chooseAttLabel.text = @"请选择规格";
    }else{
        cell.chooseAttLabel.textColor = [UIColor darkGrayColor];
        //拼接所选规格ID
        NSString *attString = [_seleArray componentsJoinedByString:@"_"];
        if (_model.deliveryProductInfoList.count != 0) {
            for (DeptDetailsGoodsDeliveryProductInfoListModel *model in _model.deliveryProductInfoList) {
                if ([attString isEqualToString:model.deliveryGoodsSpecIds]){
                    cell.chooseAttLabel.text = [NSString stringWithFormat:@"已选属性：%@",model.name];
                    cell.inventoryLabel.text = [NSString stringWithFormat:@"库存 %@ 件",model.number];
                    cell.goodPriceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[model.marketPrice floatValue]*lastNum];
                    
                    [self.goodsDetailsArr removeAllObjects];
                    
                    [self.goodsDicInfo setObject:model.marketPrice forKey:@"price"];
                    [self.goodsDicInfo setObject:[NSString stringWithFormat:@"%ld",lastNum] forKey:@"number"];
                    [self.goodsDicInfo setObject:model.name forKey:@"specifications"];
                    [self.goodsDicInfo setObject:model.deliveryGoodsId forKey:@"ID"];
                    [self.goodsDicInfo setObject:self.model.listUrl forKey:@"pictureUrl"];
                    [self.goodsDicInfo setObject:self.model.name forKey:@"title"];
                }
            }
        }
    }
     return cell;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _model.specList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _model.specList[section].deliveryGoodsSpecList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FeatureItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DBFeatureItemCellID forIndexPath:indexPath];
    cell.content = _model.specList[indexPath.section].deliveryGoodsSpecList[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind  isEqualToString:UICollectionElementKindSectionHeader]) {
        FeatureHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DBFeatureHeaderViewID forIndexPath:indexPath];
        headerView.headTitle = _model.specList[indexPath.section].name;
        return headerView;
    }else {
        
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter" forIndexPath:indexPath];
        return footerView;
    }
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //限制每组内的Item只能选中一个(加入质数选择)
    if (_model.specList[indexPath.section].deliveryGoodsSpecList[indexPath.row].isSelect == NO) {
        for (NSInteger j = 0; j < _model.specList[indexPath.section].deliveryGoodsSpecList.count; j++) {
            _model.specList[indexPath.section].deliveryGoodsSpecList[j].isSelect = NO;
        }
    }
    _model.specList[indexPath.section].deliveryGoodsSpecList[indexPath.row].isSelect = !_model.specList[indexPath.section].deliveryGoodsSpecList[indexPath.row].isSelect;
    
    //section，item 循环讲选中的所有Item加入数组中 ，数组mutableCopy初始化
    _seleArray = [@[] mutableCopy];
    for (NSInteger i = 0; i < _model.specList.count; i++) {
        for (NSInteger j = 0; j < _model.specList[i].deliveryGoodsSpecList.count; j++) {
            if (_model.specList[i].deliveryGoodsSpecList[j].isSelect == YES) {
                
                [_seleArray addObject:_model.specList[i].deliveryGoodsSpecList[j].ID];
                
            }else{
                [_seleArray removeObject:_model.specList[i].deliveryGoodsSpecList[j].ID];
            }
        }
    }
    //刷新tableView和collectionView
    [self.collectionView reloadData];
    [self.tableView reloadData];
}

#pragma mark - <HorizontalCollectionLayoutDelegate>
#pragma mark - 自定义layout必须实现的方法
- (NSString *)collectionViewItemSizeWithIndexPath:(NSIndexPath *)indexPath {
    DeptDetailsGoodsSpecList *item = _model.specList[indexPath.section];
    DBFeatureList *list = item.deliveryGoodsSpecList[indexPath.row];
    return list.value;
}

#pragma mark - 按钮点击事件
// 确定商品属性选择
- (void)sureBtnClick {
    if (_seleArray.count != _model.specList.count){//未选择全属性警告
        [SVProgressHUD showInfoWithStatus:@"请选择全属性"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    // 退出视图
    [self removeView];
    // 回掉
    if (self.goodsAttributesBlock != nil) {
        self.goodsAttributesBlock(self.goodsDicInfo);
    }
}

-(void)setModel:(DeptDetailsGoodsModel *)model{
    _model = model;
}

- (void)removeView {
    __weak typeof(self) _weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor clearColor];
        _weakSelf.contentView.frame = CGRectMake(0, KScreenH, KScreenW, STORE_VIEW_HEIGHT);
    } completion:^(BOOL finished) {
        [_weakSelf removeFromSuperview];
    }];
}

- (void)showInView:(UIView *)view {
    [view addSubview:self];
    __weak typeof(self) _weakSelf = self;
    self.contentView.frame = CGRectMake(0, KScreenH, KScreenW, STORE_VIEW_HEIGHT);;
    
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _weakSelf.contentView.frame = CGRectMake(0, KScreenH - STORE_VIEW_HEIGHT, KScreenW, STORE_VIEW_HEIGHT);
    }];
}

@end
