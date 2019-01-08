//
//  morefunctionBtnView.m
//  DaBangVR
//
//  Created by mac on 2018/11/20.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "DBMoreFunctionBtnView.h"


@implementation DBMoreFunctionBtnView

- (instancetype)initWithModel:(DBMoreFunctionModel *)model
{
    self = [super init];
    if (self) {
        
        _moreFunctionLabel.text = model.title;
        
    }
    return self;
}

@end
