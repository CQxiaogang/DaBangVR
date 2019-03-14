//
//  DBDetailFooterView.h
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderSureModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol OrderSureFooterViewDelegate <NSObject>

- (void)leaveMessageBtnClickAction:(UIButton *)sender;

@end
@interface OrderSureFooterView : UITableViewHeaderFooterView
// 邮费
@property (weak, nonatomic) IBOutlet UILabel *postage;

@property (nonatomic, weak) id <OrderSureFooterViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
