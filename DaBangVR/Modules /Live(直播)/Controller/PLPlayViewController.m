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

@interface PLPlayViewController ()<PLPlayTopViewDelegate, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIVisualEffectView *effectView;

@property (nonatomic, assign) BOOL isDisapper;

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
/** 发布按钮 */
@property (nonatomic, strong) UIButton *sendButton;
/** 弹出键盘 */
@property (nonatomic, strong) DB_TextView *textView;
/** 聊天评论区 */
@property (nonatomic, strong) UITableView *tableView;
/** 聊天评论的数组 */
@property (nonatomic, strong) NSMutableArray *commentArr;

@property (nonatomic, strong) UITextView *commentText;
@property (nonatomic, strong) UIView *commentsView;

@end

@implementation PLPlayViewController

static NSString *const cellID = @"cellID";

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

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = KClearColor;
        //把tableView倒过来
        _tableView.transform = CGAffineTransformMakeScale(1, -1);
        //取消滚动条
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        //取消拉伸
        _tableView.bounces = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"LiveCommentTableViewCell" bundle:nil] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

-(NSMutableArray *)commentArr{
    if (!_commentArr) {
        _commentArr = [NSMutableArray new];
    }
    return _commentArr;
}

#pragma mark —— 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = KWhiteColor;
    
    [self setupUI];
    
    [self setupBottonUI];
}

-(void)setupUI{
    _closeButton = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [_closeButton setTintColor:KBlackColor];
    [_closeButton setBackgroundImage:[UIImage imageNamed:@"s-close"] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(clickCloseButton) forControlEvents:(UIControlEventTouchUpInside)];
    //    [self.view addSubview:_closeButton];
    //
    //    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.equalTo(self.view).offset(-20);
    //        make.top.equalTo(self.view).offset(30);
    //        make.size.equalTo(CGSizeMake(30, 30));
    //    }];
    
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
    
    self.playButton = [[UIButton alloc] init];
    self.playButton.hidden = YES;
    [self.playButton addTarget:self action:@selector(clickPlayButton:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.playButton setImage:[UIImage imageNamed:@"play"] forState:(UIControlStateNormal)];
    //    [self.view addSubview:self.playButton];
    //    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.size.equalTo(CGSizeMake(60, 60));
    //        make.center.equalTo(self.view);
    //    }];
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
    NSMutableArray *buttonArr = [NSMutableArray new];
    NSArray *imgArr = @[@"s-comment",@"s-share",@"s-commodity"];
    for (int i=0; i<3; i++) {
        UIButton *baseButton = [[UIButton alloc] init];
        baseButton.tag = i;
        [baseButton setImage:[UIImage imageNamed:imgArr[i]] forState:UIControlStateNormal];
        [baseButton addTarget:self action:@selector(clickBaseButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:baseButton];
        [buttonArr addObject:baseButton];
    }
    CGFloat buttonW = 30;
    CGFloat buttonH = 30;
    CGFloat HorSpacing = 30;
    [buttonArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:HorSpacing leadSpacing:HorSpacing tailSpacing:KScreenW-HorSpacing*3 - buttonW*3];
    [buttonArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-20);
        make.size.equalTo(CGSizeMake(buttonW, buttonH));
    }];
    
    //添加评论区
    [self.view addSubview:self.tableView];
    UIButton *firstBtn = buttonArr[0];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(30);
        make.bottom.equalTo(firstBtn.mas_top).offset(-10);
        make.size.equalTo(CGSizeMake(220, 200));
    }];
}

- (void)clickBaseButton:(UIButton *)button{
    switch (button.tag) {
        case 0:
        {
            //发信息
            DLog(@"发信息");
//            [self.textView.textView becomeFirstResponder];
//            [self.commentArr insertObject:@"测试信息添加成功" atIndex:0];
//            button.userInteractionEnabled = NO;
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
            DLog(@"购物");
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
        
        _commentsView = [[UIView alloc] initWithFrame:CGRectMake(0.0, KScreenH - kTabBarHeight - 40.0, KScreenW, 40.0)];
        _commentsView.backgroundColor = [UIColor whiteColor];
        
        _commentText = [[UITextView alloc] initWithFrame:CGRectInset(_commentsView.bounds, 5.0, 5.0)];
        _commentText.layer.borderWidth   = 1.0;
        _commentText.layer.cornerRadius  = 2.0;
        _commentText.layer.masksToBounds = YES;
        
        _commentText.inputAccessoryView  = _commentsView;
        _commentText.backgroundColor     = [UIColor clearColor];
        _commentText.returnKeyType       = UIReturnKeySend;
        _commentText.delegate            = self;
        _commentText.font                = [UIFont systemFontOfSize:15.0];
        [_commentsView addSubview:_commentText];
    }
    [self.view.window addSubview:_commentsView];//添加到window上或者其他视图也行，只要在视图以外就好了
    [_commentText becomeFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    [self.view bringSubviewToFront:self.closeButton];
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
            CGFloat currentBrightness = [[UIScreen mainScreen] brightness];
            currentBrightness -= percent;
            if (currentBrightness < 0.1) {
                currentBrightness = 0.1;
            } else if (currentBrightness > 1) {
                currentBrightness = 1;
            }
            [[UIScreen mainScreen] setBrightness:currentBrightness];
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
    return self.commentArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LiveCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = self.commentArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(24);
}
/** tableView输入插入方法 */
-(void)tableViewInsertRowsAtIndexPaths{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

@end
