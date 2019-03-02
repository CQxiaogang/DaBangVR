//
//  prefectureView.m
//  DaBangVR
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "HomeNewAndHotGoodsView.h"

@interface HomeNewAndHotGoodsView (){

}

@end

@implementation HomeNewAndHotGoodsView

-(void)awakeFromNib{
    [super awakeFromNib];
}

- (IBAction)showMoreGoodsBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(showMoreGoods:)]) {
        [self.delegate showMoreGoods:sender];
    }
}

@end
