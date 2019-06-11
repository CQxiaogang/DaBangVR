//
//  StoreDetailsTableView.m
//  DaBangVR
//
//  Created by mac on 2019/5/28.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "StoreDetailsTableView.h"
#import "StoreDetailsLeftTableViewCell.h"
#import "StoreDetailsRightTableViewCell.h"
#import "StoreDetailsTableViewHeaderView.h"
#import "CategoryModel.h"
#import "DeptDetailsGoodsCategoryModel.h"
#import "StoreGoodAttributesView.h"
#import "StoreDetailsShoppingCarModel.h"

static float kLeftTableViewWidth = 80.f;

@interface StoreDetailsTableView ()<UITableViewDelegate, UITableViewDataSource, StoreDetailsRightTableViewCellDelegate, UIScrollViewDelegate, CAAnimationDelegate>
{
    NSInteger _selectIndex;
    BOOL _isScrollDown;
}

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;

@property (nonatomic, strong) UIView *bottonView;

@property (nonatomic, strong) NSMutableArray *goodaData;
@property (nonatomic, strong) NSMutableArray <DeptDetailsGoodsCategoryModel*> *categoryData;

@property (nonatomic, assign) CGFloat endPoint_x;
@property (nonatomic, assign) CGFloat endPoint_y;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) CALayer *dotLayer;

@end

@implementation StoreDetailsTableView
#pragma mark —— 懒加载
-(UIScrollView *)contenView{
    if (!_contenView) {
        _contenView = [[UIScrollView alloc] init];
        _contenView.delegate = self;
        [_contenView addSubview:self.leftTableView];
        [_contenView addSubview:self.rightTableView];
        [self addSubview:_contenView];
    }
    return _contenView;
}

- (UITableView *)leftTableView
{
    if (!_leftTableView)
    {
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftTableViewWidth, _contenView.mj_h)];
        _leftTableView.delegate   = self;
        _leftTableView.dataSource = self;
        _leftTableView.rowHeight  = 55;
        _leftTableView.bounces    = NO;
        _leftTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _leftTableView.tableFooterView = [UIView new];
        _leftTableView.showsVerticalScrollIndicator = NO;
        _leftTableView.separatorColor = [UIColor clearColor];
        [_leftTableView registerClass:[StoreDetailsLeftTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Left];
    }
    return _leftTableView;
}

- (UITableView *)rightTableView
{
    if (!_rightTableView)
    {
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(kLeftTableViewWidth, 0, KScreenW-kLeftTableViewWidth, _contenView.mj_h)];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.rowHeight = 100;
        _rightTableView.bounces = NO;
        _rightTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _rightTableView.showsVerticalScrollIndicator = NO;
        [_rightTableView registerNib:[UINib nibWithNibName:@"StoreDetailsRightTableViewCell" bundle:nil] forCellReuseIdentifier:kCellIdentifier_Right];
    }
    return _rightTableView;
}

-(NSMutableArray *)goodaData{
    if (!_goodaData) {
        _goodaData = [[NSMutableArray alloc] init];
    }
    return _goodaData;
}

-(NSMutableArray<DeptDetailsGoodsCategoryModel *> *)categoryData{
    if (!_categoryData)
    {
        _categoryData = [NSMutableArray array];
    }
    return _categoryData;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _selectIndex  = 0;
        _isScrollDown = YES;
    
        self.backgroundColor = KWhiteColor;
        
        self.contenView.backgroundColor = KWhiteColor;
        
        self.bottonView.backgroundColor = KRedColor;
        
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                        animated:YES
                                  scrollPosition:UITableViewScrollPositionNone];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.contenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-kTabBarHeight);
        make.left.top.right.equalTo(0);
    }];
}

-(void)setDeptId:(NSString *)deptId{
    _deptId = deptId;
    kWeakSelf(self);
    [NetWorkHelper POST:URl_getDeptGoodsList parameters:@{@"deptId":_deptId} success:^(id  _Nonnull responseObject) {
        NSDictionary *data    = KJSONSerialization(responseObject)[@"data"];
        weakself.categoryData = [DeptDetailsGoodsCategoryModel mj_objectArrayWithKeyValuesArray:data[@"deliveryGoodsTypeVos"]];
        [self.leftTableView  reloadData];
        [self.rightTableView reloadData];
    } failure:nil];
}

