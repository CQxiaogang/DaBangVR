//
//  DBSeafoodShowViewController.h
//  DaBangVR
//
//  Created by mac on 2018/12/18.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageTitleView.h"
#import "PageContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DBSeafoodShowViewController : RootViewController

@property (nonatomic, strong) PageTitleView   *pageTitleView;
@property (nonatomic, strong) PageContentView *pageContentView;

@end

NS_ASSUME_NONNULL_END
