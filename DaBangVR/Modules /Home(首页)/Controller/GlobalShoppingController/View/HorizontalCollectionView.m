//
//  HorizontalCollectionView.m
//  DaBangVR
//
//  Created by mac on 2019/2/25.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "HorizontalCollectionView.h"
#import "CountryCollectionViewCell.h"

@interface HorizontalCollectionView  ()<UICollectionViewDelegate, UICollectionViewDataSource>



@end

@implementation HorizontalCollectionView
static NSString *CellID = @"CellID";

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout nibWithNibName:(nonnull NSString *)NibName{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {

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
    
    return 15;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    if (!cell ) {
        NSLog(@"cell为空,创建cell");
        cell = [[UICollectionViewCell alloc] init];
    }
    return cell;
}

@end
