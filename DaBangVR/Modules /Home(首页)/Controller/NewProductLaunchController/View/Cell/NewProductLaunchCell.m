//
//  NewProductLaunchCell.m
//  DaBangVR
//
//  Created by mac on 2019/1/29.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "NewProductLaunchCell.h"
#import "HorizontalCollectionView.h"

@interface NewProductLaunchCell ()<HorizontalCollectionViewDelegate>

@property (nonatomic, strong) HorizontalCollectionView *collectionView;

@end

@implementation NewProductLaunchCell

#pragma mark —— 懒加载
- (HorizontalCollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置UICollectionView为横向滚动
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 每一行cell之间的间距
        layout.minimumLineSpacing = kFit(10);
        // 设置第一个cell和最后一个cell,与父控件之间的间距
        layout.sectionInset = UIEdgeInsetsMake(0, KMargin, 0, KMargin);
        layout.itemSize = CGSizeMake(kFit(173), kFit(230));
        _collectionView = [[HorizontalCollectionView alloc] initWithFrame:CGRectMake(0, _goodsNum.mj_y+_goodsNum.mj_h+KMargin, KScreenW, kFit(230)) collectionViewLayout:layout nibWithNibName:@"NewGoodsCollectionViewCell" collectionViewCellType:NewGoondsCollectionViewCellType];
        _collectionView.aDelegate = self;
    }
    return _collectionView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addSubview:self.collectionView];
}

- (void)setModel:(NewGoodsModel *)model{
    _model = model;
    [_backgroundImg setImageURL:[NSURL URLWithString:model.categoryImg]];
    _goodsNum.text = [NSString stringWithFormat:@"查看全部%@种商品 >",model.count];
    self.collectionView.data = model.data;
}

#pragma mark —— HorizontalCollectionView 代理
-(void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath collectionViewCellType:(CollectionViewCellType)type{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndexPath:tableViewCell:)]) {
        [self.delegate didSelectItemAtIndexPath:indexPath tableViewCell:self];
    }
    
}

@end
