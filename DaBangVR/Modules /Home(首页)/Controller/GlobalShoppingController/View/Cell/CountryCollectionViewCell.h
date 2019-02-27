//
//  CountryCollectionViewCell.h
//  DaBangVR
//
//  Created by mac on 2019/2/25.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CountryCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@property (nonatomic, strong) CountryListModel *model;

@end

NS_ASSUME_NONNULL_END
