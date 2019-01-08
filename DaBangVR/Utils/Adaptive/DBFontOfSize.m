//
//  DBFontOfSize.m
//  DaBangVR
//
//  Created by mac on 2018/12/8.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "DBFontOfSize.h"

@implementation UILabel(FixScreenFont)

/**
    根据不同设备尺寸显示字体大小
    @param fontSize 当前设备字体大小
 */
- (void)setAdaptiveFontSize:(float)fontSize{
    
    if (fontSize > 0 ) {
        self.font = [UIFont systemFontOfSize:C_WIDTH(fontSize)];
    }else{
        self.font = self.font;
    }
}
@end

@implementation UIButton(FixScreenFont)

/**
    根据不同设备尺寸显示字体大小
    @param fontSize 当前设备字体大小
 */
- (void)setAdaptiveFontSize:(float)fontSize{
    
    if (fontSize > 0 ) {
        self.titleLabel.font = [UIFont systemFontOfSize:C_WIDTH(fontSize)];
    }else{
        self.titleLabel.font = self.titleLabel.font;
    }
}

@end
