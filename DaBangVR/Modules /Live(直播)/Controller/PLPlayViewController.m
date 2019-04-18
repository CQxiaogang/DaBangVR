//
//  PLPlayViewController.m
//  NiuPlayer
//
//  Created by hxiongan on 2018/3/9.
//  Copyright © 2018年 hxiongan. All rights reserved.
//

#import "PLPlayViewController.h"
/** Views */
#import "PLPlayTopView.h"
/** 弹出键盘 */
#import "DB_TextView.h"
/** 直播聊天评论Cell */
#import "LiveCommentTableViewCell.h"
#import "RCDLiveTextMessageCell.h"
/** 直播聊天评论Model */
#import "RCCRMessageModel.h"
/** 长连接 */
#import "WebSocketManager.h"
#import "DemoViewController.h"
/** 分页自定义layout */
#import "PagingEnableLayout.h"
#import "LiveShoppingCollectionViewCell.h"

static NSString *const rctextCellIndentifier = @"rctextCellIndentifier";
@interface PLPlayViewController ()<PLPlayTopViewDelegate, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>{
    BOOL isSelected;//当前是否被点击，用于显示商品详情框
}

@property (nonatomic, strong) UIVisualEffectView *effectView;

@property (nonatomic, assign) BOOL isDisapper;

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
/** 发布按钮 */
@property (nonatomic, strong) UIButton *commentSendBtn;
/** 弹出键盘 */
@property (nonatomic, strong) DB_TextView *textView;
/** 聊天评论区 */
@property (nonatomic, strong) UITableView *conversationMessageTableView;
@property (nonatomic, strong) RCDLiveTextMessageCell *tempMsgCell;
/** 聊天内容的消息Cell数据模型的数据源 */
@property (nonatomic, strong) NSMutableArray<RCCRMessageModel *> *conversationDataRepository;
/** 装底部按钮的数组 */
@property (nonatomic, copy) NSMutableArray* buttonArr;
/** 直播购物 */
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITextView *commentText;
@property (nonatomic, strong) UIView     *commentsView;

@end

@implementation PLPlayViewController

#pragma mark —— 懒加载
- (DB_TextView *)textView{
    if (!_textView) {
        _textView = [[DB_TextView alloc] initWithFrame:CGRectMake(0, KScreenH, KScreenW, 49)];
        _textView.backgroundColor = [UIColor colorWithWhite:0 alpha:.3];
        [_textView setPlaceholderText:@"请输入内容"];
        _textView.textBlock = ^(NSString * _Nonnull string) {
            NSLog(@"%@",string);
        };
    }
    return _textView;
}

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

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        PagingEnableLayout *layout = [[PagingEnableLayout alloc] init];
        //水平布局
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.backgroundColor = KClearColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
//        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
        [_collectionView registerNib:[UINib nibWithNibName:@"LiveShoppingCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellId"];
    }
    return _collectionView;
}

#pragma mark —— 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KWhiteColor;
    //用于计算高度
    self.tempMsgCell = [[RCDLiveTextMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rctextCellIndentifier];
    [self setupUI];
    
    [self setupBottonUI];
    
    if ([WebSocketManager shared].connectType == WebSocketConnect) {
        [[WebSocketManager shared] sendDataToServer:[NSString stringWithFormat:@"%@:%@",curUser.nickName,_commentText.text]];
    }
}

-(void)setupUI{
    self.thumbImageView = [[UIImageView alloc] init];
    self.thumbImageView.image = [UIImage imageNamed:@"qn_niu"];
    self.thumbImageView.clipsToBounds = YES;
    self.thumbImageView.contentMode = UIViewContentModeScaleAspectFill;
    if (self.thumbImageURL) {
        [self.thumbImageView sd_setImageWithURL:self.thumbImageURL placeholderImage:self.thumbImageView.image];
    }
    if (self.thumbImage) {
        self.thumbImageView.image = self.thumbImage;
    }
    
    [self.view addSubview:self.thumbImageView];
    [self.thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    //UIVisualEffect模糊动画
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    [self.thumbImageView addSubview:_effectView];
    [self.effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.thumbImageView);
    }];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    [self.view addGestureRecognizer:singleTap ];
    
    [self setupPlayer];
    
    self.enableGesture = YES;
    
    PLPlayTopView *topView = [[[NSBundle mainBundle] loadNibNamed:@"PLPlayTopView" owner:nil options:nil] firstObject];
    topView.delegate = self;
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(30);
        make.height.equalTo(40);
    }];
    [self.view addSubview:self.textView];
}

