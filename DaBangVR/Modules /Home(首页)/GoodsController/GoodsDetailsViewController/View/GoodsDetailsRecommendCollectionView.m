//
//  GoodsDetailsRecommendCollectionView.m
//  DaBangVR
//
//  Created by mac on 2019/5/22.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "GoodsDetailsRecommendCollectionView.h"
#import "GoodsRecommendCollectionViewCell.h"

static NSString *const cellID = @"cellID";

@implementation GoodsDetailsRecommendCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.dataSource = self;
        self.delegate   = self;
        self.backgroundColor = KWhiteColor;
        [self registerNib:[UINib nibWithNibName:@"GoodsRecommendCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    }
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _recomentdDataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsRecommendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = _recomentdDataSource[indexPath.row];
    return cell;
}

-(void)setRecomentdDataSource:(NSArray *)recomentdDataSource{
    _recomentdDataSource = recomentdDataSource;
    [self reloadData];
}

@end
