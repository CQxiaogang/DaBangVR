//
//  StoreBaseTopTableViewCell.m
//  DaBangVR
//
//  Created by mac on 2019/5/27.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "StoreBaseTopTableViewCell.h"

@implementation StoreBaseTopTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.shufflingView];
    [self addSubview:self.categoryChooseView];
    [self addSubview:self.recommendLabel];
}
#pragma mark —— 懒加载
-(ShufflingView *)shufflingView{
    if (!_shufflingView) {
        _shufflingView = [[ShufflingView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 180) andIndex:@"1"];
    }
    return _shufflingView;
}

-(CategoryChooseView *)categoryChooseView{
    if (!_categoryChooseView) {
        _categoryChooseView = [[CategoryChooseView alloc] init];
        _categoryChooseView.frame = CGRectMake(0, CGRectGetMaxY(self.shufflingView.frame), KScreenW, 100);
    }
    return _categoryChooseView;
}

-(UILabel *)recommendLabel{
    if (!_recommendLabel) {
        _recommendLabel                  = [UILabel new];
        _recommendLabel.frame            = CGRectMake(0, CGRectGetMaxY(self.categoryChooseView.frame), KScreenW, 20);
        _recommendLabel.text             = @"——— 推荐商家 ———";
        _recommendLabel.textColor        = KGrayColor;
        _recommendLabel.textAlignment    = NSTextAlignmentCenter;
        _recommendLabel.adaptiveFontSize = 12;
    }
    return _recommendLabel;
}

@end
