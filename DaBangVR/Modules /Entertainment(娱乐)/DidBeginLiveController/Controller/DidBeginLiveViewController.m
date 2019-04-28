//
//  EntertainmentViewController.m
//  DaBangVR
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "DidBeginLiveViewController.h"
#import <PLMediaStreamingKit/PLMediaStreamingKit.h>
#import "LiveCommentTableViewCell.h"
#import "RCDLiveTextMessageCell.h"
#import "RCCRMessageModel.h"
#import "CDSideBarController.h"
#import "DB_BounceView.h"
#import "DidBeginLiveTopView.h"
#import "DidBeginLiveAnchorInfoView.h"
#import "DidBeginLiveTaskView.h"
#import "DidBeginLiveGoodsView.h"
#import "GoodsDetailsModel.h"

static NSString *const rctextCellIndentifier = @"rctextCellIndentifier";

@interface DidBeginLiveViewController ()<UITextViewDelegate, CDSideBarControllerDelegate, DB_BounceViewDelagete, UICollectionViewDelegate, UICollectionViewDataSource, DidBeginLiveTopViewDelegate>
/** 七牛云 */
@property (nonatomic, strong) PLMediaStreamingSession *session;
/** 装底部按钮的数组 */
@property (nonatomic, strong) NSMutableArray *buttonArr;
/** 聊天评论区 */
@property (nonatomic, strong) UITableView *conversationMessageTableView;
@property (nonatomic, strong) RCDLiveTextMessageCell *tempMsgCell;
/** 聊天内容的消息Cell数据模型的数据源 */
@property (nonatomic, strong) NSMutableArray<RCCRMessageModel *> *conversationDataRepository;
/** 点击按钮弹出键盘 */
@property (nonatomic, strong) UITextView *commentText;
@property (nonatomic, strong) UIView     *commentsView;
/** 点击按钮弹出键盘中发送按钮 */
@property (nonatomic, strong) UIButton   *commentSendBtn;
/** 第三方右侧弹出菜单 */
@property (nonatomic, strong) CDSideBarController *sideBar;
/** 美化模式弹出视图 */
@property (nonatomic, strong) DB_BounceView *beautifyModeBounceView;
/** 音乐选择弹出视图 */
@property (nonatomic, strong) DB_BounceView *musicSelectionBounceView;
@property (nonatomic, strong) UICollectionView *musicCollectionView;
@property (nonatomic, strong) PLVideoCaptureConfiguration *videoCaptureConfiguration;
/** 顶部的视图 */
@property (nonatomic, strong) DidBeginLiveTopView *didBeginLiveTopView;
/** 主播信息视图 */
@property (nonatomic, strong) DidBeginLiveAnchorInfoView *didBeginLiveAnchorInfoView;
/** 主播任务视图 */
@property (nonatomic, strong) DidBeginLiveTaskView *didBeginLiveTaskView;
/** 直播的商品 */
@property (nonatomic, strong) DidBeginLiveGoodsView *didBeginLiveGoodsView;
@property (nonatomic, strong) NSArray <GoodsDetailsModel *> *goodsDataSource;
@end
@implementation DidBeginLiveViewController
#pragma mark —— 懒加载
-(NSMutableArray *)buttonArr{
    if (!_buttonArr) {
        _buttonArr = [NSMutableArray new];
    }
    return _buttonArr;
}

-(UITableView *)conversationMessageTableView{
    if (!_conversationMessageTableView) {
        _conversationMessageTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _conversationMessageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _conversationMessageTableView.delegate = self;
        _conversationMessageTableView.dataSource = self;
        _conversationMessageTableView.alwaysBounceVertical = YES;
        _conversationMessageTableView.showsVerticalScrollIndicator = NO;
        [_conversationMessageTableView registerClass:[RCDLiveTextMessageCell class] forCellReuseIdentifier:rctextCellIndentifier];
        _conversationMessageTableView.backgroundColor = [UIColor clearColor];
        _conversationMessageTableView.estimatedRowHeight = 0;
        _conversationMessageTableView.estimatedSectionHeaderHeight = 0;
        _conversationMessageTableView.estimatedSectionFooterHeight = 0;
    }
    return _conversationMessageTableView;
}

-(NSMutableArray<RCCRMessageModel *> *)conversationDataRepository{
    if (!_conversationDataRepository) {
        _conversationDataRepository = [NSMutableArray new];
    }
    return _conversationDataRepository;
}

