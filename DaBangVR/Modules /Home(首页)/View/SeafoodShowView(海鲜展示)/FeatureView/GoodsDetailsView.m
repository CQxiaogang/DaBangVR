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
        make.left.equalTo(@(0));
        make.right.equalTo(@(0));
        make.height.equalTo(184);
    }];
}

// 下载数据
-(void)downloadDataWithCompletionHandle:(void(^)(NSArray *imgsArray))completion
{
    /**下载数据...假设下载完得到的数据是array*/
    NSArray *imgArray = _model.imgList;
    NSMutableArray *data = [NSMutableArray new];
    for (NSDictionary *dic in imgArray) {
        NSString *imgString = dic[@"chartUrl"];
        [data addObject:imgString];
    }
    
    NSArray *array = data.count ? (NSArray *)data : @[@"http://test.fuxingsc.com/2.gif"];
    
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
