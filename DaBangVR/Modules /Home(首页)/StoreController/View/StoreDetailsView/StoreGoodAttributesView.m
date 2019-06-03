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

static NSString *const DBFeatureItemCellID = @"DBFeatureItemCell";
static NSString *const DBFeatureHeaderViewID = @"DBFeatureHeaderView";
static NSString *const DBFeatureChoseTopCellID = @"DBFeatureChoseTopCell";

@interface StoreGoodAttributesView ()<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, HorizontalCollectionLayoutDelegate>
//内容view
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UITableView *tableView;
/* 商品规格数据 */
@property (nonatomic, strong) NSMutableArray <DeptDetailsGoodsDeliveryProductInfoListModel*>*goodsSpecArr;
/* 商品规格展示的数据 */
@property (nonatomic, strong) NSMutableArray <DeptDetailsGoodsSpecList*>*featureAttr;
/* 选择属性 */
@property (strong , nonatomic)NSMutableArray *seleArray;
@property (strong, nonatomic) NSMutableArray *goodsDetailsArr;

@end

@implementation StoreGoodAttributesView
#pragma mark —— 懒加载
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, KScreenH - kATTR_VIEW_HEIGHT, KScreenW, kATTR_VIEW_HEIGHT)];
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

-(NSMutableArray<DeptDetailsGoodsSpecList *> *)featureAttr{
    if (!_featureAttr) {
        _featureAttr = [[NSMutableArray alloc] init];
    }
    return _featureAttr;
}

-(NSMutableArray<DeptDetailsGoodsDeliveryProductInfoListModel *> *)goodsSpecArr{
    if (!_goodsSpecArr) {
        _goodsSpecArr = [[NSMutableArray alloc] init];
    }
    return _goodsSpecArr;
}

- (NSMutableArray *)goodsDetailsArr{
    if (!_goodsDetailsArr) {
        _goodsDetailsArr = [NSMutableArray new];
    }
    return _goodsDetailsArr;
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
        make.bottom.mas_equalTo(weakself.contentView).offset(0);
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
    for (NSInteger i = 0; i < _featureAttr.count; i++) {
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

-(void)setModel:(DeptDetailsGoodsModel *)model{
    _model = model;
}

- (void)removeView {
    __weak typeof(self) _weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor clearColor];
        _weakSelf.contentView.frame = CGRectMake(0, KScreenH, KScreenW, kATTR_VIEW_HEIGHT);
    } completion:^(BOOL finished) {
        [_weakSelf removeFromSuperview];
    }];
}

- (void)showInView:(UIView *)view {
    [view addSubview:self];
    __weak typeof(self) _weakSelf = self;
    self.contentView.frame = CGRectMake(0, KScreenH, KScreenW, kATTR_VIEW_HEIGHT);;
    
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _weakSelf.contentView.frame = CGRectMake(0, KScreenH - kATTR_VIEW_HEIGHT, KScreenW, kATTR_VIEW_HEIGHT);
    }];
}

@end