- (DB_BounceView *)beautifyModeBounceView{
    if (!_beautifyModeBounceView) {
        CGFloat width = 150;
        _beautifyModeBounceView = [[DB_BounceView alloc] initWithContentViewFrame:CGRectMake(0, KScreenH-width, KScreenW, width)];
        _beautifyModeBounceView.delegate = self;
        NSArray *titles = @[@"红润",@"美白",@"美颜"];
        for (int i = 0; i<=2; i++) {
            UILabel *titleLabel         = [[UILabel alloc] initWithFrame:CGRectMake(25,5+i*50, 30, 20)];
            titleLabel.text             = titles[i];
            titleLabel.adaptiveFontSize = 12;
            titleLabel.textColor        = KWhiteColor;
            [_beautifyModeBounceView.contentView addSubview:titleLabel];
            UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake(20, 10+i*50, 335, 50)];
            slider.value     = 0.1;
            slider.tag       = i+10;
            slider.tintColor = KRedColor;
            [slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
            [_beautifyModeBounceView.contentView addSubview:slider];
        }
    }
    return _beautifyModeBounceView;
}

-(DB_BounceView *)musicSelectionBounceView{
    if (!_musicSelectionBounceView) {
        CGFloat width = 150;
        _musicSelectionBounceView = [[DB_BounceView alloc] initWithContentViewFrame:CGRectMake(0, KScreenH-width, KScreenW, width)];
        _musicSelectionBounceView.delegate = self;
        self.musicCollectionView.frame = CGRectMake(0, 10, KScreenW, width-20);
        [_musicSelectionBounceView.contentView addSubview:self.musicCollectionView];
    }
    return _musicSelectionBounceView;
}

