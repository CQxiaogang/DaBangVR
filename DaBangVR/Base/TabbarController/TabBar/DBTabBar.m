//
//  DBTabBar.m
//  DaBangVR
//
//  Created by mac on 2018/11/17.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "DBTabBar.h"

@interface DBTabBar ()
//自定义动态发布按钮
@property(nonatomic , strong) UIButton *releaseButton;

@end

@implementation DBTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        UIButton *releaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [releaseButton setBackgroundImage:[UIImage imageNamed:@"h_shot"] forState:UIControlStateNormal];
        
        CGFloat releaseBtW = 50;
        
        releaseButton.bounds = CGRectMake(0,0,releaseBtW,releaseBtW);
        //设置button 样式
        [releaseButton.layer setMasksToBounds:YES];
        
        [releaseButton.layer setCornerRadius:releaseButton.frame.size.width/2];
        
        [releaseButton addTarget:self action:@selector(releaseButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:releaseButton];
        
        self.releaseButton = releaseButton;
        
        [self setTintColor:[UIColor lightGreen]];

        
    }
    return self;
}

- (void)releaseButtonClick{
    
}

#pragma mark  - 系统方法
-(void)layoutSubviews{
    [super layoutSubviews];
    // 先设置中间按钮的位置
    self.releaseButton.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2-10);
    // 计算每个按钮的宽度
    CGFloat tabBarButtonW = self.frame.size.width / 5;
    // CGFloat tabBarButtonH = 40;
    CGFloat tabBarButtonIndex = 0;
    
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.frame = CGRectMake(tabBarButtonIndex * tabBarButtonW, 0, tabBarButtonW, self.frame.size.height);
            tabBarButtonIndex++;
            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex++;
            }
        }
    }
}

#pragma mark - 自定义方法
- (void)customButtonClick {
    //遵守代理
    if ([self.myDelegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.myDelegate tabBarDidClickPlusButton:self];
    }
}

@end
