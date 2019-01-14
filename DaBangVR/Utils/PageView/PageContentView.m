//
//  PageContentView.m
//  Demo
//
//  Created by mac on 2018/11/26.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "PageContentView.h"

static NSString * const CellID = @"Cell";

@interface PageContentView(){
    
    CGRect _frame;
    
    CGFloat startOffsetX;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSArray *childVs;


@end
@implementation PageContentView

static int _index;

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:self.layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces = NO;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellID];
    }
    return _collectionView;
}

-(UICollectionViewLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        
        _layout.itemSize = self.bounds.size;
        
        _layout.minimumLineSpacing = 0;
        
        _layout.minimumInteritemSpacing = 0;
        
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}

- (instancetype)initWithFrame:(CGRect)frame childSv:(NSMutableArray *)childList{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.childVs = childList;
        
        [self addSubview:self.collectionView];
        
    }
    return self;
}

#pragma mark -遵守UICollectionViewDatraSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.childVs.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    
    [cell addSubview:self.childVs[indexPath.row]];
    
    return cell;
}

#pragma mark -遵守UICollectionViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 1.获取需要的数据（根据cell在collectionview的偏移量，计算得到下面3个数据）
    /**
     *  具体思路看
     *  https://study.163.com/course/courseLearn.htm?courseId=1003309014#/learn/video?lessonId=1003765409&courseId=1003309014
     *
     */
    CGFloat progress = 0;
    int sourceIndex = 0; //原来的
    int targetIndex = 0; //目标的
    // 2.判断左滑 还有右滑
    
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollViewW = scrollView.bounds.size.width;
    if (currentOffsetX > startOffsetX) { //左滑
        
        //  1. 计算progress
        //floor 函数，为取整函数
        progress = currentOffsetX / scrollViewW  - floor(currentOffsetX / scrollViewW);
        // 2.计算sourceIndex
        sourceIndex = currentOffsetX / scrollViewW;
        
        // 3.计算targetIndex
        targetIndex = sourceIndex + 1;
        if (targetIndex >= self.childVs.count) {
            targetIndex = (int)self.childVs.count - 1;
        }
        
        //4.完全划过去
        if (currentOffsetX - startOffsetX == scrollViewW) {
            progress = 1.0;
            targetIndex = sourceIndex;
        }
        
    }else{ //右滑
        //  1. 计算progress
        progress = 1 - (currentOffsetX / scrollViewW  - floor(currentOffsetX / scrollViewW));
        
        // 2.计算targetIndex
        targetIndex = currentOffsetX / scrollViewW;
        
        // 3.计算sourceIndex
        sourceIndex = targetIndex + 1;
        if (sourceIndex >= self.childVs.count) {
            sourceIndex = (int)self.childVs.count - 1;
        }
    }
    
    // 3.讲progress，targetIndex，sourceIndex传递给titleView
    
    [self.delegate pageContentView:self progress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
    _index = targetIndex;
}
// 已经停止滚动
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.delegate itemDidSelectedWithIndex:_index];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //获取偏移的 X 的值
    startOffsetX = scrollView.contentOffset.x;
}

- (UIColor *)randomColor{
    
    return [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
}

- (void)setCurrentIndex:(int)index{
    
    CGFloat offSetX = index * self.collectionView.frame.size.width;
    
    [self.collectionView setContentOffset:CGPointMake(offSetX, 0) animated:NO];
}

@end
