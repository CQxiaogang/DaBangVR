//
//  StoreDetailsBottomView.h
//  DaBangVR
//
//  Created by mac on 2019/5/29.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol StoreDetailsBottomViewDelegate <NSObject>

-(void)shoppingCarButtonClick:(UIButton *)button;

@end

@interface StoreDetailsBottomView : UIView
@property (weak, nonatomic) IBOutlet UIButton *shoppingCarButton;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

@property (weak, nonatomic) id <StoreDetailsBottomViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
