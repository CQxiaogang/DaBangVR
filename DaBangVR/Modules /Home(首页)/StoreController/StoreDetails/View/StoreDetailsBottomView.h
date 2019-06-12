//
//  StoreDetailsBottomView.h
//  DaBangVR
//
//  Created by mac on 2019/5/29.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreDetailsShoppingCarModel.h"
#import "DeptDetailsModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol StoreDetailsBottomViewDelegate <NSObject>

-(void)shoppingCarButtonClick:(UIButton *)button;
//结算按钮
-(void)totalPriceButtonClick:(UIButton *)button;

@end

@interface StoreDetailsBottomView : UIView
@property (weak, nonatomic) IBOutlet UIButton *shoppingCarButton;
@property (weak, nonatomic) IBOutlet UIButton *totalPriceButton;
@property (weak, nonatomic) IBOutlet UILabel *goodsNumLabel;//商品数量
@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) id <StoreDetailsBottomViewDelegate> delegate;

@property (nonatomic, copy) NSArray <StoreDetailsShoppingCarModel*>*goodsData;

@property (nonatomic, strong) DeptDetailsModel *deptModel;
@property (nonatomic, assign) NSUInteger count;

@end

NS_ASSUME_NONNULL_END
