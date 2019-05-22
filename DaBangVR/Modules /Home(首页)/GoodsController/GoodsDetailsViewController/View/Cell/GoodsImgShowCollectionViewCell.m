//
//  GoodsImgShowCollectionViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/5/22.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "GoodsImgShowCollectionViewCell.h"

@interface GoodsImgShowCollectionViewCell ()

@end

@implementation GoodsImgShowCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = self.bounds;
        [self addSubview:_imageView];
    }
    return self;
}

@end
