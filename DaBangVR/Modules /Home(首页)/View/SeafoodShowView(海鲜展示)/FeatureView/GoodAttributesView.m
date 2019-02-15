//
//  GoodAttributesView.m
//  AiMeiBang
//
//  Created by Lingxiu on 16/1/25.
//  Copyright © 2016年 zym. All rights reserved.
//

#import "GoodAttributesView.h"
#import "UIButton+Bootstrap.h"
#import "UIImageView+WebCache.h"
#import "DBCollectionHeaderLayout.h"
// Views
#import "DBFeatureItemCell.h"
#import "DBFeatureHeaderView.h"
#import "DBFeatureChoseTopCell.h"
#import "GoodsInfoView.h"
// Models
#import "DBFeatureItem.h"
#import "ProductInfoVoListModel.h"
// Vendors
#import "MJExtension.h"
#import "Masonry.h"
#import "PPNumberButton.h"

@interface GoodAttributesView ()
<
 HorizontalCollectionLayoutDelegate,
 UICollectionViewDelegate,
 UICollectionViewDataSource,
 PPNumberButtonDelegate,
 UITableViewDelegate,
 UITableViewDataSource,
 UIGestureRecognizerDelegate
>
{
    UIButton *_selectedButton;
    NSMutableArray *_mutableArr;
    UILabel *_firstAttributeLbl;
    UILabel *_secondAttributeLbl;
    NSString *_goods_attr_value_1;
    NSString *_goods_attr_value_2;
    BOOL isFirst;
}
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *iconBackView;
@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *goodsNameLbl;
@property (nonatomic, strong) UILabel *goodsPriceLbl;
@property (nonatomic, strong) UIButton *XBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) PPNumberButton *numberButton;
/** 购买数量Lbl */
@property (nonatomic, strong) UILabel *buyNumsLbl;
// 放置属性的scrollView
@property (nonatomic, strong) UIScrollView *scrollView;
// 存放buttons的数组
@property (nonatomic, strong) NSMutableArray *firstBtnsArr;
@property (nonatomic, strong) NSMutableArray *secondBtnsArr;
/*contionView*/
@property (nonatomic, strong) UICollectionView *collectionView;
/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* 商品规格展示的数据 */
@property (strong , nonatomic)NSMutableArray <DBFeatureItem *> *featureAttr;
/* 商品规格数据 */
@property (strong , nonatomic)NSMutableArray <ProductInfoVoListModel *> *goodsSpecArr;
/* 选择属性 */
@property (strong , nonatomic)NSMutableArray *seleArray;
/* 商品选择结果Cell */
@property (weak , nonatomic)DBFeatureChoseTopCell *cell;
@property (strong, nonatomic) NSMutableArray *goodsDetailsArr;
@end
@implementation GoodAttributesView

//static NSInteger num_;
static NSString *const DBFeatureItemCellID = @"DBFeatureItemCell";
static NSString *const DBFeatureHeaderViewID = @"DBFeatureHeaderView";
static NSString *const DBFeatureChoseTopCellID = @"DBFeatureChoseTopCell";

#pragma mark —— 懒加载
- (NSMutableArray *)firstBtnsArr
{
    if (!_firstBtnsArr) {
        self.firstBtnsArr  = [[NSMutableArray alloc] init];
    }
    return _firstBtnsArr;
}
- (NSMutableArray *)secondBtnsArr
{
    if (!_secondBtnsArr) {
        self.secondBtnsArr  = [[NSMutableArray alloc] init];
    }
    return _secondBtnsArr;
}
- (int)buyNum
{
    if (!_buyNum) {
        self.buyNum = 1;
    }
    return _buyNum;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        DBCollectionHeaderLayout *layout = [DBCollectionHeaderLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
         _collectionView.backgroundColor = [UIColor whiteColor];
        
        // 自定义layout初始化
        layout.delegate = self;
        layout.lineSpacing = 8.0;
        layout.interitemSpacing = 10;
        layout.headerViewHeight = 35;
        layout.footerViewHeight = 5;
//        layout.itemInset = UIEdgeInsetsMake(0, 10, 0, 10);
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        _collectionView.alwaysBounceVertical = YES;
        
        [_collectionView registerClass:[DBFeatureItemCell class] forCellWithReuseIdentifier:DBFeatureItemCellID]; //cell
        [_collectionView registerClass:[DBFeatureHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DBFeatureHeaderViewID]; //头部
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"]; //尾部
    }
    return _collectionView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.frame = CGRectMake(0, 0, KScreenW, 100);
        _tableView.rowHeight = 100;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[DBFeatureChoseTopCell class] forCellReuseIdentifier:DBFeatureChoseTopCellID];
    }
    return _tableView;
}