-(void)setupBottonUI{
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

- (void)clickBaseButton:(UIButton *)button{
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
            DLog(@"分享");
            break;
        case 2:
            //购物
            [self buyGoodsAttributes:button];
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
        
        _commentsView = [[UIView alloc] initWithFrame:CGRectMake(0.0, KScreenH - kTabBarHeight - 40.0, KScreenW-80, 40.0)];
        _commentsView.backgroundColor = KWhiteColor;
        
        _commentSendBtn = [[UIButton alloc] init];
        [_commentSendBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_commentSendBtn setTitleColor:KGrayColor forState:UIControlStateNormal];
        [_commentSendBtn addTarget:self action:@selector(clickCommentSendButton:) forControlEvents:UIControlEventTouchUpInside];
        _commentSendBtn.adaptiveFontSize = 15;
        [_commentsView addSubview:_commentSendBtn];
        [_commentSendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(0);
            make.size.equalTo(CGSizeMake(60, 40));
        }];
        
        _commentText = [[UITextView alloc] initWithFrame:CGRectInset(_commentsView.bounds, 5.0, 5.0)];
        _commentText.inputAccessoryView  = _commentsView;
        _commentText.backgroundColor     = [UIColor clearColor];
        _commentText.returnKeyType       = UIReturnKeySend;
        _commentText.delegate            = self;
        _commentText.font                = [UIFont systemFontOfSize:15.0];
        _commentText.returnKeyType       = UIReturnKeySend;//变为发送按钮
        [_commentsView addSubview:_commentText];
    }
    [self.view.window addSubview:_commentsView];//添加到window上或者其他视图也行，只要在视图以外就好了
    [_commentText becomeFirstResponder];
}

#pragma mark —— UITextView 代理
-(void)textViewDidChange:(UITextView *)textView{
    [textView flashScrollIndicators];
    static CGFloat maxHeight = 130.0f;
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height >= maxHeight) {
        size.height = maxHeight;
        textView.scrollEnabled = YES;//允许滚到
    }else{
        textView.scrollEnabled = NO; // 不允许滚动，当textview的大小足以容纳它的text的时候，需要设置scrollEnabed为NO，否则会出现光标乱滚动的情况
    }
//    [_commentsView setHeight:size.height];
    DLog(@"height is %f",size.height);
//    _commentText.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
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

/** 购买商品 */
-(void)buyGoodsAttributes:(UIButton *)button{
    if (self.collectionView) {
        [self.collectionView removeFromSuperview];
    }
    [self.view addSubview:self.collectionView];
    UIButton *Button = self.buttonArr[0];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.right.equalTo(0);
        make.bottom.equalTo(Button.mas_top).offset(0);
        make.height.equalTo(350);
    }];
    if (!isSelected) {
        self.collectionView.alpha = 1;
        isSelected = YES;
    } else {
        self.collectionView.alpha = 0;
        isSelected = NO;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.collectionView.alpha = 0;
    isSelected = NO;
}

- (void)setThumbImage:(UIImage *)thumbImage {
    _thumbImage = thumbImage;
    self.thumbImageView.image = thumbImage;
}

- (void)setThumbImageURL:(NSURL *)thumbImageURL {
    _thumbImageURL = thumbImageURL;
    [self.thumbImageView sd_setImageWithURL:thumbImageURL placeholderImage:self.thumbImageView.image];
}

- (void)setUrl:(NSURL *)url {
    if ([_url.absoluteString isEqualToString:url.absoluteString]) return;
    _url = url;
    
    if (self.player) {
        [self stop];
        [self setupPlayer];
        [self.player play];
    }
}

