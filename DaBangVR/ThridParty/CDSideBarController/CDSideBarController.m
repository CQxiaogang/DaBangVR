//
//  CDSideBarController.m
//  CDSideBar
//
//  Created by Christophe Dellac on 9/11/14.
//  Copyright (c) 2014 Christophe Dellac. All rights reserved.
//

#import "CDSideBarController.h"
#define kCGSideW 40
#define kButtonW 30

@implementation CDSideBarController

@synthesize menuColor = _menuColor;
@synthesize isOpen = _isOpen;

#pragma mark - 
#pragma mark Init

- (CDSideBarController*)initWithImages:(NSArray*)images
{
    _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _menuButton.frame = CGRectMake(0, 0, kCGSideW, kCGSideW);
    [_menuButton setImage:[UIImage imageNamed:@"menuIcon.png"] forState:UIControlStateNormal];
    [_menuButton addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    _backgroundMenuView = [[UIView alloc] init];
    _menuColor = [UIColor whiteColor];
    _buttonList = [[NSMutableArray alloc] initWithCapacity:images.count];
    
    int index = 0;
    NSArray *titles = @[@"美颜",@"音乐",@"K歌",@"切换",@"分享"];
    for (NSString *title in titles)
    {
        UIButton *button = [UIButton new];
//        button.backgroundColor = KBlueColor;
        button.frame     = CGRectMake(0, 200 + ((kButtonW+30) * index), kButtonW*2, kButtonW);
        button.tag       = index;
        [button setAdaptiveFontSize:12];
        [button setTitle:title forState:UIControlStateNormal];
//        [button setImage:image forState:UIControlStateNormal];
        //改变图片和文字位置
//        [button setTitleEdgeInsets:UIEdgeInsetsMake(15, -button.imageView.size.width, 15, button.imageView.size.width)];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.bounds.size.width, 0, -button.titleLabel.bounds.size.width)];
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [button addTarget:self action:@selector(onMenuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonList addObject:button];
        ++index;
    }
    return self;
}

- (void)insertMenuButtonOnView:(UIView*)view atPosition:(CGPoint)position
{
    _menuButton.frame = CGRectMake(position.x, position.y, _menuButton.frame.size.width, _menuButton.frame.size.height);
    [view addSubview:_menuButton];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissMenu)];
    [view addGestureRecognizer:singleTap];
    
    for (UIButton *button in _buttonList)
    {
        [_backgroundMenuView addSubview:button];
    }

    _backgroundMenuView.frame = CGRectMake(view.frame.size.width, 0, kCGSideW*2, view.frame.size.height);
    _backgroundMenuView.backgroundColor = [UIColor clearColor];
    [view addSubview:_backgroundMenuView];
}

#pragma mark - 
#pragma mark Menu button action

- (void)dismissMenuWithSelection:(UIButton*)button
{
    [UIView animateWithDuration:0.3f
                          delay:0.0f
         usingSpringWithDamping:.2f
          initialSpringVelocity:10.f
                        options:0 animations:^{
//                            button.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
                        }
                     completion:^(BOOL finished) {
                         [self dismissMenu];
                     }];
}

- (void)dismissMenu
{
    if (_isOpen)
    {
        _isOpen = !_isOpen;
       [self performDismissAnimation];
    }
}

- (void)showMenu
{
    if (!_isOpen)
    {
        _isOpen = !_isOpen;
        [self performSelectorInBackground:@selector(performOpenAnimation) withObject:nil];
    }
}

- (void)onMenuButtonClick:(UIButton*)button
{
    if ([self.delegate respondsToSelector:@selector(menuButtonClicked:)])
        [self.delegate menuButtonClicked:button.tag];
    [self dismissMenuWithSelection:button];
}

#pragma mark -
#pragma mark - Animations

- (void)performDismissAnimation
{
    [UIView animateWithDuration:0.4 animations:^{
        _menuButton.alpha = 1.0f;
        _menuButton.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
        _backgroundMenuView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
    }];
}

- (void)performOpenAnimation{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.4 animations:^{
            _menuButton.alpha = 0.0f;
//            _menuButton.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -kCGSideW - 10, 0);
            _backgroundMenuView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, -kCGSideW - 10, 0);
        }];
    });
//    for (UIButton *button in _buttonList)
//    {
//        [NSThread sleepForTimeInterval:0.02f];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            button.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 20, 0);
//            [UIView animateWithDuration:0.3f
//                                  delay:0.3f
//                 usingSpringWithDamping:.3f
//                  initialSpringVelocity:10.f
//                                options:0 animations:^{
//                                    button.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
//                                }
//                             completion:^(BOOL finished) {
//                             }];
//        });
//    }
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
