//
//  AllOrdersCell.h
//  DaBangVR
//
//  Created by mac on 2019/1/9.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol allOrdersCellDelegate <NSObject>

- (void)lowerRightCornerClickEvent:(NSString *)string;

@end

@interface AllOrdersCell : BaseTableViewCell
// 右下角 button
@property (weak, nonatomic) IBOutlet UIButton *lowerRightCornerBtn;

@property (nonatomic, strong) id<allOrdersCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