-(UICollectionView *)musicCollectionView{
    if (!_musicCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize                    = CGSizeMake(80, 80);
        _musicCollectionView               = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        layout.sectionInset                = UIEdgeInsetsMake(0, 10, 0, 10);
        _musicCollectionView.delegate      = self;
        _musicCollectionView.dataSource    = self;
        _musicCollectionView.backgroundColor = KClearColor;
        _musicCollectionView.showsHorizontalScrollIndicator = NO;
        [_musicCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    }
    return _musicCollectionView;
}

-(DidBeginLiveTopView *)didBeginLiveTopView{
    if (!_didBeginLiveTopView) {
        _didBeginLiveTopView = [[[NSBundle mainBundle] loadNibNamed:@"DidBeginLiveTopView" owner:nil options:nil] firstObject];
        _didBeginLiveTopView.delegate = self;
    }
    return _didBeginLiveTopView;
}

-(DidBeginLiveAnchorInfoView *)didBeginLiveAnchorInfoView{
    if (!_didBeginLiveAnchorInfoView) {
        _didBeginLiveAnchorInfoView = [[[NSBundle mainBundle] loadNibNamed:@"DidBeginLiveAnchorInfoView" owner:nil options:nil] firstObject];
    }
    return _didBeginLiveAnchorInfoView;
}

-(DidBeginLiveTaskView *)didBeginLiveTaskView{
    if (!_didBeginLiveTaskView) {
        _didBeginLiveTaskView = [[[NSBundle mainBundle] loadNibNamed:@"DidBeginLiveTaskView" owner:nil options:nil] firstObject];
    }
    return _didBeginLiveTaskView;
}

-(DidBeginLiveGoodsView *)didBeginLiveGoodsView{
    if (!_didBeginLiveGoodsView) {
        _didBeginLiveGoodsView = [[DidBeginLiveGoodsView alloc] init];
    }
    return _didBeginLiveGoodsView;
}
#pragma mark —— 系统方法
-(void)viewDidLoad {
    [super viewDidLoad];
    //用于计算高度
    self.tempMsgCell = [[RCDLiveTextMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rctextCellIndentifier];
    
    NSArray *imageList = @[[UIImage imageNamed:@"menuChat.png"], [UIImage imageNamed:@"menuUsers.png"], [UIImage imageNamed:@"menuMap.png"], [UIImage imageNamed:@"menuClose.png"]];
    _sideBar = [[CDSideBarController alloc] initWithImages:imageList];
    _sideBar.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 点击按钮弹出键盘,f导致view上移。所以禁用三方控件IQKeyboardManager */
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
    [_sideBar insertMenuButtonOnView:self.view atPosition:CGPointMake(self.view.frame.size.width - 50, KScreenH - 100)];
}

-(void)setupUI{
    [super setupUI];
    
    kWeakSelf(self);
    
    _videoCaptureConfiguration = [PLVideoCaptureConfiguration defaultConfiguration];
    //摄像头的方向
    _videoCaptureConfiguration.position = AVCaptureDevicePositionFront;
    PLAudioCaptureConfiguration *audioCaptureConfiguration = [PLAudioCaptureConfiguration defaultConfiguration];
    PLVideoStreamingConfiguration *videoStreamingConfiguration = [PLVideoStreamingConfiguration defaultConfiguration];
    PLAudioStreamingConfiguration *audioStreamingConfiguration = [PLAudioStreamingConfiguration defaultConfiguration];
    
    //创建推荐session对象
    self.session = [[PLMediaStreamingSession alloc] initWithVideoCaptureConfiguration:_videoCaptureConfiguration audioCaptureConfiguration:audioCaptureConfiguration videoStreamingConfiguration:videoStreamingConfiguration audioStreamingConfiguration:audioStreamingConfiguration stream:nil];
    
    [self.view addSubview:self.session.previewView];
    //开启美颜
    [self.session setBeautifyModeOn:YES];
    //回声消除开关
    audioCaptureConfiguration.acousticEchoCancellationEnable = YES;
    /**
     *liveTitle 直播标题
     *coverUrl  直播封面图片
     *goodsIds  勾选商品的id数组，用逗号：1,2,3 如果不传则为娱乐直播
     */
    NSDictionary *parameters = @{
                                 @"liveTitle":_parameters[@"liveTitle"],
                                 @"goodsIds" :_parameters[@"goodsIds"]
                                 };
    
    [NetWorkHelper POST:URl_create images:_parameters[@"coverUrl"] parameters:parameters success:^(id  _Nonnull responseObject) {
        NSURL *pushURL = [NSURL URLWithString:responseObject[@"publishURL"]];
        [self.session startStreamingWithPushURL:pushURL feedback:^(PLStreamStartStateFeedback feedback) {
            
        }];
        //数据解析
        NSArray *goodsVoList = responseObject[@"goodsVoList"];
        weakself.goodsDataSource = [GoodsDetailsModel mj_objectArrayWithKeyValuesArray:goodsVoList];
        self.didBeginLiveGoodsView.goodsData = weakself.goodsDataSource;
    } failure:^(NSError * _Nonnull error) {}];
    
    //设置底部UI
    [self setupBottomUI];
    
    [self.view addSubview:self.didBeginLiveTopView];
    [self.didBeginLiveTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(20);
        make.height.equalTo(40);
    }];
    
    [self.view addSubview:self.didBeginLiveAnchorInfoView];
    [self.didBeginLiveAnchorInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(weakself.didBeginLiveTopView.mas_bottom).offset(5);
        make.size.equalTo(CGSizeMake(160, 50));
    }];
    
    [self.view addSubview:self.didBeginLiveTaskView];
    [self.didBeginLiveTaskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.top.equalTo(weakself.didBeginLiveAnchorInfoView.mas_bottom).offset(10);
        make.size.equalTo(CGSizeMake(140, 30));
    }];
    [self.view layoutSubviews];
    [self.view addSubview:self.didBeginLiveGoodsView];
    [self.didBeginLiveGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(weakself.didBeginLiveTaskView.mas_bottom).offset(5);
        make.bottom.equalTo(weakself.conversationMessageTableView.mas_top).offset(0);
        make.width.equalTo(80);
    }];
}

-(void)setupBottomUI{
    NSArray *imgArr = @[@"s-comment",@"s-share",@"s-commodity"];
    for (int i=0; i<3; i++) {
        UIButton *baseButton = [[UIButton alloc] init];
        baseButton.tag = i;
        [baseButton setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [baseButton addTarget:self action:@selector(clickBaseButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:baseButton];
        [self.buttonArr addObject:baseButton];
    }
    kWeakSelf(self);
    CGFloat buttonW = 30;
    CGFloat buttonH = 30;
    CGFloat HorSpacing = 30;
    [weakself.buttonArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:HorSpacing leadSpacing:HorSpacing tailSpacing:KScreenW-HorSpacing*3 - buttonW*3];
    [weakself.buttonArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
        make.size.equalTo(CGSizeMake(buttonW, buttonH));
    }];
    
    //添加评论区
    [self.view addSubview:self.conversationMessageTableView];
    UIButton *firstBtn = self.buttonArr[0];
    [self.conversationMessageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(30);
        make.bottom.equalTo(firstBtn.mas_top).offset(-10);
        make.size.equalTo(CGSizeMake(250, 240));
    }];
    
}

-(void)clickBaseButton:(UIButton *)button{
    switch (button.tag) {
        case 0:
        {
            //发信息
            DLog(@"发信息");
            [button performSelector:@selector(setUserInteractionEnabled:) withObject:@YES afterDelay:1];
            [self showCommentText];
        }
            break;
        case 1:
            //分享
            break;
        case 2:
            break;
        default:
            break;
    }
}