- (void) setupPlayer {
    
    NSLog(@"播放地址: %@", _url.absoluteString);
    
    PLPlayerOption *option = [PLPlayerOption defaultOption];
    PLPlayFormat format = kPLPLAY_FORMAT_UnKnown;
    NSString *urlString = _url.absoluteString.lowercaseString;
    if ([urlString hasSuffix:@"mp4"]) {
        format = kPLPLAY_FORMAT_MP4;
    } else if ([urlString hasPrefix:@"rtmp:"]) {
        format = kPLPLAY_FORMAT_FLV;
    } else if ([urlString hasSuffix:@".mp3"]) {
        format = kPLPLAY_FORMAT_MP3;
    } else if ([urlString hasSuffix:@".m3u8"]) {
        format = kPLPLAY_FORMAT_M3U8;
    }
    [option setOptionValue:@(format) forKey:PLPlayerOptionKeyVideoPreferFormat];
    [option setOptionValue:@(kPLLogNone) forKey:PLPlayerOptionKeyLogLevel];
    
    self.player = [PLPlayer playerWithURL:_url option:option];
    [self.view insertSubview:self.player.playerView atIndex:0];
    [self.player.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.player.delegateQueue = dispatch_get_main_queue();
    //playerViewc铺满整个屏幕
    self.player.playerView.contentMode = UIViewContentModeScaleAspectFill;
    self.player.delegate = self;
    self.player.loopPlay = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    self.isDisapper = YES;
    [self stop];
    [super viewDidDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.isDisapper = NO;
    if (![self.player isPlaying]) {
        [self.player play];
    }
}

- (void)singleTapAction:(UIGestureRecognizer *)gesture {
//    if ([self.player isPlaying]) {
//        [self.player pause];
//    } else {
//        [self.player resume];
//    }
}

- (void)clickPlayButton:(UIButton *)button {
//    [self.player resume];
}

- (void)stop {
    [self.player stop];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

- (void)showWaiting {
    [self.playButton hide];
    [self.view showFullLoading];
}

- (void)hideWaiting {
    [self.view hideFullLoading];
    if (PLPlayerStatusPlaying != self.player.status) {
        [self.playButton show];
    }
}

- (void)setEnableGesture:(BOOL)enableGesture {
    if (_enableGesture == enableGesture) return;
    _enableGesture = enableGesture;
    
    if (nil == self.panGesture) {
        self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    }
    if (enableGesture) {
        if (![[self.view gestureRecognizers] containsObject:self.panGesture]) {
            [self.view addGestureRecognizer:self.panGesture];
        }
    } else {
        [self.view removeGestureRecognizer:self.panGesture];
    }
}

- (void)panGesture:(UIPanGestureRecognizer *)panGesture {
    
    if (UIGestureRecognizerStateChanged == panGesture.state) {
        CGPoint location  = [panGesture locationInView:panGesture.view];
        CGPoint translation = [panGesture translationInView:panGesture.view];
        [panGesture setTranslation:CGPointZero inView:panGesture.view];
        
#define FULL_VALUE 200.0f
        CGFloat percent = translation.y / FULL_VALUE;
        if (location.x > self.view.bounds.size.width / 2) {// 调节音量
            
            CGFloat volume = [self.player getVolume];
            volume -= percent;
            if (volume < 0.01) {
                volume = 0.01;
            } else if (volume > 3) {
                volume = 3;
            }
            [self.player setVolume:volume];
        } else {// 调节亮度f
//            CGFloat currentBrightness = [[UIScreen mainScreen] brightness];
//            currentBrightness -= percent;
//            if (currentBrightness < 0.1) {
//                currentBrightness = 0.1;
//            } else if (currentBrightness > 1) {
//                currentBrightness = 1;
//            }
//            [[UIScreen mainScreen] setBrightness:currentBrightness];
        }
    }
}

#pragma mark - PLPlayerDelegate

- (void)playerWillBeginBackgroundTask:(PLPlayer *)player {
}

- (void)playerWillEndBackgroundTask:(PLPlayer *)player {
}

- (void)player:(PLPlayer *)player statusDidChange:(PLPlayerStatus)state
{
    if (self.isDisapper) {
        [self stop];
        [self hideWaiting];
        return;
    }
    
    if (state == PLPlayerStatusPlaying ||
        state == PLPlayerStatusPaused ||
        state == PLPlayerStatusStopped ||
        state == PLPlayerStatusError ||
        state == PLPlayerStatusUnknow ||
        state == PLPlayerStatusCompleted) {
        [self hideWaiting];
    } else if (state == PLPlayerStatusPreparing ||
               state == PLPlayerStatusReady ||
               state == PLPlayerStatusCaching) {
        [self showWaiting];
    } else if (state == PLPlayerStateAutoReconnecting) {
        [self showWaiting];
    }
}

- (void)player:(PLPlayer *)player stoppedWithError:(NSError *)error
{
    [self hideWaiting];
    NSString *info = error.userInfo[@"NSLocalizedDescription"];
    [self.view showTip:info];
}

- (void)player:(nonnull PLPlayer *)player willRenderFrame:(nullable CVPixelBufferRef)frame pts:(int64_t)pts sarNumerator:(int)sarNumerator sarDenominator:(int)sarDenominator {
    dispatch_main_async_safe(^{
        if (![UIApplication sharedApplication].isIdleTimerDisabled) {
            [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
        }
    });
}

- (AudioBufferList *)player:(PLPlayer *)player willAudioRenderBuffer:(AudioBufferList *)audioBufferList asbd:(AudioStreamBasicDescription)audioStreamDescription pts:(int64_t)pts sampleFormat:(PLPlayerAVSampleFormat)sampleFormat{
    return audioBufferList;
}

- (void)player:(nonnull PLPlayer *)player firstRender:(PLPlayerFirstRenderType)firstRenderType {
    if (PLPlayerFirstRenderTypeVideo == firstRenderType) {
        self.thumbImageView.hidden = YES;
    }
}

- (void)player:(PLPlayer *)player codecError:(NSError *)error {
    
    NSString *info = error.userInfo[@"NSLocalizedDescription"];
    [self.view showTip:info];
    
    [self hideWaiting];
}

#pragma mark —— PLPlayTopViewDelegate
-(void)clickCloseButton{
    [self.navigationController popViewControllerAnimated:YES];
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
/** tableView输入插入方法 */
-(void)tableViewInsertRowsAtIndexPaths{
    //插入到tableView中
    [self.conversationMessageTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.conversationDataRepository.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    // 再滚动到最底部
    [self.conversationMessageTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.conversationDataRepository.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

#pragma mark —— UICollectionView 代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LiveShoppingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    return cell;
}

@end
