//
//  morefunctionBtnView.h
//  DaBangVR
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBMoreFunctionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DBMoreFunctionBtnView : UIView

@property (weak, nonatomic) IBOutlet UIButton *moreFunctionButton;

@property (weak, nonatomic) IBOutlet UILabel  *moreFunctionLabel;

@property (strong, nonatomic)DBMoreFunctionModel *moreFunctionModel;

- (instancetype)initWithModel:(DBMoreFunctionModel *)model;

@end

NS_ASSUME_NONNULL_END
