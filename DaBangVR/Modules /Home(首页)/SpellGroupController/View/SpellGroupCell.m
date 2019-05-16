//
//  SpellGroupCell.m
//  DaBangVR
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "SpellGroupCell.h"

@implementation SpellGroupCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _spellListBtn.layer.cornerRadius = kFit(8);
    _spellListBtn.layer.borderColor = [[UIColor lightGreen] CGColor];
    _spellListBtn.layer.borderWidth = 0.5f;
    _spellListBtn.layer.masksToBounds = YES;
    
}
- (IBAction)spellList:(id)sender {
}

- (void)setModel:(SpellGroupModel *)model{
    _model = model;
    [_goodsImgView setImageWithURL:[NSURL URLWithString:model.listUrl] placeholder:[UIImage imageNamed:@""]];
    _describeLab.text     = model.name;
    _sellingPriceLab.text = [NSString stringWithFormat:@"活动价:￥%@",model.sellingPrice];
    _marketPriceLab.text  = [NSString stringWithFormat:@"原价:￥%@",model.marketPrice];
}

@end
