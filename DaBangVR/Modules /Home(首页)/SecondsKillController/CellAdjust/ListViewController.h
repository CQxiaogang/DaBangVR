//
//  ListViewController.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/8.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryListContainerView.h"
#import "LoadDataListBaseViewController.h"

@protocol ListViewControllerDelegate <NSObject>

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface ListViewController : LoadDataListBaseViewController <JXCategoryListContentViewDelegate>

@property (nonatomic, assign) NSInteger timeIndex;

@end
