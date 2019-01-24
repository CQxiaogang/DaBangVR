//
//  modifyAddressViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "ModifyAddressViewController.h"
// views
#import "modifyAddressViewCell.h"
// Models
#import "AddressModel.h"
#import "AddressAreaModel.h"

@interface ModifyAddressViewController ()<ModifyAddressViewCellDelegate>
{
    AreaView *areaView;
    NSInteger _areaIndex;
    NSString *_areaID;
}

@property (nonatomic, copy) NSArray *titleArr;

@property (nonatomic, copy) NSArray *placeholderArr;

@property (nonatomic, strong) NSMutableArray *area_dataArray1;
@property (nonatomic, strong) NSMutableArray *area_dataArray2;
@property (nonatomic, strong) NSMutableArray *area_dataArray3;

@end

CG_INLINE CGRect CGRectMakes(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    float secretNum = [[UIScreen mainScreen] bounds].size.width / 375;
    rect.origin.x = x*secretNum; rect.origin.y = y*secretNum;
    rect.size.width = width*secretNum; rect.size.height = height*secretNum;
    
    return rect;
}

@implementation ModifyAddressViewController

static NSString *const CellID = @"CellID";

- (NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = @[@"收货人:",
                      @"联系方式:",
                      @"所在地区:"];
    }
    return _titleArr;
}
- (NSArray *)placeholderArr{
    if (!_placeholderArr) {
        _placeholderArr = @[@"收货人",
                            @"手机号码",
                            @"所在地区"
                            ];
    }
    return _placeholderArr;
}

#pragma mark —— 懒加载
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"编辑地址";
    
    _areaIndex = 0;
    _area_dataArray1 = [[NSMutableArray alloc]init];
    _area_dataArray2 = [[NSMutableArray alloc]init];
    _area_dataArray3 = [[NSMutableArray alloc]init];
}

- (void)setupUI{
    [super setupUI];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"modifyAddressViewCell" bundle:nil] forCellReuseIdentifier:CellID];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kTopHeight);
        make.left.right.equalTo(@(0));
        make.bottom.equalTo(-kTabBarHeight);
    }];
    
    [self setUpTableViewOfFooterView];
    [self setupBottomView];
}

// 设置 tableView 的尾部视图
- (void)setUpTableViewOfFooterView{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 40)];
    footerView.layer.masksToBounds = YES;
    footerView.layer.borderWidth = 0.3;
    footerView.layer.borderColor = [[UIColor lightGreen] CGColor];
    self.tableView.tableFooterView = footerView;
    
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.text = @"设为默认地址";
    leftLabel.textColor = KFontColor;
    leftLabel.font = [UIFont systemFontOfSize:14];
    [footerView addSubview:leftLabel];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(14);
        make.centerY.equalTo(footerView.mas_centerY);
        make.size.equalTo(CGSizeMake(100, 40));
    }];
    
    UISwitch *rightSwitch = [[UISwitch alloc] init];
    rightSwitch.onTintColor = [UIColor lightGreen];
    [footerView addSubview:rightSwitch];
    [rightSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.centerY.equalTo(footerView.mas_centerY);
        make.size.equalTo(CGSizeMake(50, 30));
    }];
    
}

- (void)setupBottomView{
    UIButton *sureBtn = [[UIButton alloc] init];
    [sureBtn setTitle:@"保存" forState:UIControlStateNormal];
    sureBtn.titleLabel.textColor = KWhiteColor;
    sureBtn.backgroundColor = [UIColor lightGreen];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [sureBtn addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(kTabBarHeight);
    }];
}
- (void)saveInfo{
    DLog(@"保存");
}

#pragma mark —— tableView delegate/dataSource;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    modifyAddressViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    cell.delegate = self;
    if (cell == nil) {
        cell = [[modifyAddressViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }

    if (indexPath.row == 3) {
        [cell removeAllSubviews];
        cell.backgroundColor = KRedColor;
    }else{
        cell.titleLabel.text = self.titleArr[indexPath.row];
        cell.contentText.placeholder = self.placeholderArr[indexPath.row];
        cell.contentText.tag = indexPath.row;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        return kFit(100);
    }
    return kFit(40);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 1;
}

#pragma mark —— ModifyAddressViewCell 协议

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 2) {
        if (!areaView) {
            [self requestAllAreaName];
        }
        else
            [areaView showAreaView];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}

#pragma mark - AreaSelectDelegate
- (void)selectIndex:(NSInteger)index selectID:(NSString *)areaID
{
    _areaIndex = index;
    _areaID = areaID;
    switch (_areaIndex) {
        case 1:
            [_area_dataArray2 removeAllObjects];
            break;
        case 2:
            [_area_dataArray3 removeAllObjects];
            break;
        default:
            break;
    }
    [self requestAllAreaName];
}
- (void)getSelectAddressInfor:(NSString *)addressInfor
{
    
}

#pragma mark - requestAllAreaName
- (void)requestAllAreaName
{
    if (!areaView) {
        areaView = [[AreaView alloc]initWithFrame:CGRectMakes(0, 0, 375, 667)];
        areaView.hidden = YES;
        areaView.address_delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:areaView];
    }
    kWeakSelf(self);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    NSString *areaIndex = [NSString stringWithFormat:@"%ld",(long)_areaIndex];
    areaIndex = areaIndex? areaIndex: @"0";
    _areaID   = _areaID ? _areaID:@"1";
    NSDictionary *parameters = @{
                                 @"areaId":_areaID,
                                 @"type"  :areaIndex
                                 };
    [NetWorkHelper POST:URl_proviceList parameters:parameters success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *dataList = dic[@"dataList"];
        for (NSDictionary *dic in dataList) {
            AddressAreaModel *addressAreaModel = [AddressAreaModel modelWithDictionary:dic];
            switch (self->_areaIndex) {
                case 0:
                    [weakself.area_dataArray1 addObject:addressAreaModel];
                    break;
                case 1:
                    [weakself.area_dataArray2 addObject:addressAreaModel];
                    break;
                case 2:
                    [weakself.area_dataArray3 addObject:addressAreaModel];
                    break;
                default:
                    break;
            }
        }
        dispatch_group_leave(group);
    } failure:^(NSError * _Nonnull error) {}];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        switch (self->_areaIndex) {
            case 0:
            {
                [self->areaView showAreaView];
                [self->areaView setProvinceArray:weakself.area_dataArray1];
            }
                break;
            case 1:
                [self->areaView setCityArray:weakself.area_dataArray2];
                break;
            case 2:
                [self->areaView setRegionsArray:weakself.area_dataArray3];
                break;
            default:
                break;
        }
    });
    
   
    
//    NSString *path = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%ld",areaIndex + 1] ofType:@"plist"];
//    NSMutableDictionary *plistDic=[NSMutableDictionary dictionaryWithContentsOfFile:path];
//
//    for (NSDictionary *sh_dic in plistDic[@"data"][@"sh_items"]) {
//        AddressAreaModel *addressAreaModel = [[AddressAreaModel alloc]init];
//        [addressAreaModel setValuesForKeysWithDictionary:sh_dic];
//        switch (areaIndex) {
//            case 0:
//                [weakself.area_dataArray1 addObject:addressAreaModel];
//                break;
//            case 1:
//                [weakself.area_dataArray2 addObject:addressAreaModel];
//                break;
//            case 2:
//                [weakself.area_dataArray3 addObject:addressAreaModel];
//                break;
//            default:
//                break;
//        }
//    }
    
    
}

@end
