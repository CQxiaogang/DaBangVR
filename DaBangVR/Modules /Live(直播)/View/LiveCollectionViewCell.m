//
//  LiveCollectionViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "LiveCollectionViewCell.h"

@implementation LiveCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = KRandomColor;
}

@end
