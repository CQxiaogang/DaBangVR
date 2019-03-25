//
//  DBLiveViewController.m
//  DaBangVR
//
//  Created by mac on 2018/11/17.
//  Copyright © 2018 DaBangVR. All rights reserved.
//

#import "LiveViewController.h"
// Vendors
#import "JXCategoryView.h"
#import "JXCategoryListContainerView.h"
// View
#import "LiveCollectionView.h"
#import "LiveTableView.h"
// 七牛云
#import <PLMediaStreamingKit/PLMediaStreamingKit.h>

static NSString *cellID = @"cellID";

@interface LiveViewController ()<JXCategoryViewDelegate, JXCategoryListContainerViewDelegate>

/** 标题 */
@property (nonatomic, copy) NSArray <NSString *>*titles;
/** 第三方 */
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
/** 七牛云 */
@property (nonatomic, strong) PLMediaStreamingSession *session;
@end

@implementation LiveViewController

#pragma mark 懒加载

#pragma mark 系统回调方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    PLVideoCaptureConfiguration *videoCaptureConfiguration = [PLVideoCaptureConfiguration defaultConfiguration];
    PLAudioCaptureConfiguration *audioCaptureConfiguration = [PLAudioCaptureConfiguration defaultConfiguration];
    PLVideoStreamingConfiguration *videoStreamingConfiguration = [PLVideoStreamingConfiguration defaultConfiguration];
    PLAudioStreamingConfiguration *audioStreamingConfiguration = [PLAudioStreamingConfiguration defaultConfiguration];

    //  创建推荐session对象
    self.session = [[PLMediaStreamingSession alloc] initWithVideoCaptureConfiguration:videoCaptureConfiguration audioCaptureConfiguration:audioCaptureConfiguration videoStreamingConfiguration:videoStreamingConfiguration audioStreamingConfiguration:audioStreamingConfiguration stream:nil];

    [self.view addSubview:self.session.previewView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"start" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 100, 44);
    button.center = CGPointMake(CGRectGetMidX([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - 80);
    [button addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)actionButtonPressed:(id)sender {
    [NetWorkHelper POST:URl_createStream parameters:@{@"name":@"123456"} success:^(id  _Nonnull responseObject) {
        NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSURL *pushURL = [NSURL URLWithString:result];
        [self.session startStreamingWithPushURL:pushURL feedback:^(PLStreamStartStateFeedback feedback) {
            if (feedback == PLStreamStartStateSuccess) {
                NSLog(@"Streaming started.");
            }
            else {
                NSLog(@"Oops.");
            }
        }];
    } failure:nil];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //隐藏navigationBar
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)setupUI{
    [super setupUI];
    
    _titles = @[@"购物",@"娱乐"];
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight, KScreenW, kNavBarHeight)];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor lightGreen];
    self.categoryView.delegate = self;
    self.categoryView.defaultSelectedIndex = 0;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    self.categoryView.indicators = @[lineView];
//    [self.view addSubview:self.categoryView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc]initWithDelegate:self];
    self.listContainerView.frame = CGRectMake(0, kTopHeight, KScreenW, KScreenH-kTopHeight);
    self.listContainerView.defaultSelectedIndex = 0;
//    [self.view addSubview:self.listContainerView];
    self.categoryView.contentScrollView = self.listContainerView.scrollView;
}
#pragma mark —— JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
    [self.listContainerView didClickSelectedItemAtIndex:index];
}

- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
    [self.listContainerView scrollingFromLeftIndex:leftIndex toRightIndex:rightIndex ratio:ratio selectedIndex:categoryView.selectedIndex];
}
#pragma mark —— JXCategoryListContainerViewDelegate

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if (index == 0) {
        LiveCollectionView *collectionView = [[LiveCollectionView alloc] init];
        return collectionView;
    }else{
        LiveTableView *tableView = [[LiveTableView alloc] init];
        return tableView;
    }
}

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

@end

