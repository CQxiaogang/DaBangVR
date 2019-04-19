//
//  EntertainmentViewController.m
//  DaBangVR
//
//  Created by mac on 2019/3/27.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "DidBeginLiveViewController.h"
// 七牛云
#import <PLMediaStreamingKit/PLMediaStreamingKit.h>/** 直播聊天评论Cell */
#import "LiveCommentTableViewCell.h"
#import "RCDLiveTextMessageCell.h"
/** 直播聊天评论Model */
#import "RCCRMessageModel.h"

static NSString *const rctextCellIndentifier = @"rctextCellIndentifier";

@interface DidBeginLiveViewController ()<UITextViewDelegate>
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

#pragma mark —— 系统方法
-(void)viewDidLoad {
    [super viewDidLoad];
    //用于计算高度
    self.tempMsgCell = [[RCDLiveTextMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rctextCellIndentifier];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    /** 点击按钮弹出键盘,导致view上移。所以禁用三方控件IQKeyboardManager */
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

-(void)setupUI{
    [super setupUI];
    PLVideoCaptureConfiguration *videoCaptureConfiguration = [PLVideoCaptureConfiguration defaultConfiguration];
    //摄像头的方向
    videoCaptureConfiguration.position = AVCaptureDevicePositionFront;
    PLAudioCaptureConfiguration *audioCaptureConfiguration = [PLAudioCaptureConfiguration defaultConfiguration];
    PLVideoStreamingConfiguration *videoStreamingConfiguration = [PLVideoStreamingConfiguration defaultConfiguration];
    PLAudioStreamingConfiguration *audioStreamingConfiguration = [PLAudioStreamingConfiguration defaultConfiguration];
    
    //  创建推荐session对象
    self.session = [[PLMediaStreamingSession alloc] initWithVideoCaptureConfiguration:videoCaptureConfiguration audioCaptureConfiguration:audioCaptureConfiguration videoStreamingConfiguration:videoStreamingConfiguration audioStreamingConfiguration:audioStreamingConfiguration stream:nil];
    
    [self.view addSubview:self.session.previewView];
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
    } failure:^(NSError * _Nonnull error) {}];
    
    //设置底部UI
    [self setupBottomUI];
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
@end
