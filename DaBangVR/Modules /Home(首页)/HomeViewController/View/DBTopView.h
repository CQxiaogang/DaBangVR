//
//  DBTopView.h
//  DaBangVR
//
//  Created by mac on 2018/12/8.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TopViewDelegate <NSObject>
// 购物车点击事件
- (void)shoppingCarClickAction;

@end

@interface DBTopView : UIView
@property (weak, nonatomic) IBOutlet UIButton *location;    // 定位
@property (weak, nonatomic) IBOutlet UIButton *shoppingCart;// 购物车
@property (weak, nonatomic) IBOutlet UIButton *search;      // 搜索
@property (weak, nonatomic) IBOutlet UIButton *QRCode;      // 二维码
@property (weak, nonatomic) IBOutlet UIView   *searchBox;   // 搜索框

@property (nonatomic, weak) id <TopViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
