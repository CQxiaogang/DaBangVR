//
//  modifyAddressViewController.m
//  DaBangVR
//
//  Created by mac on 2019/1/7.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "ModifyAddressViewController.h"
// views
#import "ModifyAddressViewCell.h"
// Models
#import "ModifyAddressModel.h"
#import "ModifyAddressAreaModel.h"
#import "UserAddressModel.h"

@interface ModifyAddressViewController ()<ModifyAddressViewCellDelegate,UITextViewDelegate>
{
    NSInteger _areaIndex;
    NSString *_areaID;
    NSString *_addressInfor;
}

@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, copy) NSArray *placeholderArr;

@property (nonatomic, strong) NSMutableArray *area_dataArray1;
@property (nonatomic, strong) NSMutableArray *area_dataArray2;
@property (nonatomic, strong) NSMutableArray *area_dataArray3;

@property (nonatomic, strong) ModifyAddressViewCell *cell;
@property (nonatomic, strong) UILabel *placeholderLabel;
// 用户，地址信息
@property (nonatomic, strong) NSMutableDictionary *user_AdressDic;
@property (nonatomic, strong) NSMutableArray *areaIDs;
@property (nonatomic, copy) NSString *boolStr;
@property (nonatomic, copy) NSArray <UserAddressModel *> *addressData;
@property (nonatomic, strong) UserAddressModel *userAddressModel;
@property (nonatomic, strong) NSMutableArray   *userAddressData;
@property (nonatomic, strong) NSMutableArray   *siteData;
@property (nonatomic, strong) AreaView *areaView;
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

#pragma mark —— 懒加载
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

-(NSMutableDictionary *)user_AdressDic{
    if (!_user_AdressDic) {
        _user_AdressDic = [[NSMutableDictionary alloc] init];
    }
    return _user_AdressDic;
}

- (NSMutableArray *)areaIDs{
    if (!_areaIDs) {
        _areaIDs = [[NSMutableArray array] init];
    }
    return _areaIDs;
}

-(NSMutableArray *)userAddressData{
    if (!_userAddressData) {
        _userAddressData = [NSMutableArray new];
    }
    return _userAddressData;
}

-(NSMutableArray *)siteData{
    if (!_siteData) {
        _siteData = [NSMutableArray new];
    }
    return _siteData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"编辑地址";
    _boolStr = @"0";
    _areaIndex = 0;
    _area_dataArray1 = [[NSMutableArray alloc]init];
    _area_dataArray2 = [[NSMutableArray alloc]init];
    _area_dataArray3 = [[NSMutableArray alloc]init];
    
//    [self loadingData];
}

-(void)loadingData{
    kWeakSelf(self);
    [NetWorkHelper POST:URl_addressListone parameters:@{@"id":_adressID} success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = KJSONSerialization(responseObject)[@"data"];
        NSArray *receivingAddressVoList = dic[@"receivingAddressVoList"];
        weakself.userAddressModel = [UserAddressModel mj_objectWithKeyValues:receivingAddressVoList[0]];
        [weakself.userAddressData addObject:weakself.userAddressModel.consigneeName];
        [weakself.userAddressData addObject:weakself.userAddressModel.consigneePhone];
        NSString *area = weakself.userAddressModel.area;
        NSString *province = weakself.userAddressModel.province;
        NSString *city = weakself.userAddressModel.city;
        [weakself.userAddressData addObject:[NSString stringWithFormat:@"%@%@%@",province,city,area]];
        
        [weakself.siteData addObject:area];
        [weakself.siteData addObject:province];
        [weakself.siteData addObject:city];
        weakself.areaView.siteData = weakself.siteData;
        [self.tableView reloadData];
    } failure:nil];
}

- (void)setupUI{
    [super setupUI];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ModifyAddressViewCell" bundle:nil] forCellReuseIdentifier:CellID];
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
    [rightSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];
    [footerView addSubview:rightSwitch];
    [rightSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.centerY.equalTo(footerView.mas_centerY);
        make.size.equalTo(CGSizeMake(50, 30));
    }];
}

#pragma mark —— 保存地址信息
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
    [self.user_AdressDic setObject:_boolStr forKey:@"isDefault"];
    if ([self.user_AdressDic allKeys].count == 8) {
        [NetWorkHelper POST:URl_addressAdd parameters:self.user_AdressDic success:^(id  _Nonnull responseObject) {
            NSString *errmsg = KJSONSerialization(responseObject)[@"errmsg"];
            [SVProgressHUD showInfoWithStatus:errmsg];
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            [SVProgressHUD dismissWithDelay:1.0];
            [self.navigationController popViewControllerAnimated:NO];
        } failure:^(NSError * _Nonnull error) {}];
    }else{
        [SVProgressHUD showInfoWithStatus:@"信息不全,请填完信息"];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD dismissWithDelay:1.0];
    }
}

