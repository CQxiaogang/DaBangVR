//
//  AttributeViewViewController.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/22.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "AttributeViewViewController.h"
#import "JXCategoryTitleAttributeView.h"

@interface AttributeViewViewController ()

@property (nonatomic, strong) JXCategoryTitleAttributeView *myCategoryView;
@property (nonatomic, strong) NSMutableArray <NSAttributedString *> *attributeTitles;
@end

@implementation AttributeViewViewController

- (void)viewDidLoad {
    _attributeTitles = [NSMutableArray new];
   
    for (int i = 0; i<=23; i++) {
        NSString *string = [NSString stringWithFormat:@"%d:00\n海鲜粉",i];
        if (i < 9) {
            string = [NSString stringWithFormat:@"0%d:00\n海鲜粉",i];
        }
        NSMutableAttributedString *timeTitle = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15], NSForegroundColorAttributeName : [UIColor grayColor]}];
        [timeTitle addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 2)];
        [_attributeTitles addObject:timeTitle];
    }
    NSMutableArray *titles = [NSMutableArray array];
    for (NSMutableAttributedString *attriString in self.attributeTitles) {
        [titles addObject:attriString.string];
    }
    self.titles = titles;

    [super viewDidLoad];

    self.myCategoryView.attributeTitles = self.attributeTitles;

    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.backgroundViewHeight = 40;
    backgroundView.backgroundViewCornerRadius = 5;
    self.myCategoryView.indicators = @[backgroundView];
}

- (JXCategoryTitleAttributeView *)myCategoryView {
    return (JXCategoryTitleAttributeView *)self.categoryView;
}

- (JXCategoryBaseView *)preferredCategoryView {
    return [[JXCategoryTitleAttributeView alloc] init];
}

@end
