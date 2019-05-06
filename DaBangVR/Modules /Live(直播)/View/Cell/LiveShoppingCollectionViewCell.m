//
//  liveShoppingCollectionViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "LiveShoppingCollectionViewCell.h"
/** 商品信息Cell */
#import "LiveGoodsInfoTableViewCell.h"
#import "CollectionHeaderLayout.h"
#import "FeatureItemCell.h"
#import "FeatureHeaderView.h"
/** 增减数量控件 */
#import "PPNumberButton.h"
#import "ProductInfoVoListModel.h"

static NSString *cellID = @"cellID";
static NSString *FeatureItemCellID = @"FeatureItemCellID";
static NSString *FeatureHeaderViewCellID = @"FeatureHeaderViewCellID";
static NSString *FeatureFooterViewCellID = @"FeatureFooterViewCellID";

@interface LiveShoppingCollectionViewCell ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, HorizontalCollectionLayoutDelegate, PPNumberButtonDelegate>
/** 加入购物车 */
@property (weak, nonatomic) IBOutlet UIButton *addShoppingCarBtn;
/** 立即购买 */
@property (weak, nonatomic) IBOutlet UIButton *nowBuyBtn;
/** 显示商品的详情 */
@property (nonatomic, strong) UITableView *tableView;
/** 显示商品的规格 */
@property (nonatomic, strong) UICollectionView *collectionView;
/** 增减数量控件 */
@property (nonatomic, strong) PPNumberButton *numberButton;
/** 商品规格展示的数据 */
@property (strong , nonatomic)NSMutableArray <DBFeatureItem *> *featureAttr;
/** 商品规格数据 */
@property (strong , nonatomic)NSMutableArray <ProductInfoVoListModel *> *goodsSpecArr;
/** 选择属性 */
@property (strong , nonatomic)NSMutableArray *seleArray;
@property (strong, nonatomic) NSMutableArray *goodsDetailsArr;
@end

@implementation LiveShoppingCollectionViewCell
#pragma mark —— 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = KClearColor;
        _tableView.userInteractionEnabled = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"LiveGoodsInfoTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        CollectionHeaderLayout *layout = [CollectionHeaderLayout new];
        layout.delegate    = self;
        layout.lineSpacing = 8.0;
        layout.interitemSpacing = 10;
        layout.headerViewHeight = 35;
        layout.footerViewHeight = 5;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = KClearColor;
        _collectionView.delegate   = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator   = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[FeatureItemCell class] forCellWithReuseIdentifier:FeatureItemCellID];
        //注册头
        [_collectionView registerClass:[FeatureHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:FeatureHeaderViewCellID];
    }
    return _collectionView;
}

-(PPNumberButton *)numberButton{
    if (!_numberButton) {
        _numberButton = [PPNumberButton numberButtonWithFrame:CGRectZero];
        _numberButton.shakeAnimation = YES;
        _numberButton.minValue = 1;
        _numberButton.inputFieldFont = 16;
        _numberButton.increaseTitle = @"＋";
        _numberButton.decreaseTitle = @"－";
        _numberButton.delegate = self;
        _numberButton.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.4];
        kWeakSelf(self);
        _numberButton.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
            curNum = num;
            [weakself.tableView  reloadData];
        };
    }
    return _numberButton;
}

- (NSMutableArray *)goodsDetailsArr{
    if (!_goodsDetailsArr) {
        _goodsDetailsArr = [NSMutableArray new];
    }
    return _goodsDetailsArr;
}

#pragma mark —— 系统方法
- (void)awakeFromNib {
    [super awakeFromNib];
    //设置UI
    [self setupUI];
    
    _featureAttr = [NSMutableArray new];
    //解决CollectionView cell 无法点击
    /**
     解决方法L：ViewController 中应该设置了一个手势(UITapGestureRecognizer)，与UICollectionView的点击事件冲突，
     这个手势的覆盖区域应该与UICollectionView的监听区域冲突了，去掉这个手势，后者是处理一下这个手势的覆盖范围即可。
     */
    UITapGestureRecognizer *contentViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    contentViewTapGesture.cancelsTouchesInView = false;
    [self addGestureRecognizer:contentViewTapGesture];
}

-(void)setupUI{
    
    [self addSubview:self.tableView];
    [self addSubview:self.collectionView];
    [self addSubview:self.numberButton];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    kWeakSelf(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(0);
        make.height.equalTo(70);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(weakself.tableView.mas_bottom).offset(0);
        make.bottom.equalTo(weakself.addShoppingCarBtn.mas_top).offset(0);
    }];
    
    [self.numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(5);
        make.bottom.equalTo(weakself.addShoppingCarBtn.mas_top).offset(-10);
        make.size.equalTo(CGSizeMake(80, 25));
    }];
}