- (UIView *)contentView{
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

- (UIView *)iconBackView{
    if (!_iconBackView) {
        _iconBackView = [[UIView alloc] initWithFrame:(CGRect){10, -15, 90, 90}];
        _iconBackView.backgroundColor = KWhiteColor;
        _iconBackView.layer.borderColor = KBorderColor.CGColor;
        _iconBackView.layer.borderWidth = 1;
        _iconBackView.layer.cornerRadius = 3;
    }
    return _iconBackView;
}

- (UIImageView *)iconImgView{
    if (!_iconImgView) {
        
        _iconImgView = [[UIImageView alloc] initWithFrame:(CGRect){5, 5, 80, 80}];
        
        [_iconImgView setImage:[UIImage imageNamed:@"theDefaultAvatar"]];
    }
    return _iconImgView;
}

-(UIButton *)XBtn{
    if (!_XBtn) {
        _XBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _XBtn.frame = CGRectMake(KScreenW - 30, 10, 20, 20);
        [_XBtn setBackgroundImage:[UIImage imageNamed:@"comeBack-x"] forState:UIControlStateNormal];
        [_XBtn addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _XBtn;
}

- (UILabel *)goodsNameLbl{
    if (!_goodsNameLbl) {
        _goodsNameLbl = [[UILabel alloc] init];
        _goodsNameLbl.text = @"商品名字";
        _goodsNameLbl.textColor = KRedColor;
        _goodsNameLbl.font = [UIFont systemFontOfSize:15];
        CGFloat goodsNameLblX = CGRectGetMaxX(self.iconBackView.frame) + 10;
        CGFloat goodsNameLblY = self.XBtn.frame.origin.y;
        CGSize size = [_goodsNameLbl.text sizeWithAttributes:@{NSFontAttributeName :_goodsNameLbl.font}];
        _goodsNameLbl.frame = (CGRect){goodsNameLblX, goodsNameLblY, size};
    }
    return _goodsNameLbl;
}
- (UILabel *)goodsPriceLbl{
    if (!_goodsPriceLbl) {
        _goodsPriceLbl = [[UILabel alloc] initWithFrame:(CGRect){self.goodsNameLbl.frame.origin.x, CGRectGetMaxY(self.goodsNameLbl.frame) + 10, 150, 20}];
        _goodsPriceLbl.text = @"99元";
        _goodsPriceLbl.backgroundColor = KRedColor;
        _goodsPriceLbl.font = [UIFont systemFontOfSize:15];
    }
    return _goodsNameLbl;
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
- (NSMutableArray *)goodsDetailsArr{
    if (!_goodsDetailsArr) {
        _goodsDetailsArr = [NSMutableArray new];
    }
    return _goodsDetailsArr;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self awakeFromNib];
        
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5];
    
    [self setupBasicView];
    
    [self setUpBase];
}

- (void)setupBasicView {
    // 添加手势，点击背景视图消失
    /** 使用的时候注意名字不能用错，害我定格了几天才发现。FK
     UIGestureRecognizer
     UITapGestureRecognizer // 点击手势
     UISwipeGestureRecognizer // 轻扫手势
     */
    UITapGestureRecognizer *tapBackGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [self addGestureRecognizer:tapBackGesture];
    
    [self addSubview:self.contentView];
    
    [self.contentView addSubview:self.tableView];
    
    [self.contentView addSubview:self.collectionView];
    
    [self.contentView addSubview:self.numLabel];
    
    [self.contentView addSubview:self.numberButton];
    
    [self.contentView addSubview:self.sureBtn];
    
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

- (void)setUpBase{
    
    // collectionView 里面的数据
//    _featureAttr = [DBFeatureItem mj_objectArrayWithFilename:@"ShopItem.plist"];
    if (lastSeleArray.count == 0) return;
    for (NSString *str in lastSeleArray) {//反向遍历（赋值）
        for (NSInteger i = 0; i < _featureAttr.count; i++) {
            for (NSInteger j = 0; j < _featureAttr[i].goodsSpecList.count; j++) {
                if ([_featureAttr[i].goodsSpecList[j].value isEqualToString:str]) {
                    _featureAttr[i].goodsSpecList[j].isSelect = YES;
                    [self.collectionView reloadData];
                }
            }
        }
    }
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _featureAttr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _featureAttr[section].goodsSpecList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DBFeatureItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DBFeatureItemCellID forIndexPath:indexPath];
    cell.content = _featureAttr[indexPath.section].goodsSpecList[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind  isEqualToString:UICollectionElementKindSectionHeader]) {
        DBFeatureHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DBFeatureHeaderViewID forIndexPath:indexPath];
        headerView.headTitle = _featureAttr[indexPath.section].name;
        return headerView;
    }else {
        
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter" forIndexPath:indexPath];
        return footerView;
    }
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
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
                lastSeleArray = nil;
            }
        }
    }
    // 数组中的元素呼唤位置
    if (_seleArray.count == 2) {
        [_seleArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
    }
    //刷新tableView和collectionView
    [self.collectionView reloadData];
    [self.tableView reloadData];
}

