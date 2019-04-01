//
//  DB_TextView.m
//  DaBangVR
//
//  Created by mac on 2019/4/1.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "DB_TextView.h"

#define MaxTextViewHeight 80 //限制文字输入的高度
#define fontSize kFit(14) //字体大小

@interface DB_TextView ()<UITextViewDelegate, UIScrollViewDelegate>
{
    BOOL statusTextView; //当文字大于限定高度之后的状态
    NSString *placeholderText; //设置占位符的文字
}
/** 收回键盘 */
@property (nonatomic, strong) UIView *backGroundView;
/** 占位符 */
@property (nonatomic, strong) UILabel *placeholderLabel;
/** 发送按钮 */
@property (nonatomic, strong) UIButton *sendButton;

@end

@implementation DB_TextView

#pragma mark —— 懒加载
-(UIView *)backGroundView{
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 49)];
        _backGroundView.backgroundColor = KRedColor;
        [self addSubview:_backGroundView];
    }
    return _backGroundView;
}

-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:fontSize];
        _textView.delegate = self;
        _textView.layer.cornerRadius = kFit(5);
        [self.backGroundView addSubview:_textView];;
    }
    return _textView;
}

-(UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.font = [UIFont systemFontOfSize:fontSize];
        _placeholderLabel.textColor = KGrayColor;
        [self.backGroundView addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
}

-(UIButton *)sendButton{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setBackgroundColor:KWhiteColor];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendClick:) forControlEvents:UIControlEventTouchUpInside];
        _sendButton.layer.cornerRadius = kFit(5);
        //没有文字，不允许用户点击
        _sendButton.userInteractionEnabled = NO;
        [self.backGroundView addSubview:_sendButton];
    }
    return _sendButton;
}

#pragma mark —— UITextViewDelegate
-(void)textViewDidChange:(UITextView *)textView{
    /**
     *  设置占位符
     */
    if (textView.text.length == 0) {
        self.placeholderLabel.text = placeholderText;
        [self.sendButton setBackgroundColor:KGrayColor];
        self.sendButton.userInteractionEnabled = NO;
    }else{
        self.placeholderLabel.text = nil;
        [self.sendButton setBackgroundColor:KWhiteColor];
        self.sendButton.userInteractionEnabled = YES;
    }
    /******** 计算高度 **********/
    CGSize size = CGSizeMake(KScreenW-65, 80);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName,nil];
    CGFloat curHeight = [textView.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size.height;
    CGFloat y = CGRectGetMaxY(self.backGroundView.frame);
    if (curHeight < 19.094) {
        statusTextView = NO;
        self.backGroundView.frame = CGRectMake(0, y-49, KScreenW, 49);
    }else if (curHeight < MaxTextViewHeight){
        statusTextView = NO;
        self.backGroundView.frame = CGRectMake(0, y-textView.contentSize.height-10, KScreenW, textView.contentSize.height+10);
    }else{
        statusTextView = YES;
        return;
    }
}

#pragma mark —— UIScrollviewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (statusTextView == NO) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }else{
        
    }
}

//暴露的方法
- (void)setPlaceholderText:(NSString *)text{
    placeholderText = text;
    self.placeholderLabel.text = placeholderText;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //禁用第三方工具 IQKeyboardManager
        [IQKeyboardManager sharedManager].enable = NO;
        //添加约束
        [self andConstraint];
        //增加监听,当键盘出现或改变时收到消息
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        //增加监听,当键盘退出时收到消息
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillShowNotification object:nil];
        
        /**
         * 点击空白区域取消
         */
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

//约束
- (void)andConstraint{
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backGroundView).offset(6);
        make.left.equalTo(self.backGroundView).offset(5);
        make.bottom.equalTo(self.backGroundView).offset(-6);
        make.width.mas_equalTo(KScreenW - 65);
    }];
    
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backGroundView).offset(5);
        make.left.equalTo(self.backGroundView).offset(10);
        make.height.mas_equalTo(39);
    }];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backGroundView).offset(8);
        make.right.equalTo(self.backGroundView).offset(-5);
        make.width.mas_equalTo(50);
    }];
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification{
    //给DB_TextView实例化的屏幕一样的大小
    self.frame = [UIScreen mainScreen].bounds;
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat height = keyboardRect.size.height;
    if (self.textView.text.length == 0) {
        self.backGroundView.frame = CGRectMake(0, KScreenH - height - self.backGroundView.mj_h, KScreenW, 49);
    }else{
        CGRect rect = CGRectMake(0, KScreenH - self.backGroundView.frame.size.height - height, KScreenW, self.backGroundView.frame.size.height);
        self.backGroundView.frame = rect;
    }
}

//当键盘退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification{
    if (self.textView.text.length == 0) {
        self.backGroundView.frame = CGRectMake(0, 0, KScreenW, 49);
        self.frame = CGRectMake(0, KScreenH, KScreenW, 49);
    }else{
        CGRect rect = CGRectMake(0, 0, KScreenW, self.backGroundView.mj_h);
        self.backGroundView.frame = rect;
        self.frame = CGRectMake(0, KScreenH, KScreenW, self.backGroundView.mj_h);
    }
}

//收键盘
- (void)tapClick{
    [self.textView resignFirstResponder];
}

- (void)sendClick:(UIButton *)sender{
    //收键盘
    [self.textView endEditing:YES];
    
    if (self.textBlock) {
        self.textBlock(self.textView.text);
    }
    
    self.textView.text = nil;
    self.placeholderLabel.text = placeholderText;
    [self.sendButton setBackgroundColor:KGrayColor];
    self.sendButton.userInteractionEnabled = NO;
    //收回键盘的父类
    self.frame = CGRectMake(0, KScreenH, KScreenW, 49);
    self.backGroundView.frame = CGRectMake(0, 0, KScreenW, 49);
}
@end
