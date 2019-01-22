//
//  DWQCartTableViewCell.m
//  DWQCartViewController
//
//  Created by 杜文全 on 16/2/13.
//  Copyright © 2016年 com.iOSDeveloper.duwenquan. All rights reserved.
//  https://github.com/DevelopmentEngineer-DWQ/DWQShoppingCart
//  http://www.jianshu.com/u/725459648801

#import "DWQCartTableViewCell.h"
#import "DWQConfigFile.h"
//#import "DWQCartModel.h"
#import "DWQGoodsModel.h"


@interface DWQCartTableViewCell ()
{
    DWQNumberChangedBlock numberAddBlock;
    DWQNumberChangedBlock numberCutBlock;
    DWQCellSelectedBlock cellSelectedBlock;
}
//选中按钮
@property (nonatomic,retain) UIButton *selectBtn;
//显示照片
@property (nonatomic,retain) UIImageView *dwqImageView;
//商品名
@property (nonatomic,retain) UILabel *nameLabel;
//原价
@property (nonatomic,retain) UILabel *originalPriceLabel;
//时间
@property (nonatomic,retain) UILabel *dateLabel;
//价格
@property (nonatomic,retain) UILabel *PreferentialPriceLabel;
//数量
@property (nonatomic,retain) UILabel *numberLabel;
//背景view
@property (nonatomic,retain) UIView *bgView;
//加按钮
@property (nonatomic,retain) UIButton *addBtn;
//减按钮
@property (nonatomic,retain) UIButton *cutBtn;

@end

@implementation DWQCartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = DWQColorFromRGB(245, 246, 248);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupMainView];
    }
    return self;
}
#pragma mark - public method
- (void)reloadDataWithModel:(DWQGoodsModel*)model {
    
    self.dwqImageView.image = model.image;
    self.nameLabel.text = model.goodsName;
    self.PreferentialPriceLabel.text = model.price;
    self.dateLabel.text = model.price;
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)model.count];
//    self.sizeLabel.text = model.sizeStr;
    self.selectBtn.selected = model.select;
}

- (void)numberAddWithBlock:(DWQNumberChangedBlock)block {
    numberAddBlock = block;
}

- (void)numberCutWithBlock:(DWQNumberChangedBlock)block {
    numberCutBlock = block;
}

- (void)cellSelectedWithBlock:(DWQCellSelectedBlock)block {
    cellSelectedBlock = block;
}
#pragma mark - 重写setter方法
- (void)setDwqNumber:(NSInteger)dwqNumber {
    _dwqNumber = dwqNumber;
    
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)dwqNumber];
}

- (void)setDwqSelected:(BOOL)dwqSelected {
    _dwqSelected = dwqSelected;
    self.selectBtn.selected = dwqSelected;
}
#pragma mark - 按钮点击方法
- (void)selectBtnClick:(UIButton*)button {
    button.selected = !button.selected;
    
    if (cellSelectedBlock) {
        cellSelectedBlock(button.selected);
    }
}

- (void)addBtnClick:(UIButton*)button {
    
    NSInteger count = [self.numberLabel.text integerValue];
    count++;
    
    if (numberAddBlock) {
        numberAddBlock(count);
    }
}