#pragma mark - <HorizontalCollectionLayoutDelegate>
#pragma mark - 自定义layout必须实现的方法
- (NSString *)collectionViewItemSizeWithIndexPath:(NSIndexPath *)indexPath {
    DBFeatureItem *item = _featureAttr[indexPath.section];
    DBFeatureList *list = item.goodsSpecList[indexPath.row];
    return list.value;
}

#pragma mark —— UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DBFeatureChoseTopCell *cell = [tableView dequeueReusableCellWithIdentifier:DBFeatureChoseTopCellID forIndexPath:indexPath];
    // cell不能点击
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _cell = cell;
    
    if (_seleArray.count != _featureAttr.count && lastSeleArray.count != _featureAttr.count) {
        [cell.goodImageView setImageWithURL:[NSURL URLWithString:_model.listUrl] placeholder:[UIImage imageNamed:@""]];
        cell.inventoryLabel.text = [NSString stringWithFormat:@"库存 %@ 件",_model.remainingInventory];
        cell.goodPriceLabel.text = [NSString stringWithFormat:@"¥ %.1f",[_model.sellingPrice floatValue]*lastNum];
        cell.chooseAttLabel.text = @"请选择 颜色 尺码";
        
    }else {
        cell.chooseAttLabel.textColor = [UIColor darkGrayColor];
        
        NSString *attString = (_seleArray.count == _featureAttr.count) ? [_seleArray componentsJoinedByString:@"_"] : [lastSeleArray componentsJoinedByString:@"_"];
        
        for (ProductInfoVoListModel *model in _goodsSpecArr) {
            if ([attString isEqualToString:model.goodsSpecIds]) {
                cell.chooseAttLabel.text = [NSString stringWithFormat:@"已选属性：%@",model.name];
                cell.inventoryLabel.text = [NSString stringWithFormat:@"库存 %@ 件",model.number];
                cell.goodPriceLabel.text = [NSString stringWithFormat:@"¥ %.1f",[model.retailPrice floatValue]*lastNum];
                
                [self.goodsDetailsArr removeAllObjects];
                [self.goodsDetailsArr addObject:model.id];
                [self.goodsDetailsArr addObject:model.goodsId];
            }
        }
        // 没有规格的时候
        if (_featureAttr.count == 0) {
            [cell.goodImageView setImageWithURL:[NSURL URLWithString:_model.listUrl] placeholder:[UIImage imageNamed:@""]];
            cell.inventoryLabel.text = [NSString stringWithFormat:@"库存 %@ 件",_model.remainingInventory];
            NSInteger price = [_model.sellingPrice integerValue];
            cell.goodPriceLabel.text = [NSString stringWithFormat:@"¥ %ld",price*lastNum];
            cell.chooseAttLabel.text = _model.title;
            [self.goodsDetailsArr addObject:_model.id];
        }
        // 选择的数量
        [self.goodsDetailsArr addObject:[NSString stringWithFormat:@"%ld",lastNum]];
    }
    kWeakSelf(self)
    cell.crossButtonClickBlock = ^{
        [weakself removeView];
    };
    return cell;
}

#pragma mark —— gestureRecognizer 代理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view != self.contentView) {
        return NO;
    }else{
        return YES;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}
/**
 *  设置视图的基本内容
 */

- (void)setGood_img:(NSString *)good_img {
    _good_img = good_img;
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:good_img] placeholderImage:nil];
}
- (void)setGood_name:(NSString *)good_name {
    _good_name = good_name;
    self.goodsNameLbl.text = good_name;
}
- (void)setGood_price:(NSString *)good_price {
    _good_price = good_price;
    self.goodsPriceLbl.text = [NSString stringWithFormat:@"%@元", good_price];
}

- (void)setModel:(GoodsDetailsModel *)model{
    _model = model;
    
    _featureAttr  = [DBFeatureItem mj_objectArrayWithKeyValuesArray:_model.goodsSpecVoList];
    
    _goodsSpecArr = [ProductInfoVoListModel mj_objectArrayWithKeyValuesArray:_model.productInfoVoList];
    
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

- (void)removeView {
    __weak typeof(self) _weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        _weakSelf.backgroundColor = [UIColor clearColor];
        _weakSelf.contentView.frame = CGRectMake(0, KScreenH, KScreenW, kATTR_VIEW_HEIGHT);
    } completion:^(BOOL finished) {
        [_weakSelf removeFromSuperview];
    }];
}

#pragma mark - 按钮点击事件
// 确定商品属性选择
- (void)sureBtnClick {
    if (_seleArray.count != _featureAttr.count &&  lastSeleArray.count != _featureAttr.count) {//未选择全属性警告
        [SVProgressHUD showInfoWithStatus:@"请选择全属性"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:1.0];
        return;
    }
    // 退出视图
    [self removeView];
    // 回掉
    if (self.goodsDetailsArr.count) {
        if (self.goodsAttributesBlock != nil) {
            self.goodsAttributesBlock(self.goodsDetailsArr);
        }
    }
    // 记录选择的商品数据
    if (lastSeleArray.count == 0) {
        lastSeleArray = self.seleArray;
    }
}

@end
