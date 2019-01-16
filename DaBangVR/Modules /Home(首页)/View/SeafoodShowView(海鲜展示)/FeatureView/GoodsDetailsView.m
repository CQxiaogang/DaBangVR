//
//  GoodsDetailsView.m
//  DaBangVR
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "GoodsDetailsView.h"
#import "GoodsInfoView.h"
#import "GoodAttributesView.h"
// Vendors
#import "FGGAutoScrollView.h" //无限轮播

@interface GoodsDetailsView ()<goodsInfoViewDeletage>

// 自动循环滚动 view
@property (nonatomic, strong) FGGAutoScrollView *bannerView;
// 基本信息 view
@property (nonatomic, strong) GoodsInfoView     *goodsInfoView;
/** 弹出视图 */
@property (nonatomic, strong) GoodAttributesView *goodsAttributes;
@property (nonatomic, strong) GoodsDetailsModel *model;

@end

@implementation GoodsDetailsView

- (instancetype)initWithFrame:(CGRect)frame andDataSourse:(GoodsDetailsModel *)model{
    self = [super initWithFrame:frame];
    if (self) {
        _model = model;
        
        [self creatUI];
        
        kWeakSelf(self);
        //调下载完数据后再调用setter方法刷新视图
        [self downloadDataWithCompletionHandle:^(NSArray *imgsArray){
            weakself.bannerView.imageURLArray=imgsArray;
        }];
    }
    return self;
}

- (void)creatUI{
    //初始化自动循环滚动视图，并且定义图片的点击事件
    _bannerView=[[FGGAutoScrollView alloc]initWithFrame:CGRectMake(0, 0, self.mj_w, 250) placeHolderImage:nil imageURLs:nil imageDidSelectedBlock:^(NSInteger selectedIndex) {
        switch (selectedIndex) {
            case 0:
                NSLog(@"你选择了第%ld张图片",selectedIndex);
                break;
            case 1:
                NSLog(@"你选择了第%ld张图片",selectedIndex);
                break;
            case 2:
                NSLog(@"你选择了第%ld张图片",selectedIndex);
                break;
            default:
                break;
        }
    }];
    [self addSubview:_bannerView];
    
    kWeakSelf(self);
    _goodsInfoView = [[[NSBundle mainBundle] loadNibNamed:@"GoodsInfoView" owner:nil options:nil] firstObject];
    _goodsInfoView.model = self.model;
    _goodsInfoView.delegate = self;
    [self addSubview:_goodsInfoView];
    [_goodsInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.bannerView.mas_bottom).offset(0);
        make.left.equalTo(@(20));
        make.right.equalTo(@(0));
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.bottom.equalTo(0);
        make.size.equalTo(CGSizeMake(KScreenW, kTabBarHeight));
    }];
    
    UIButton *buyBtn = [[UIButton alloc] init];
    buyBtn.backgroundColor = KRedColor;
    [buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    buyBtn.titleLabel.adaptiveFontSize = 14;
    [buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:buyBtn];
    [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(@(0));
        make.size.equalTo(CGSizeMake(100, kTabBarHeight));
    }];
    
    NSArray *imgArr =@[@"c-collection",@"c-service",@"c-cart"];
    NSArray *nameArr = @[@"收藏",@"客服",@"加购"];
    NSMutableArray *otherBtnArr = [NSMutableArray new];
    UIButton *otherBtn;
    for (int i=0; i<3; i++) {
        otherBtn = [[UIButton alloc] init];
        [otherBtn setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [otherBtn setTitle:nameArr[i] forState:UIControlStateNormal];
        otherBtn.titleLabel.adaptiveFontSize = 12;
        [otherBtn setTitleColor:KGrayColor forState:UIControlStateNormal];
        [bottomView addSubview:otherBtn];
        [otherBtnArr addObject:otherBtn];
    }
    [otherBtnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:140];
    [otherBtnArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(@(0));
    }];
    for (UIButton *button in otherBtnArr) {
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button setTitleEdgeInsets:UIEdgeInsetsMake(button.imageView.mj_h ,-button.imageView.mj_w, -5,0)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(-12, 0,0, -button.titleLabel.mj_w)];
    }
}

// 下载数据
-(void)downloadDataWithCompletionHandle:(void(^)(NSArray *imgsArray))completion
{
    //....下载数据...假设下载完得到的数据是array
    NSArray *array = @[_model.listUrl];
    
    //完成后调用完成的回调代码块
    if(completion)
        completion(array);
}
// button 事件
- (void)buyBtnAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(buyBtnAction)]) {
        [self.delegate buyBtnAction];
    }
}

#pragma mark —— goodsInfoView delegate
// 选择商品规格
-(void)chooseBabyAction{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseBabyAction)]) {
        [self.delegate chooseBabyAction];
    }
}

// 所以评论
-(void)allCommentsAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(allCommentsAction)]) {
        [self.delegate allCommentsAction];
    }
}

@end
