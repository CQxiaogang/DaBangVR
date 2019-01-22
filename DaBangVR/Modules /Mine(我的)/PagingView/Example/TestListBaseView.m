//
//  TestListBaseView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "TestListBaseView.h"
#import "MineTableViewCell.h"

@interface TestListBaseView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
// talbleView每一个cell的title
@property (nonatomic, strong) NSArray *titleArray;
// tableView每一个cell的image
@property (nonatomic, strong) NSArray *imageArray;
@end

@implementation TestListBaseView

- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"消息",@"收藏",@"余额",@"等级",@"红包/卡包",@"实名认证",@"主播认证",@"反馈"];
    }
    return _titleArray;
}
- (NSArray *)imageArray{
    if (!_imageArray) {
        _imageArray = @[@"p_news",@"p_collections",@"p_balance",@"p_Grade",@"p_Red_envelopes",@"p_Real_name",@"p_Live_broadcast",@"p_feedback"];
    }
    return _imageArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStyleGrouped];
        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.tableFooterView = [UIView new];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        [self.tableView registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.tableView.frame = self.bounds;
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 3;
            break;
        default:
            break;
    }
    return 0;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[MineTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    if (indexPath.section == 0) {
        cell.titleLabel.text = self.titleArray[indexPath.row];
        cell.titleImageV.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    }else if(indexPath.section ==1){
        cell.titleLabel.text = self.titleArray[indexPath.row + 3];
        cell.titleImageV.image = [UIImage imageNamed:self.imageArray[indexPath.row + 3]];
    }else{
        cell.titleLabel.text = self.titleArray[indexPath.row + 5];
        cell.titleImageV.image = [UIImage imageNamed:self.imageArray[indexPath.row + 5]];
    }
    [cell.contentLabel removeFromSuperview];
    [cell.otherImageV removeFromSuperview];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

///设置header的高和视图,两个方法同时用才生效
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 10;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]init];
    return headerView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.scrollCallback(scrollView);
}


#pragma mark - JXPagingViewListViewDelegate

- (UIScrollView *)listScrollView {
    return self.tableView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (UIView *)listView {
    return self;
}

@end
