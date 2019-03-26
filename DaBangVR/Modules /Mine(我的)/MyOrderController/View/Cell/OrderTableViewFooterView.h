//
//  OrderTableViewFooterView.h
//  DaBangVR
//
//  Created by mac on 2019/3/26.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDeptGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol orderTableViewFooterViewDelegate <NSObject>

- (void)stateChangeOfButton:(NSString *)string;

@end
@interface OrderTableViewFooterView : UITableViewHeaderFooterView
//商品价格
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UIButton *stateChangeOfButton;

@property (nonatomic, strong) OrderDeptGoodsModel *depModel;

@property (nonatomic, strong) id<orderTableViewFooterViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
