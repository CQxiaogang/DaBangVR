//
//  RootNavigationController.m
//  DaBangVR
//
//  Created by mac on 2018/12/20.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "RootNavigationController.h"

@implementation RootNavigationController

-(void)viewDidLoad{
    
    // 让背景不透明
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    // 背景颜色
    self.navigationBar.backgroundColor = [UIColor lightGreen];
    // 设置左边 button 颜色
    self.navigationBar.tintColor = [UIColor whiteColor];
    // 左边只显示“<”
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(-100, 0) forBarMetrics:UIBarMetricsDefault];
    // 设置中间 label 颜色和字体大小
    [self.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:Adapt(17)],NSForegroundColorAttributeName:[UIColor whiteColor]}];
}



@end
