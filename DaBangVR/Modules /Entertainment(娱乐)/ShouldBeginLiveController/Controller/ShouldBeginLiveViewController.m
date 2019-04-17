//
//  BeginLiveViewController.m
//  DaBangVR
//
//  Created by mac on 2019/4/11.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "ShouldBeginLiveViewController.h"
#import "HomeViewController.h"
#import "DidBeginLiveViewController.h"
#import "ShouldBeginLiveGoodsCell.h"
#import "ShouldBeginLiveGoodsModel.h"
@interface ShouldBeginLiveViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
/** 直播标题 */
@property (weak, nonatomic) IBOutlet UITextField *liveTitleTextField;
/** 直播封面 */
@property (weak, nonatomic) IBOutlet UIImageView *liveCoverImgView;
/** 开始直播按钮 */
@property (weak, nonatomic) IBOutlet UIButton *shouldBeginLiveBtn;
/** 选择商品顶部的标题，用去定位商品列表 */
@property (weak, nonatomic) IBOutlet UILabel *goodsTitle;
/** 直播时选择主推商品界面 */
@property (nonatomic, strong) UICollectionView *collectionView;
/** 直播时选择主推商品的数据源 */
@property (nonatomic, strong) NSArray<ShouldBeginLiveGoodsModel *> *dataSource;
/** 记录当前选择的ID */
@property (nonatomic, strong) NSMutableArray *selectIDArr;
/** 记录标题，封面，选择的商品字典 */
@property (nonatomic, strong) NSMutableDictionary *infoDic;
@end

@implementation ShouldBeginLiveViewController

static NSString *const cellID = @"cellID";

#pragma mark —— 懒加载
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置每个item的大小
        layout.itemSize = CGSizeMake(105, 146);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.backgroundColor = KWhiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //允许多个选择
        _collectionView.allowsMultipleSelection = YES;
        //取消滚动条
        _collectionView.showsVerticalScrollIndicator = NO;
        //注册Cell
        [_collectionView registerNib:[UINib nibWithNibName:@"ShouldBeginLiveGoodsCell" bundle:nil] forCellWithReuseIdentifier:cellID];
        
    }
    return _collectionView;
}

-(NSMutableArray *)selectIDArr{
    if (!_selectIDArr) {
        _selectIDArr = [[NSMutableArray alloc] init];
    }
    return _selectIDArr;
}

-(NSMutableDictionary *)infoDic{
    if (!_infoDic) {
        _infoDic = [[NSMutableDictionary alloc] init];
    }
    return _infoDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _liveTitleTextField.delegate = self;
    //给imageView添加点击
    _liveCoverImgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(liveCoverImgViewClick:)];
    [_liveCoverImgView addGestureRecognizer:tap];
    
    [self loadingData];
}

-(void)setupUI{
    [super setupUI];
    
    UILabel *topView = [[UILabel alloc] init];
    topView.text = @"直播";
    topView.textColor = KWhiteColor;
    topView.adaptiveFontSize = 15;
    topView.textAlignment = NSTextAlignmentCenter;
    topView.backgroundColor = KLightGreen;
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(kStatusBarHeight);
        make.height.equalTo(kNavBarHeight);
    }];
    UIButton *comeBackBtn = [[UIButton alloc] init];
    comeBackBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    [comeBackBtn addTarget:self action:@selector(comeBackButtonOfClick) forControlEvents:UIControlEventTouchUpInside];
    [comeBackBtn setImage:[UIImage imageNamed:@"comeBack"] forState:UIControlStateNormal];
    [self.view addSubview:comeBackBtn];
    [comeBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.top.equalTo(kStatusBarHeight);
        make.width.equalTo(60);
        make.height.equalTo(kNavBarHeight);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.right.equalTo(-20);
        make.top.equalTo(self.goodsTitle.mas_bottom).offset(10);
        make.bottom.equalTo(self.shouldBeginLiveBtn.mas_top).offset(-10);
    }];
}

-(void)loadingData{
    kWeakSelf(self);
    [NetWorkHelper POST:URl_getLiveGoodgsList parameters:nil success:^(id  _Nonnull responseObject) {
        NSDictionary *data = KJSONSerialization(responseObject)[@"data"];
        weakself.dataSource = [ShouldBeginLiveGoodsModel mj_objectArrayWithKeyValuesArray:data];
        [self.collectionView reloadData];
    } failure:nil];
}

/** 反正按钮 */
- (void)comeBackButtonOfClick{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/** 开始直播按钮 */
- (IBAction)shouldBeginLIveBtnOfClick:(id)sender {
    DidBeginLiveViewController *vc = [DidBeginLiveViewController new];
    //利用keyValue的方式（KVO）去除数组中重复数据
    self.selectIDArr = [self.selectIDArr valueForKeyPath:@"@distinctUnionOfObjects.self"];
    //数组转字符串
    NSString *goodsIds = [self.selectIDArr componentsJoinedByString:@","];
    [self.infoDic setObject:goodsIds forKey:@"goodsIds"];
    vc.parameters = self.infoDic;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark —— UICollectionView dataSource;
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShouldBeginLiveGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.model = _dataSource[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ShouldBeginLiveGoodsModel *model = _dataSource[indexPath.row];
    [self.selectIDArr addObject:model.id];
}

#pragma mark —— UITextField 协议
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self.infoDic setObject:textField.text forKey:@"liveTitle"];
}

-(void)liveCoverImgViewClick:(UITapGestureRecognizer *)tap{
    //初始化UIImagePickerController类
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //判断数据来源为相册
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.delegate = self;
    //打开相册
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark —— 调用相册协议
/** 选择完成回调 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    //获取图片
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    _liveCoverImgView.image = img;
//    NSData *imgData = UIImageJPEGRepresentation(img, 0.000001);
    [self.infoDic setObject:img forKey:@"coverUrl"];
}
@end
