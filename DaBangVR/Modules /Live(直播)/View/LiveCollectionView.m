//
//  LiveCollectionView.m
//  DaBangVR
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "LiveCollectionView.h"
#import "DBLayout.h"

@interface LiveCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>;
@property (nonatomic, strong)DBLayout *layout;
@property (nonatomic, copy) NSArray *highArr;
@end

@implementation LiveCollectionView
static NSString *const CellID = @"CellID";
#pragma mark —— 懒加载

-(DBLayout *)layout{
    if (!_layout) {
        _layout = [[DBLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _layout.itemCount = 10;
    }
    return _layout;
}
-(instancetype)init{
    self = [super initWithFrame:self.frame collectionViewLayout:self.layout];
    if (self) {
        self = [[LiveCollectionView alloc] initWithFrame:self.frame collectionViewLayout:self.layout];
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"LiveCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellID];
        self.backgroundColor = KWhiteColor;
        // 不显示滚动条
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    return cell;
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self ;
}
@end
