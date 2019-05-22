//
//  PagingEnableLayout.m
//  CollectionViewPagingEnable
//
//  Created by Ray on 2018/7/17.
//  Copyright © 2018年 com.collectionView.pagingEnable. All rights reserved.
//

#import "PagingEnableLayout.h"
#import <objc/message.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation PagingEnableLayout

- (void)prepareLayout{
    [super prepareLayout];
    //屏幕宽去掉中间的cell宽度的大小
    CGFloat contentInset = ScreenWidth-round(_itemWidth*KScreenW/KScreenW);
    self.itemSize = CGSizeMake(_itemWidth, _itemHeight);
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, contentInset*0.5, 0, contentInset*0.5);
    if ([self.collectionView respondsToSelector:NSSelectorFromString(@"_setInterpageSpacing:")]) {
        ((void(*)(id,SEL,CGSize))objc_msgSend)(self.collectionView,NSSelectorFromString(@"_setInterpageSpacing:"),CGSizeMake(-(contentInset-self.minimumInteritemSpacing), 0));
    }
    if ([self.collectionView respondsToSelector:NSSelectorFromString(@"_setPagingOrigin:")]) {
        ((void(*)(id,SEL,CGPoint))objc_msgSend)(self.collectionView,NSSelectorFromString(@"_setPagingOrigin:"),CGPointMake(-contentInset*0.5, 0));
    }
}

@end
