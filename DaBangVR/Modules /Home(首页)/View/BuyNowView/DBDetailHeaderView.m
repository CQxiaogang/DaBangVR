//
//  DBDetailHeaderView.m
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "DBDetailHeaderView.h"

@implementation DBDetailHeaderView

- (IBAction)alterAction:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(informationModification)]) {
        [self.delegate informationModification];
    }
    
}


@end