#pragma mark —— tableView delegate/dataSource;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    _cell.delegate = self;
    if (_cell == nil) {
        _cell = [[ModifyAddressViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }

    if (indexPath.row == 3) {
        [_cell removeAllSubviews];
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, _cell.mj_w, kFit(100))];
        textView.delegate = self;
        _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(kFit(10), 0, textView.mj_w-kFit(10), kFit(30))];
        _placeholderLabel.text = _userAddressModel.address?_userAddressModel.address:@"详细地址:如道路,门牌号,小区,楼栋号,单元室等";
        _placeholderLabel.adaptiveFontSize = 14;
        _placeholderLabel.textColor = KFontColor;
        [textView addSubview:_placeholderLabel];
        [_cell addSubview:textView];
    }else{
        _cell.titleLabel.text = self.titleArr[indexPath.row];
        _cell.contentText.tag = indexPath.row;
        
        if (self.userAddressData.count == 3) {
           _cell.contentText.text = self.userAddressData[indexPath.row];
        }else{
           _cell.contentText.placeholder = self.placeholderArr[indexPath.row];
        }
    }
    
    if (indexPath.row == 2) {
        UIButton *btn = [[UIButton alloc] initWithFrame:_cell.contentText.frame];
        [btn addTarget:self action:@selector(buttonClickAction) forControlEvents:UIControlEventTouchUpInside];
        if (_addressInfor) {
            _cell.contentText.text = _addressInfor;
        }
        [_cell addSubview:btn];
    }
    return _cell;
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
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 0) {
        // 收货人名称
        [self.user_AdressDic setObject:textField.text forKey:@"consigneeName"];
    }else if (textField.tag == 1){
        // 收货人手机号
        [self.user_AdressDic setObject:textField.text forKey:@"consigneePhone"];
    }
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
    // 区域 ID
    [self.areaIDs addObject:areaID];
    if (self.areaIDs.count == 3) {
        [_cell.contentText becomeFirstResponder];
        [self.user_AdressDic setObject:@"1"            forKey:@"receivingCountry"];
        [self.user_AdressDic setObject:self.areaIDs[0] forKey:@"province"]; // 675
        [self.user_AdressDic setObject:self.areaIDs[1] forKey:@"city"];     //1572
        [self.user_AdressDic setObject:self.areaIDs[2] forKey:@"area"];
        [self.areaIDs removeAllObjects];
    }
    
    [self requestAllAreaName];
}
- (void)getSelectAddressInfor:(NSString *)addressInfor addressInfoArr:(NSArray *)array
{
//    [self.user_AdressDic setObject:@"中国" forKey:@"receivingCountry"];
//    [self.user_AdressDic setObject:array[0] forKey:@"province"];
//    [self.user_AdressDic setObject:array[1] forKey:@"city"];
//    [self.user_AdressDic setObject:array[2] forKey:@"area"];
    
    _addressInfor = addressInfor;
    [self.tableView reloadData];
}

#pragma mark - requestAllAreaName
- (void)requestAllAreaName
{
    if (!_areaView) {
        _areaView = [[AreaView alloc]initWithFrame:CGRectMakes(0, 0, 375, 667)];
        _areaView.hidden = YES;
        _areaView.address_delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:_areaView];
    }
    kWeakSelf(self);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    // 网络请求得到地区信息
    _areaID = _areaID? _areaID : @"1";
    [NetWorkHelper POST:URl_getRegionChildrenList parameters:@{@"parentId":_areaID} success:^(id  _Nonnull responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *regionList = dic[@"regionList"];
        for (NSDictionary *dic in regionList) {
            ModifyAddressAreaModel *addressAreaModel = [ModifyAddressAreaModel modelWithDictionary:dic];
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
                [weakself.areaView showAreaView];
                [weakself.areaView setProvinceArray:weakself.area_dataArray1];
            }
                break;
            case 1:
                [weakself.areaView setCityArray:weakself.area_dataArray2];
                break;
            case 2:
                [weakself.areaView setRegionsArray:weakself.area_dataArray3];
                break;
            default:
                break;
        }
    });
}

- (void)buttonClickAction{
    if (!_areaView) {
        [self requestAllAreaName];
    }else{
        [_areaView showAreaView];
        [_cell.contentText resignFirstResponder];
    }
}

#pragma mark —— UITextView 协议
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(nonnull NSString *)text{
    if (![text isEqualToString:@""])
    {
        _placeholderLabel.hidden = YES;
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
        
    {
        _placeholderLabel.hidden = NO;
    }
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    // 详细地址
    [self.user_AdressDic setObject:textView.text forKey:@"address"];
}


#pragma mark —— UISwitch
- (void)valueChanged:(UISwitch*)sender{
    NSString *boolStr;
    if (sender.on == YES) {
        _boolStr = @"1" ;
    }else{
        _boolStr = @"0";
    }
    // 默认地址
    [self.user_AdressDic setObject:_boolStr forKey:@"isDefault"];
}

@end
