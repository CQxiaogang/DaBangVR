//
//  LiveCollectionView.m
//  DaBangVR
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "LiveCollectionView.h"
#import "DBLayout.h"
// Models
#import "LiveModel.h"
/** Views */
#import "LiveCollectionViewCell.h"

@interface LiveCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>;
@property (nonatomic, strong)DBLayout *layout;
/** 数据源 */
@property (nonatomic, copy) NSArray *liveData;
@end

@implementation LiveCollectionView
static NSString *const CellID = @"CellID";
#pragma mark —— 懒加载
-(instancetype)initWithFrame:(CGRect)frame itemCount:(NSArray *)arr{
    _layout = [[DBLayout alloc] init];
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _layout.itemCount = (int)arr.count;
    self = [super initWithFrame:frame collectionViewLayout:_layout];
    if (self) {
        self = [[LiveCollectionView alloc] initWithFrame:self.frame collectionViewLayout:self.layout];
        self.delegate = self;
        self.dataSource = self;
        [self registerNib:[UINib nibWithNibName:@"LiveCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellID];
        self.backgroundColor = KWhiteColor;
        // 不显示滚动条
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        _liveData = arr;
    }
    return self;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _liveData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    cell.model = _liveData[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.MDelegate && [self.MDelegate respondsToSelector:@selector(collectionViewDidSelectItemAtIndexPath:)]) {
        [self.MDelegate collectionViewDidSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self ;
}
@end
