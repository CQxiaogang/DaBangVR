//
//  DBDetailFooterView.h
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BuyNowModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol DetailFooterViewDelegate <NSObject>

- (void)leaveMessageBtnClickAction;

@end
@interface DBDetailFooterView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) BuyNowModel *model;
@property (nonatomic, weak) id <DetailFooterViewDelegate> aDelegate;

@end

NS_ASSUME_NONNULL_END
