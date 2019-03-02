
//
//  SortSearchCollectionViewController.m
//  DaBangVR
//
//  Created by mac on 2019/3/2.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "SortSearchCollectionViewController.h"
// Views
#import "ShufflingView.h"
#import "SortSearchCollectionViewCell.h"
// Models
#import "GoodsDetailsModel.h"

@interface SortSearchCollectionViewController ()

@property (nonatomic, copy) NSArray *goodsData;

@end

@implementation SortSearchCollectionViewController

static NSString * const CellID = @"Cell";
static NSString * const headerCellID = @"headerCellID";

- (instancetype)init
{
    self = [super init];
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(kFit(172), kFit(235));
        layout.sectionInset = UIEdgeInsetsMake(0, KMargin, 0, KMargin);
        return [self initWithCollectionViewLayout:layout];
    }
    return self;
}

- (void)loadingData{
    NSDictionary *parameters = @{
                                 @"parentId":@"2",
                                 @"categoryId":@"1036112",
                                 @"page":@"1",
                                 @"limit":@"10"
                                 };
    [NetWorkHelper POST:URl_getGlobalList parameters:parameters success:^(id  _Nonnull responseObject) {
        
        NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
        // 推荐商品
        self.goodsData = [GoodsDetailsModel mj_objectArrayWithKeyValuesArray:data[@"goodsLists"]];
        [self.collectionView reloadData];
    } failure:^(NSError * _Nonnull error) { }];
 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadingData];
    
    self.collectionView.backgroundColor = KWhiteColor;
    [self.collectionView registerNib:[UINib nibWithNibName:@"SortSearchCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellID];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCellID];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _goodsData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SortSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    cell.model = _goodsData[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *header=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCellID forIndexPath:indexPath];
    [header addSubview: [[ShufflingView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, kFit(180)) andIndex:@"1"]];
    return header;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(KScreenW, kFit(190));
}

#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

- (void)listDidAppear {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)listDidDisappear {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}
@end
