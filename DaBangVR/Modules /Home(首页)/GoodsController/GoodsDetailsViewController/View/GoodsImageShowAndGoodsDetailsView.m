//
//  GoodsImageShowView.m
//  DaBangVR
//
//  Created by mac on 2019/5/22.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "GoodsImageShowAndGoodsDetailsView.h"
#import "PagingEnableLayout.h"
#import "GoodsImgShowCollectionViewCell.h"
#import "GoodsDetailsImageModel.h"
#import "GoodsInfoView.h"

static NSString *const cellID = @"cellID";

@interface GoodsImageShowAndGoodsDetailsView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) GoodsInfoView *goodsInfoView;

@property (nonatomic, strong) NSArray<GoodsDetailsImageModel *> *dataSource;

@end

@implementation GoodsImageShowAndGoodsDetailsView

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        //布局
        PagingEnableLayout *layout;
        layout                     = [[PagingEnableLayout alloc] init];
        layout.itemWidth           = 300;
        layout.itemHeight          = 350;
        layout.scrollDirection     = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView                 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 300) collectionViewLayout:layout];
        _collectionView.delegate        = self;
        _collectionView.dataSource      = self;
        _collectionView.pagingEnabled   = YES;
        _collectionView.backgroundColor = KClearColor;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[GoodsImgShowCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}

-(GoodsInfoView *)goodsInfoView{
    if (!_goodsInfoView) {
        _goodsInfoView = [[[NSBundle mainBundle] loadNibNamed:@"GoodsInfoView" owner:nil options:nil] firstObject];
    }
    return _goodsInfoView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.collectionView];
        
        [self addSubview:self.goodsInfoView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    kWeakSelf(self);
    [self.goodsInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(weakself.collectionView.mas_bottom).offset(0);
        make.height.equalTo(120);
    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GoodsImgShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell.imageView setImageURL:[NSURL URLWithString:_dataSource[indexPath.row].chartUrl]];
    return cell;
}

- (void)setImgList:(NSArray *)imgList{
    _imgList  = imgList;
}

-(void)setGoodsModel:(GoodsDetailsModel *)goodsModel{
    _goodsModel = goodsModel;
    NSArray *dataSource = [GoodsDetailsImageModel mj_objectArrayWithKeyValuesArray:_goodsModel.imgList];
    _dataSource = dataSource;
    
    self.goodsInfoView.goodsModel = goodsModel;
    
    [self.collectionView reloadData];
}

@end
