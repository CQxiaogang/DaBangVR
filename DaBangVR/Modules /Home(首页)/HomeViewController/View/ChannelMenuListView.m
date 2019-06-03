//
//  ChannelMenuListView.m
//  DaBangVR
//
//  Created by mac on 2019/1/10.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "ChannelMenuListView.h"

@interface ChannelMenuListView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *modelData;

@property (nonatomic ,strong) UICollectionView *collectionView;

@end

@implementation ChannelMenuListView

static NSString *CellID = @"CellID";
#pragma mark —— 懒加载
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        // 布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize =CGSizeMake(Adapt(47), Adapt(74));
        // 每个cell的距离
        layout.minimumLineSpacing = 11;
        layout.minimumInteritemSpacing = kFit(23);
        // 第一个cell和最后一个cell,与父控件之间的间距
        layout.sectionInset = UIEdgeInsetsMake(0, Adapt(23), 0, Adapt(23));
        //
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = KWhiteColor;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"ChannelViewCell" bundle:nil] forCellWithReuseIdentifier:CellID];
    }
    return _collectionView;
}

#pragma mark —— 系统方法
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
    }
    return self;
}

#pragma mark —— collection 代理/数据源

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChannelViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];;
    if (self.data) {
       cell.model = self.data[indexPath.row];
    }
    
    return cell;
}

-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(channelBtnOfClick:)]) {
        [self.delegate channelBtnOfClick:indexPath.row];
    }
}

- (void)setData:(NSArray *)data{
    _data = data;
    [self.collectionView reloadData];
}
@end
