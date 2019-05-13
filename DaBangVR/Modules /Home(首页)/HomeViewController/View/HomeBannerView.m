//
//  HomeBannerView.m
//  DaBangVR
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "HomeBannerView.h"
#import "FGGAutoScrollView.h"

@interface HomeBannerView ()
//自动循环滚动视图
@property(nonatomic, strong)FGGAutoScrollView *bannerView;
@property(nonatomic, strong)NSMutableArray *imgStrings;

@end
@implementation HomeBannerView

- (instancetype)initWithFrame:(CGRect)frame andGoodsArray:(nonnull NSArray *)array{
    self = [super initWithFrame:frame];
    if (self) {
        _imgStrings = [NSMutableArray new];
        for (GoodsRotationListModel *model in array) {
            NSString *chartUrl = model.chartUrl;
            if (chartUrl.length != 0) {
                [_imgStrings addObject:chartUrl];
            }
        }
        //初始化自动循环滚动视图，并且定义图片的点击事件
        _bannerView = [[FGGAutoScrollView alloc]initWithFrame:self.bounds placeHolderImage:[UIImage imageNamed:@"ad3"] imageURLs:nil imageDidSelectedBlock:^(NSInteger selectedIndex) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(goodsRotationSelectedAndJumpUrl:andParentId:)]) {
                GoodsRotationListModel *model = array[selectedIndex];
                [self.delegate goodsRotationSelectedAndJumpUrl:model.jumpUrl andParentId:model.parentId];
            }
        }];
        _bannerView.isShow = YES;
        [self addSubview:_bannerView];
        
        kWeakSelf(self);
        //调下载完数据后再调用setter方法刷新视图
        [self downloadDataWithCompletionHandle:^(NSArray *imgsArray){
            weakself.bannerView.imageURLArray=imgsArray;
        }];
        
    }
    return self;
}

//下载数据
-(void)downloadDataWithCompletionHandle:(void(^)(NSArray *imgsArray))completion
{
    //....下载数据...假设下载完得到的数据是array
    NSArray *array = _imgStrings;
    
    //完成后调用完成的回调代码块
    if(completion)
        completion(array);
}
@end
