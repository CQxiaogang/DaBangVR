//
//  AnchorRecommendView.m
//  DaBangVR
//
//  Created by mac on 2019/1/12.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "AnchorRecommendView.h"
#import "AnchorViewCell.h"

@interface AnchorRecommendView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end
@implementation AnchorRecommendView

static NSString *CellID = @"CellID";
#pragma mark —— 懒加载
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        // 布局
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 每个cell的距离
        layout.minimumLineSpacing = 10;
        // 第一个cell和最后一个cell,与父控件之间的间距
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        //
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.mj_w,105) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = KWhiteColor;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"AnchorViewCell" bundle:nil] forCellWithReuseIdentifier:CellID];
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.collectionView];
        
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI{
    
    //设置更多热门直播按钮
    UIButton *moreAnchorBtn = [[UIButton alloc] init];
    [moreAnchorBtn setTitle:@"更多热门直播" forState:UIControlStateNormal];
    [moreAnchorBtn setTitleColor:[UIColor lightGreen] forState:UIControlStateNormal];
    moreAnchorBtn.titleLabel.adaptiveFontSize = 12;
    //设置按钮样式
    moreAnchorBtn.layer.cornerRadius = 10;
    moreAnchorBtn.layer.borderColor = [[UIColor lightGreen] CGColor];
    moreAnchorBtn.layer.borderWidth = 1.0f;
    moreAnchorBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:moreAnchorBtn];
    kWeakSelf(self);
    [moreAnchorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(weakself.collectionView.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
}

#pragma mark —— collection 代理/数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    if (!cell ) {
        NSLog(@"cell为空,创建cell");
        cell = [[AnchorViewCell alloc] init];
    }
    return cell;
}
// 每个cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake(80, 105);
}

@end
