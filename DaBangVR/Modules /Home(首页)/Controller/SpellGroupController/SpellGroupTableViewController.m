//
//  SpellGroupTableViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/16.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "SpellGroupTableViewController.h"
// Cell
#import "SpellGroupCell.h"
#import "MySpellGroupCell.h"

@interface SpellGroupTableViewController ()

@end

@implementation SpellGroupTableViewController
static NSString *CellID = @"CellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([_currentView isEqualToString:@"leftView"]) {
        [self.tableView registerNib:[UINib nibWithNibName:@"SpellGroupCell" bundle:nil] forCellReuseIdentifier:CellID];
    }else if ([_currentView isEqualToString:@"centerView"])
    {
        
    }else if ([_currentView isEqualToString:@"rightView"]){
        [self.tableView registerNib:[UINib nibWithNibName:@"MySpellGroupCell" bundle:nil] forCellReuseIdentifier:CellID];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if ([_currentView isEqualToString:@"leftView"]) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
        cell = (SpellGroupCell *)cell;
    }else if ([_currentView isEqualToString:@"centerView"])
    {
    }else if ([_currentView isEqualToString:@"rightView"]){
        cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
        cell = (MySpellGroupCell *)cell;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_currentView isEqualToString:@"leftView"]) {
        return 218;
    }else if ([_currentView isEqualToString:@"centerView"])
    {
        
    }else if ([_currentView isEqualToString:@"rightView"]){
        return 130;
    }
    return 0;
}
#pragma mark - JXCategoryListContentViewDelegate

- (UIView *)listView {
    return self.view;
}

- (void)listDidAppear {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)listDidDisappear {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


@end
