//
//  MineCollectionViewController.m
//  DaBangVR
//
//  Created by mac on 2019/2/12.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "MineCollectionViewController.h"
// Cells
#import "MineCollectionTableViewCell.h"

@interface MineCollectionViewController ()

@property (nonatomic, strong) NSArray <NSString *> *titles;

@end

@implementation MineCollectionViewController

static NSString *CellID = @"CellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收藏";
    
    [NetWorkHelper POST:URl_getGoodsCollectList parameters:nil success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = KJSONSerialization(responseObject);
     
        DLog(@"--------%@",responseObject);
        DLog(@"--------%@",dic);
        DLog(@"--------%@",dic);
        DLog(@"--------%@",dic);
    } failure:nil];
}

- (void)setupUI{
    [super setupUI];
    [self.tableView registerNib:[UINib nibWithNibName:@"MineCollectionTableViewCell" bundle:nil] forCellReuseIdentifier:CellID];
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, .5)];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(kTopHeight);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kFit(91);
}


@end