- (void)cutBtnClick:(UIButton*)button {
    NSInteger count = [self.numberLabel.text integerValue];
    count--;
    if(count <= 0){
        return ;
    }

    if (numberCutBlock) {
        numberCutBlock(count);
    }
}
#pragma mark - 布局主视图
-(void)setupMainView {
    //白色背景
    UIView *bgView = [[UIView alloc]init];
    bgView.layer.borderColor = DWQColorFromHex(0xEEEEEE).CGColor;
    bgView.layer.borderWidth = 1;
    [self addSubview:bgView];
    self.bgView = bgView;
    
    //选中按钮
    UIButton* selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setImage:[UIImage imageNamed:dwq_Bottom_UnSelectButtonString] forState:UIControlStateNormal];
    [selectBtn setImage:[UIImage imageNamed:dwq_Bottom_SelectButtonString] forState:UIControlStateSelected];
    [selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:selectBtn];
    self.selectBtn = selectBtn;
    
    //照片背景
    UIView *imageBgView = [[UIView alloc]init];
    imageBgView.backgroundColor = DWQColorFromHex(0xF3F3F3);
    [bgView addSubview:imageBgView];
    
    //显示照片
    UIImageView* imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"default_pic_1"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [bgView addSubview:imageView];
    self.dwqImageView = imageView;
    
    //商品名
    UILabel* nameLabel = [[UILabel alloc]init];
    nameLabel.adaptiveFontSize = 12;
    [bgView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    //原价
    UILabel* originalPriceLabel = [[UILabel alloc]init];
    originalPriceLabel.textColor = DWQColorFromRGB(132, 132, 132);
    originalPriceLabel.adaptiveFontSize = 10;
    originalPriceLabel.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:originalPriceLabel];
    self.originalPriceLabel = originalPriceLabel;
    
    //优惠后价格
    UILabel* PreferentialPriceLabel = [[UILabel alloc]init];
    PreferentialPriceLabel.font = [UIFont boldSystemFontOfSize:16];
    PreferentialPriceLabel.textColor = BASECOLOR_RED;
    PreferentialPriceLabel.textAlignment = NSTextAlignmentLeft;
    [bgView addSubview:PreferentialPriceLabel];
    self.PreferentialPriceLabel = PreferentialPriceLabel;
    
    //时间
    UILabel* dateLabel = [[UILabel alloc]init];
    dateLabel.font = [UIFont systemFontOfSize:10];
    dateLabel.textColor = DWQColorFromRGB(132, 132, 132);
    [bgView addSubview:dateLabel];
    self.dateLabel = dateLabel;
    
    //数量加按钮
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addBtn setImage:[UIImage imageNamed:@"cart_addBtn_nomal"] forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"cart_addBtn_highlight"] forState:UIControlStateHighlighted];
    [addBtn addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:addBtn];
    self.addBtn = addBtn;
    
    //数量显示
    UILabel* numberLabel = [[UILabel alloc]init];
    numberLabel.textAlignment = NSTextAlignmentCenter;
    numberLabel.text = @"1";
    numberLabel.adaptiveFontSize = 12;
    [bgView addSubview:numberLabel];
    self.numberLabel = numberLabel;
    
    //数量减按钮
    UIButton *cutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cutBtn setImage:[UIImage imageNamed:@"cart_cutBtn_nomal"] forState:UIControlStateNormal];
    [cutBtn setImage:[UIImage imageNamed:@"cart_cutBtn_highlight"] forState:UIControlStateHighlighted];
    [cutBtn addTarget:self action:@selector(cutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:cutBtn];
    self.cutBtn = cutBtn;
}

-(void)layoutSubviews{
    kWeakSelf(self);
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.height.equalTo(90);
    }];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.bgView.centerY);
        make.left.equalTo(20);
        make.height.equalTo(15);
        make.width.equalTo(15);
    }];
    
    [self.dwqImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakself.bgView.centerY);
        make.left.equalTo(weakself.selectBtn.mas_right).offset(20);
        make.size.equalTo(CGSizeMake(70, 70));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dwqImageView.mas_right).offset(10);
        make.right.equalTo(-10);
        make.top.equalTo(10);
        make.height.equalTo(30);
    }];
    
    [self.originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dwqImageView.mas_right).offset(10);
        make.right.equalTo(-80);
        make.top.equalTo(weakself.nameLabel.mas_bottom).offset(5);
        make.height.equalTo(15);
    }];
    
    [self.PreferentialPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dwqImageView.mas_right).offset(10);
        make.right.equalTo(-80);
        make.top.equalTo(weakself.originalPriceLabel.mas_bottom).offset(5);
        make.height.equalTo(15);
    }];
    
    [self.cutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-10);
        make.bottom.equalTo(-10);
        make.size.equalTo(CGSizeMake(15, 15));
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.cutBtn.mas_left).offset(0);
        make.bottom.equalTo(-10);
        make.size.equalTo(CGSizeMake(15, 15));
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.numberLabel.mas_left).offset(0);
        make.bottom.equalTo(-10);
        make.size.equalTo(CGSizeMake(15, 15));
    }];
}

@end
