//
//  StoreViewController.m
//  DaBangVR
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "StoreViewController.h"
#import "ShufflingView.h"
#import "CategoryChooseView.h"
#import "StoreGoodsTableView.h"
#import "DeptModel.h"

@interface StoreViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ShufflingView *shufflingView;
@property (nonatomic, strong) CategoryChooseView *categoryChooseView;
@property (nonatomic, strong) UILabel *recommendLabel;
@property (nonatomic, strong) StoreGoodsTableView *goodsTableView;
@property (nonatomic, strong) NSArray <DeptModel*>*data;
@end

@implementation StoreViewController
#pragma mark —— 懒加载
-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView                 = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.delegate        = self;
        _scrollView.contentSize     = CGSizeMake(KScreenW, KScreenH*2);
        [_scrollView addSubview:self.shufflingView];
        [_scrollView addSubview:self.categoryChooseView];
        [_scrollView addSubview:self.recommendLabel];
        [_scrollView addSubview:self.goodsTableView];
        
    }
    return _scrollView;
}

-(ShufflingView *)shufflingView{
    if (!_shufflingView) {
        _shufflingView = [[ShufflingView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 180) andIndex:@"1"];
    }
    return _shufflingView;
}

-(CategoryChooseView *)categoryChooseView{
    if (!_categoryChooseView) {
        _categoryChooseView = [[CategoryChooseView alloc] init];
        _categoryChooseView.frame = CGRectMake(0, CGRectGetMaxY(self.shufflingView.frame), KScreenW, 100);
    }
    return _categoryChooseView;
}

-(UILabel *)recommendLabel{
    if (!_recommendLabel) {
        _recommendLabel                  = [UILabel new];
        _recommendLabel.frame            = CGRectMake(0, CGRectGetMaxY(self.categoryChooseView.frame), KScreenW, 20);
        _recommendLabel.text             = @"——— 推荐商家 ———";
        _recommendLabel.textColor        = KGrayColor;
        _recommendLabel.textAlignment    = NSTextAlignmentCenter;
        _recommendLabel.adaptiveFontSize = 12;
    }
    return _recommendLabel;
}

-(StoreGoodsTableView *)goodsTableView{
    if (!_goodsTableView) {
        _goodsTableView       = [[StoreGoodsTableView alloc] init];
        _goodsTableView.frame = CGRectMake(0, CGRectGetMaxY(self.recommendLabel.frame), KScreenW, KScreenH - CGRectGetMaxY(self.recommendLabel.frame));
    }
    return _goodsTableView;
}

#pragma mark —— 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];

    //加载数据
    [self loadingData];
}

-(void)loadingData{
    kWeakSelf(self);
    NSDictionary *parameters = @{
                                 @"longitude":@"22",//经度
                                 @"latitude" :@"108" //纬度
                                 };
    [NetWorkHelper POST:URl_getNearbyDeptList parameters:parameters success:^(id  _Nonnull responseObject) {
        NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
        NSDictionary *deptCategory = data[@"DeptCategoryVos"];
        weakself.data = [DeptModel mj_objectArrayWithKeyValuesArray:deptCategory];
        weakself.goodsTableView.data = weakself.data;
    } failure:nil];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    kWeakSelf(self);
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kTopHeight);
        make.left.right.bottom.equalTo(0);
    }];
}

#pragma mark —— UIScrollView 代理
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    DLog(@"将要开始拖拽");
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    DLog(@"滚动着");
}

@end
