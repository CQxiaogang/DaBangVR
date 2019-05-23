//
//  CommentShowView.m
//  DaBangVR
//
//  Created by mac on 2019/5/22.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "CommentShowView.h"

@implementation CommentShowView

- (void)setModel:(GoodsDetailsModel *)model{
    _sellNumLabel.text = [NSString stringWithFormat:@"销售(%@)",model.salesVolume];
}

@end
