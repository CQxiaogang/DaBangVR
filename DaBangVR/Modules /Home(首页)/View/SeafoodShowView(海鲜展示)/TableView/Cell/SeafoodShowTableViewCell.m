//
//  BaseTableViewCell.m
//  DaBangVR
//
//  Created by mac on 2018/12/24.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "SeafoodShowTableViewCell.h"

@implementation SeafoodShowTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
//    [_headImgView setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1503377311744&di=a784e64d1cce362c663f3480b8465961&imgtype=0&src=http%3A%2F%2Fww2.sinaimg.cn%2Flarge%2F85cccab3gw1etdit7s3nzg2074074twy.jpg"] placeholder:[UIImage imageNamed:@"zhanweifu"]];
}

- (void)setModel:(SeafoodShowListModel *)model{
    [_headImgView setImageWithURL:[NSURL URLWithString:model.listUrl] placeholder:[UIImage imageNamed:@"zhanweifu"]];
    _describeLabel.text = model.describe;
    _sellingPriceLabel.text = [NSString stringWithFormat:@"%ld",(long)model.sellingPrice];
}

@end
