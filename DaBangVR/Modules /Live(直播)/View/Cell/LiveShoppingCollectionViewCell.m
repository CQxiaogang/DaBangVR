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
#import "CollectionHeaderLayout.h"
#import "FeatureItemCell.h"
#import "FeatureHeaderView.h"
/** 增减数量控件 */
#import "PPNumberButton.h"


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
        [_tableView registerNib:[UINib nibWithNibName:@"LiveGoddsInfoTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
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
//        lastNum = (lastNum == 0) ? 1:lastNum;
//        _numberButton.currentNumber = lastNum;
//        kWeakSelf(self);
        _numberButton.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
            lastNum = num;
        };
    }
    return _numberButton;
}

#pragma mark —— 系统方法
- (void)awakeFromNib {
    [super awakeFromNib];
    //设置UI
    [self setupUI];
}

-(void)setupUI{
    kWeakSelf(self);
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(0);
        make.height.equalTo(70);
    }];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(weakself.tableView.mas_bottom).offset(0);
        make.bottom.equalTo(weakself.addShoppingCarBtn.mas_top).offset(0);
    }];
}

#pragma mark —— UITableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveGoddsInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(70);
}

#pragma mark —— UICollectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 3-1) {
        return 1;
    }else{
        return 3;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FeatureItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FeatureItemCellID forIndexPath:indexPath];
    cell.backgroundColor = KRandomColor;
    if (indexPath.section == 2) {
        cell.backgroundColor = KClearColor;
        [cell setWidth:KScreenW];
        [cell addSubview:self.numberButton];
    }
    
    return cell;
}

#pragma mark —— HorizontalCollectionLayoutDelegate
-(NSString *)collectionViewItemSizeWithIndexPath:(NSIndexPath *)indexPath{
    return @"测试";
}

@end
