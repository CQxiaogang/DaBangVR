//
//  define.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//

// 全局工具类宏定义

#ifndef define_h
#define define_h

//获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        [AppDelegate shareAppDelegate]
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)

//获取屏幕宽高
#define KScreenW [UIScreen mainScreen].bounds.size.width
#define KScreenH [UIScreen mainScreen].bounds.size.height
#define kScreen_Bounds [UIScreen mainScreen].bounds
#define kATTR_VIEW_HEIGHT KScreenH * 0.7

#define Iphone6ScaleWidth KScreenW/375.0
#define Iphone6ScaleHeight KScreenH/667.0
//根据ip6的屏幕来拉伸
#define kRealValue(with) ((with)*(KScreenW/375.0f))

//比例 以iPhone6 为基准
#define kRatio KScreenW/375

//按比例适配
#define kFit(num)                 kRatio * (num)

//强弱引用
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

//View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//property 属性快速声明 别用宏定义了，使用代码块+快捷键实现吧

// 当前系统版本
#define CurrentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]

//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

//颜色
#define KClearColor  [UIColor clearColor]
#define KWhiteColor  [UIColor whiteColor]
#define KBlackColor  [UIColor blackColor]
#define KGrayColor   [UIColor grayColor]
#define KGray2Color  [UIColor lightGrayColor]
#define KBlueColor   [UIColor blueColor]
#define KRedColor    [UIColor redColor]
#define KOrangeColor [UIColor orangeColor]
#define kYellowColor [UIColor yellowColor]
#define KGray3Color  [[UIColor alloc]initWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1]
//随机色生成
#define KRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
/**
 *  border颜色O
 */
#define KBorderColor [UIColor colorWithRed:(225)/255.0 green:(225)/255.0 blue:(225)/255.0 alpha:1.0]

// 字体颜色
#define KFontColor [[UIColor alloc]initWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1]

//字体
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]
#define AdaptiveFontSize(floatValue) [floatValue * KScreenW/375.0]

//定义UIImage对象
#define ImageWithFile(_pointer) [UIImage imageWithContentsOfFile:([[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%dx", _pointer, (int)[UIScreen mainScreen].nativeScale] ofType:@"png"])]
#define IMAGE_NAMED(name) [UIImage imageNamed:name]

//数据验证
#define StrValid(f) (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define SafeStr(f) (StrValid(f) ? f:@"")
#define HasString(str,key) ([str rangeOfString:key].location!=NSNotFound)

#define ValidStr(f) StrValid(f)
#define ValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]])
#define ValidArray(f) (f!=nil && [f isKindOfClass:[NSArray class]] && [f count]>0)
#define ValidNum(f) (f!=nil && [f isKindOfClass:[NSNumber class]])
#define ValidClass(f,cls) (f!=nil && [f isKindOfClass:[cls class]])
#define ValidData(f) (f!=nil && [f isKindOfClass:[NSData class]])

//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime  NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)
//打印当前方法名
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

//发送通知
#define KPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];

//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

// token
#define kToken curUser.token? curUser.token : @"0"
// 快速解析数据
#define KJSONSerialization(responseObject) ([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil])
// 边距
#define KMargin kFit(10)
// 默认图片
#define kDefaultImg [UIImage imageNamed:@"ad3"]
// 订单状态
#define kOrderState_forThePayment    @"待付款"
#define kOrderState_ToSendTheGoods   @"待发货"
#define kOrderState_forTheGoods      @"待收货"
#define kOrderState_ConfirmTheGoods  @"确认收货"
#define kOrderState_ToEvaluate       @"待评价"
#define kOrderState_refundOrAfterSales @"退款/售后"
// 搜索框的宽高
#define kSearchBoxW kFit(260)
#define kSearchBoxH kFit(30)

// 微信支付状态
#define kOrderSnTotal @"orderTotalSn"
#define kOrderSn      @"orderSn"

// 商品提交类型
#define kGroup1  @"group1"  //单独成团
#define kGroup2  @"group2"  //发起拼团
#define kGroup3  @"group3"  //参与拼团
#define kSeconds @"seconds" //秒杀
#define kBuy @"buy"   //直接购买
#define kCart @"cart" //从购物车购买
// 我的订单类别购买类型参数
#define kBuyTypeSeconds @"6" //秒杀
#define kBuyTypeGroup   @"3" //拼团购买

//商品详情UI文字
#define kShoppingCar    @"购物车"
#define kNowBuy         @"立即购买"
#define kNowSecondsBuy  @"立即秒杀"
#define kSpellGroup     @"拼团"
#define kSpellGroup1    @"去拼单"

#define kObserverKey    @"kObserverKey"

#endif /* define_h */