#pragma mark —— UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //重复添加
    if (self.goodsDetailsArr) {
        [self.goodsDetailsArr removeAllObjects];
    }
    LiveGoodsInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (_seleArray.count != _featureAttr.count) {
        [cell.goodsImgView setImageURL:[NSURL URLWithString:_model.listUrl]];
        cell.goodsPrice.text = [NSString stringWithFormat:@"¥ %.2f",[_model.sellingPrice floatValue]*curNum];
        cell.goodsDetails.text = _model.title;
    }else{
        NSString *attString = (_seleArray.count == _featureAttr.count) ? [_seleArray componentsJoinedByString:@"_"] : [lastSeleArray componentsJoinedByString:@"_"];
        for (ProductInfoVoListModel *model in _goodsSpecArr) {
            if ([attString isEqualToString:model.goodsSpecIds]) {
                cell.goodsPrice.text = [NSString stringWithFormat:@"¥ %.2f",[model.retailPrice floatValue]*curNum];
                [self.goodsDetailsArr removeAllObjects];
                [self.goodsDetailsArr addObject:model.id];
                [self.goodsDetailsArr addObject:model.goodsId];
            }
        }
        //没有规格的时候
        if (_featureAttr.count == 0) {
            [cell.goodsImgView setImageURL:[NSURL URLWithString:_model.listUrl]];
            cell.goodsPrice.text = [NSString stringWithFormat:@"¥ %.2f",[_model.sellingPrice floatValue]*curNum];
            cell.goodsDetails.text = _model.title;
            [self.goodsDetailsArr addObject:_model.id];
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(70);
}

#pragma mark —— UICollectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _featureAttr.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _featureAttr[section].goodsSpecList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FeatureItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FeatureItemCellID forIndexPath:indexPath];
    cell.defaultColor = KWhiteColor;
    if (_featureAttr.count != 0) {
        cell.content = _featureAttr[indexPath.section].goodsSpecList[indexPath.row];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        FeatureHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:FeatureHeaderViewCellID forIndexPath:indexPath];
        headerView.headTitle = _featureAttr[indexPath.section].name;
        headerView.color = KWhiteColor;
        return headerView;
    }else{
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FeatureFooterViewCellID forIndexPath:indexPath];
        return footerView;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //限制每组内的Item只能选中一个(加入质数选择)
    if (_featureAttr[indexPath.section].goodsSpecList[indexPath.row].isSelect == NO) {
        for (NSInteger j = 0; j < _featureAttr[indexPath.section].goodsSpecList.count; j++) {
            _featureAttr[indexPath.section].goodsSpecList[j].isSelect = NO;
        }
    }
    _featureAttr[indexPath.section].goodsSpecList[indexPath.row].isSelect = !_featureAttr[indexPath.section].goodsSpecList[indexPath.row].isSelect;
    
    //section，item 循环讲选中的所有Item加入数组中 ，数组mutableCopy初始化
    _seleArray = [@[] mutableCopy];
    for (NSInteger i = 0; i < _featureAttr.count; i++) {
        for (NSInteger j = 0; j < _featureAttr[i].goodsSpecList.count; j++) {
            if (_featureAttr[i].goodsSpecList[j].isSelect == YES) {
                
                [_seleArray addObject:_featureAttr[i].goodsSpecList[j].ID];
                
            }else{
                
                [_seleArray removeObject:_featureAttr[i].goodsSpecList[j].ID];
            }
        }
    }
    //刷新tableView和collectionView
    [self.collectionView reloadData];
    [self.tableView reloadData];
}

#pragma mark —— HorizontalCollectionLayoutDelegate
-(NSString *)collectionViewItemSizeWithIndexPath:(NSIndexPath *)indexPath{
    DBFeatureItem *item = _featureAttr[indexPath.section];
    DBFeatureList *list = item.goodsSpecList[indexPath.row];
    return list.value;
}

-(void)setModel:(GoodsDetailsModel *)model{
    _model = model;
    _featureAttr  = [DBFeatureItem mj_objectArrayWithKeyValuesArray:_model.goodsSpecVoList];
    _goodsSpecArr = [ProductInfoVoListModel mj_objectArrayWithKeyValuesArray:_model.productInfoVoList];
    [_tableView reloadData];
}
- (IBAction)addShoppingCarButton:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(addShoppongCarButtonOfAction)]) {
        [self.delegate addShoppongCarButtonOfAction];
    }
    
}
- (IBAction)nowBuyButton:(id)sender {
    if (self.goodsDetailsArr.count != 0) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(nowBuyButtonAndGoodsInfo:)]) {
            [self.delegate nowBuyButtonAndGoodsInfo:self.goodsDetailsArr];
        }
    }
}

@end
