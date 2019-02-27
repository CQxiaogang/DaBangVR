//
//  HorizontalCollectionView.h
//  DaBangVR
//
//  Created by mac on 2019/2/25.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, CollectionViewCellType){
    CountryCollectionViewCellType = 0,
    CountryGoodsCollectionViewCellllType,
    RecommendGoodsCollectionViewCellllType,
};

@protocol HorizontalCollectionViewDelegate <NSObject>

-(void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath collectionViewCellType:(CollectionViewCellType)type;
-(void)addShoppingCar:(UIButton *)sender didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HorizontalCollectionView : UICollectionView

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, assign) CollectionViewCellType type;

@property (nonatomic, weak) id <HorizontalCollectionViewDelegate> aDelegate;

/**
 初始化方法
 
 @param frame 大小
 @param layout 布局
 @param NibName 加载xib文件
 @param type 区分cell
 @return self
 */
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout nibWithNibName:(NSString *)NibName collectionViewCellType:(CollectionViewCellType)type;

@end

NS_ASSUME_NONNULL_END