#pragma mark - TableView DataSource Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.leftTableView == tableView)
    {
        return 1;
    }
    else
    {
        return self.categoryData.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.leftTableView == tableView)
    {
        return self.categoryData.count;
    }
    else
    {
        return [self.categoryData[section].deliveryGoodsVoList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.leftTableView == tableView)
    {
        StoreDetailsLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left];
        if (!cell) {
            cell = [[StoreDetailsLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier_Left];
        }
        DeptDetailsGoodsCategoryModel *model = self.categoryData[indexPath.row];
        cell.name.text = model.name;
        return cell;
    }
    else
    {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
        StoreDetailsRightTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[StoreDetailsRightTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell = [[[NSBundle mainBundle] loadNibNamed:@"StoreDetailsRightTableViewCell" owner:nil options:nil] firstObject];
        }
        cell.delegate = self;
        cell.model = self.categoryData[indexPath.section].deliveryGoodsVoList[indexPath.row];
        __weak __typeof(&*cell) weakCell = cell;
        cell.plusBlock = ^(NSDictionary *goodsInfo, BOOL boo) {
            
            [self.goodaData addObject:goodsInfo];
            self.shoppingCarInfo(self.goodaData);
            
            CGRect parentRect = [weakCell convertRect:weakCell.plusButton.frame toView:self];
            if (boo) {
                //这里是动画开始的方法
                [self joinCartAnimationWithRect:parentRect];
            }
        };
        cell.minusBlock = ^(NSDictionary *goodsInfo, BOOL animated) {
            [self.goodaData removeObject:goodsInfo];
            self.shoppingCarInfo(self.goodaData);
        };
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.rightTableView == tableView)
    {
        return 20;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.rightTableView == tableView)
    {
        StoreDetailsTableViewHeaderView *view = [[StoreDetailsTableViewHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        DeptDetailsGoodsCategoryModel *model = self.categoryData[section];
        view.name.text = model.name;
        return view;
    }
    return nil;
}

// TableView分区标题即将展示
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向上，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((self.rightTableView == tableView)
        && !_isScrollDown
        && (self.rightTableView.dragging || self.rightTableView.decelerating))
    {
        [self selectRowAtIndexPath:section];
    }
}

// TableView分区标题展示结束
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // 当前的tableView是RightTableView，RightTableView滚动的方向向下，RightTableView是用户拖拽而产生滚动的（（主要判断RightTableView用户拖拽而滚动的，还是点击LeftTableView而滚动的）
    if ((self.rightTableView == tableView)
        && _isScrollDown
        && (self.rightTableView.dragging || self.rightTableView.decelerating))
    {
        [self selectRowAtIndexPath:section + 1];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (self.leftTableView == tableView)
    {
        _selectIndex = indexPath.row;
        [self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_selectIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self.leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]
                              atScrollPosition:UITableViewScrollPositionTop
                                      animated:YES];
    }else{
        //cell点击不变颜色
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

// 当拖动右边TableView的时候，处理左边TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]
                                animated:YES
                          scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - UISrcollViewDelegate
// 标记一下RightTableView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffsetY = 0;
    
    UITableView *tableView = (UITableView *) scrollView;
    if (self.rightTableView == tableView)
    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}
#pragma mark —— StoreDetailsRightTableViewCellDelegate
-(void)specificationButtonClick:(UIButton *)button{
    //弹出商品规格 view
    StoreGoodAttributesView *attributesView = [[StoreGoodAttributesView alloc] initWithFrame:(CGRect){0, 0, KScreenW, KScreenH}];
    //根据坐标找到对应的indexPath
    CGPoint buttonPosition = [button convertPoint:CGPointZero toView:self.rightTableView];
    NSIndexPath *indexPath = [self.rightTableView indexPathForRowAtPoint:buttonPosition];
    attributesView.model = self.categoryData[indexPath.section].deliveryGoodsVoList[indexPath.row];
    [attributesView showInView:kAppWindow];
    //数据会掉
    attributesView.goodsAttributesBlock = ^(NSDictionary * _Nonnull goodsInfo) {
        
        [self.goodaData addObject:goodsInfo];
        
        self.shoppingCarInfo(self.goodaData);
    };
    
}

#pragma mark - JXPagingViewListViewDelegate
- (UIView *)listView {
    return self;
}

- (UIScrollView *)listScrollView {
    return self.contenView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    
}

#pragma mark -加入购物车动画
-(void)joinCartAnimationWithRect:(CGRect)rect
{
    _endPoint_x = 35;
    _endPoint_y = KScreenH - 35;
    
    CGFloat startX = rect.origin.x;
    CGFloat startY = rect.origin.y;
    
    _path= [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(startX, startY)];
    
    //三点曲线
    [_path addCurveToPoint:CGPointMake(_endPoint_x, _endPoint_y)
             controlPoint1:CGPointMake(startX, startY)
             controlPoint2:CGPointMake(startX - 180, startY - 200)];
    _dotLayer = [CALayer layer];
    _dotLayer.backgroundColor = [UIColor purpleColor].CGColor;
    _dotLayer.frame = CGRectMake(0, 0, 20, 20);
    _dotLayer.cornerRadius = 5;
    [self.layer addSublayer:_dotLayer];
    [self groupAnimation];
}
#pragma mark - 组合动画
-(void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"alpha"];
    alphaAnimation.duration = 0.5f;
    alphaAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:0.1];
    alphaAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,alphaAnimation];
    groups.duration = 0.8f;
    groups.removedOnCompletion = NO;
    groups.fillMode = kCAFillModeForwards;
    groups.delegate = self;
    [groups setValue:@"groupsAnimation" forKey:@"animationName"];
    [_dotLayer addAnimation:groups forKey:nil];
    [self performSelector:@selector(removeFromLayer:) withObject:_dotLayer afterDelay:0.8f];
}
- (void)removeFromLayer:(CALayer *)layerAnimation{
    
    [layerAnimation removeFromSuperlayer];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    if ([[anim valueForKey:@"animationName"]isEqualToString:@"groupsAnimation"]) {
        
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        shakeAnimation.duration = 0.25f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:0.9];
        shakeAnimation.toValue = [NSNumber numberWithFloat:1];
        shakeAnimation.autoreverses = YES;
        self.animationBlock(shakeAnimation);
    }
}

@end
