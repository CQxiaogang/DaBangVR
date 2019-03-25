//
//  LiveTableView.m
//  DaBangVR
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "LiveTableView.h"

@interface LiveTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation LiveTableView

static NSString *const CellID = @"CellID";

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = KWhiteColor;
        self.dataSource = self;
        self.delegate = self;
        [self registerNib:[UINib nibWithNibName:@"LiveTableViewCell" bundle:nil] forCellReuseIdentifier:CellID];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(200);
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self ;
}
@end
