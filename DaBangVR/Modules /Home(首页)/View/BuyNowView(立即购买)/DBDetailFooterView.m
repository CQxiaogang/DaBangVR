//
//  DBDetailFooterView.m
//  DaBangVR
//
//  Created by mac on 2019/1/5.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "DBDetailFooterView.h"

// Views
#import "DBDetailFooterCell.h"

static NSString *CellID = @"CellID";
@interface DBDetailFooterView ()
@property (nonatomic, strong) NSArray *infoArray;
@property (nonatomic, strong) NSMutableArray *rigthViewArray;
@end
@implementation DBDetailFooterView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        [self registerNib:[UINib nibWithNibName:@"DBDetailFooterCell" bundle:nil] forCellReuseIdentifier:CellID];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

-(NSArray *)infoArray{
    if (!_infoArray) {
        _infoArray = @[@"配送方式",@"需要发票",@"买家留言"];
    }
    return _infoArray;
}

-(NSMutableArray *)rigthViewArray{
    if (!_rigthViewArray) {
        _rigthViewArray = [NSMutableArray new];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.mj_w-90, 0, 80, 40)];
//        if ([_model.logisticsPrice isEqualToString:@"0"]) {
//            label.text = @"快递免邮";
//        }else{
//            label.text = [NSString stringWithFormat:@"快递费: %@ 元",_model.logisticsPrice];
//        }
        
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = KFontColor;
        label.font = [UIFont systemFontOfSize:14];
        [_rigthViewArray addObject:label];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.mj_w-40, 10, 20, 20)];
        [btn setImage:[UIImage imageNamed:@"a-hook"] forState:UIControlStateNormal];
        [_rigthViewArray addObject:btn];
        
        UIButton *leaveMessageBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.mj_w-210, 0, 200, 40)];
        [leaveMessageBtn setTitle:@"口味、偏好等要求" forState:UIControlStateNormal];
        [leaveMessageBtn setTitleColor:KFontColor forState:UIControlStateNormal];
        // btn 文字居右
        leaveMessageBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        leaveMessageBtn.titleLabel.adaptiveFontSize = 14;
        [leaveMessageBtn addTarget:self action:@selector(leaveMessageBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_rigthViewArray addObject:leaveMessageBtn];
    }
    return _rigthViewArray;
}

#pragma mark —— UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DBDetailFooterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[DBDetailFooterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    
    cell.textLabel.text = self.infoArray[indexPath.row];
    [cell addSubview:self.rigthViewArray[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)setModel:(OrderSureModel *)model{
    _model = model;
}

- (void)leaveMessageBtnAction{
    if (self.aDelegate && [self.aDelegate respondsToSelector:@selector(leaveMessageBtnClickAction)]) {
        [self.aDelegate leaveMessageBtnClickAction];
    }
}

@end