-(void)showCommentText{
    [self createCommentsView];
    [_commentText becomeFirstResponder];
}

-(void)createCommentsView{
    if (!_commentsView) {
        _commentsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW-80, 40.0)];
        _commentsView.backgroundColor = KWhiteColor;
        //发送按钮
        _commentSendBtn = [[UIButton alloc] init];
        _commentSendBtn.adaptiveFontSize = 15;
        [_commentSendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_commentSendBtn setTitleColor:KGrayColor forState:UIControlStateNormal];
        [_commentSendBtn addTarget:self action:@selector(clickCommentSendButton:) forControlEvents:UIControlEventTouchUpInside];
        [_commentsView addSubview:_commentSendBtn];
        [_commentSendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(0);
            make.size.equalTo(CGSizeMake(60, 40));
        }];
        _commentText = [[UITextView alloc] initWithFrame:CGRectInset(_commentsView.bounds, 5.0, 5.0)];
        _commentText.inputAccessoryView  = _commentsView;
        _commentText.backgroundColor     = KClearColor;
        _commentText.delegate            = self;
        _commentText.font                = [UIFont systemFontOfSize:15.0];
        [_commentsView addSubview:_commentText];
    }
    [self.view.window addSubview:_commentsView];//添加到window上或者其他视图也行，只要在视图以外就好了
    [_commentText becomeFirstResponder];
}

/** 信息按钮点击事件 */
-(void)clickCommentSendButton:(UIButton *)sender{
    if (_commentText.text.length != 0) {
        RCCRMessageModel *model = [[RCCRMessageModel alloc] init];
        model.name = [NSString stringWithFormat:@"%@:",curUser.nickName];
        model.message = _commentText.text;
        [self.conversationDataRepository addObject:model];
        _commentText.text = nil;
        [self tableViewInsertRowsAtIndexPaths];
    }
}

/** tableView输入插入方法 */
-(void)tableViewInsertRowsAtIndexPaths{
    //插入到tableView中
    [self.conversationMessageTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.conversationDataRepository.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    // 再滚动到最底部
    [self.conversationMessageTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.conversationDataRepository.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

#pragma mark —— tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.conversationDataRepository.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCDLiveTextMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:rctextCellIndentifier forIndexPath:indexPath];
    cell.model = self.conversationDataRepository[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RCCRMessageModel *model = [self.conversationDataRepository objectAtIndex:indexPath.row];
    if (model.cellHeight == 0) {
        
        CGFloat cellHeight = [self.tempMsgCell heightForModel:model];
        model.cellHeight = cellHeight;
        return cellHeight;
        
    }else{
        return model.cellHeight;
    }
}

/** 屏幕点击事件 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.commentText resignFirstResponder];
}

#pragma mark - CDSideBarController delegate
- (void)menuButtonClicked:(int)index
{
    switch (index) {
        case 0:
            [self.beautifyModeBounceView showInView:self.view];
            for (UIButton *button in self.buttonArr) {
                [UIView animateWithDuration:0.3 animations:^{
                    button.alpha = 0;
                }];
            }
            break;
        case 1:
        {
//            NSString *path = [[NSBundle mainBundle] pathForResource:@"测试" ofType:@"mp3"];
//            PLAudioPlayer *player = [self.session audioPlayerWithFilePath:path];
//            [player play];
            [self.musicSelectionBounceView showInView:self.view];
            for (UIButton *button in self.buttonArr) {
                [UIView animateWithDuration:0.3 animations:^{
                    button.alpha = 0;
                }];
            }
        }
            
            break;
        case 3:
            //摄像头旋转
            [self.session toggleCamera];
            break;
        default:
            break;
    }
}
/** UISlider */
-(void)sliderAction:(UISlider *)sender{
    switch (sender.tag) {
        case 10:
            //红润
            [self.session setRedden:sender.value];
            break;
        case 11:
            //美白
            [self.session setWhiten:sender.value];
            break;
        case 12:
            //美颜
            [self.session setBeautify:sender.value];
            break;
        default:
            break;
    }
}
#pragma mark —— DB_BounceView
-(void)dismissViewShowButton{
    for (UIButton *button in self.buttonArr) {
        [UIView animateWithDuration:0.3 animations:^{
            button.alpha = 1.0;
        }];
    }
}

#pragma mark —— UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.backgroundColor = KRandomColor;
    return cell;
}

#pragma mark —— DidBeginLiveTopViewDelegate
-(void)dismissAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc{
    
    [self.session closeCurrentAudio];
    
}

@end
