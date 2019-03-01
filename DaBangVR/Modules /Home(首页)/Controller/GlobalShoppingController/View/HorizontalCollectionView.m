//
//  HorizontalCollectionView.m
//  DaBangVR
//
//  Created by mac on 2019/2/25.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "HorizontalCollectionView.h"
#import "CountryCollectionViewCell.h"
#import "CountryGoodsCollectionViewCell.h"
#import "RecommendGoodsCollectionViewCell.h"
#import "NewGoodsCollectionViewCell.h"

@interface HorizontalCollectionView  ()<UICollectionViewDelegate, UICollectionViewDataSource, CountryGoodsCollectionViewCellDelegate, RecommendGoodsCollectionViewCellDelegate>

@end

@implementation HorizontalCollectionView
static NSString *CellID = @"CellID";

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout nibWithNibName:(nonnull NSString *)NibName collectionViewCellType:(CollectionViewCellType)type{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        _type = type;
        self.dataSource = self;
        self.delegate = self;
        [self registerNib:[UINib nibWithNibName:NibName bundle:nil] forCellWithReuseIdentifier:CellID];
        self.backgroundColor = KWhiteColor;
        // 不显示滚动条
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _data.count? _data.count:3;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *MCell;
    switch (_type) {
        case CountryCollectionViewCellType:
        {
            CountryCollectionViewCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
            Cell.model = _data[indexPath.row];
            MCell = Cell;
        }
            break;
        case CountryGoodsCollectionViewCellllType:
        {
            CountryGoodsCollectionViewCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
            Cell.delegate = self;
            Cell.model = _data[indexPath.row];
            MCell = Cell;
        }
            break;
        case RecommendGoodsCollectionViewCellllType:
        {
            RecommendGoodsCollectionViewCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
            Cell.model = _data[indexPath.row];
            Cell.delegate = self;
            MCell = Cell;
        }
            break;
        case NewGoondsCollectionViewCellType:
        {
            NewGoodsCollectionViewCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
            Cell.model = _data[indexPath.row];
            MCell = Cell;
        }
            break;
        
        default:
            break;
    }
    
    return MCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.aDelegate && [self.aDelegate respondsToSelector:@selector(didSelectItemAtIndexPath:collectionViewCellType:)]) {
        [self.aDelegate didSelectItemAtIndexPath:indexPath collectionViewCellType:_type];
    }
}

-(void)setData:(NSArray *)data{
    if (data.count != 0) {
        _data = data;
        [self reloadData];
    }
}

#pragma mark —— CountryGoodsCollectionViewCell 代理
-(void)countryGoodsAddShoppingCar:(UIButton *)sender{
    // iOS中如何通过点击Cell中的Button来获取当前Cell的indexPath
    CountryGoodsCollectionViewCell *cell = (CountryGoodsCollectionViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (self.aDelegate && [self.aDelegate respondsToSelector:@selector(addShoppingCar:didSelectItemAtIndexPath:)]) {
        [_aDelegate addShoppingCar:sender didSelectItemAtIndexPath:indexPath];
    }
}
#pragma mark —— RecommendGoodsCollectionViewCell 代理
-(void)recommendGoodsAddShoppingCar:(UIButton *)sender{
    CountryGoodsCollectionViewCell *cell = (CountryGoodsCollectionViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (self.aDelegate && [self.aDelegate respondsToSelector:@selector(addShoppingCar:didSelectItemAtIndexPath:)]) {
        [_aDelegate addShoppingCar:sender didSelectItemAtIndexPath:indexPath];
    }
}

@end
