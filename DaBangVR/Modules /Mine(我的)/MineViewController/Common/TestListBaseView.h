//
//  TestListBaseView.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPagerView.h"

@protocol TestListBaseViewDelegate <NSObject>

-(void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface TestListBaseView : UIView <JXPagerViewListViewDelegate>

@property (nonatomic, weak) UINavigationController *naviController;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <NSString *> *dataSource;
@property (nonatomic, strong) NSArray <NSString *> *imgData;
@property (nonatomic, strong) NSArray <NSString *> *titleData;
@property (nonatomic, assign) BOOL isNeedFooter;
@property (nonatomic, assign) BOOL isNeedHeader;
@property (nonatomic, assign) BOOL isHeaderRefreshed;   //默认为YES

@property (nonatomic, weak) id <TestListBaseViewDelegate> delegate;

- (void)beginFirstRefresh;
@end
