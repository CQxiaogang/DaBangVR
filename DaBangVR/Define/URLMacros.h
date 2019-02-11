//
//  URLMacros.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//



#ifndef URLMacros_h
#define URLMacros_h


//内部版本号 每次发版递增
#define KVersionCode 1
/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

#define DevelopSever    1
#define TestSever       0
#define ProductSever    0

#if DevelopSever

/**开发服务器*/
#define URL_main @"http://www.vrzbgw.com/dabang"
#define URL_main_test @"http://192.168.1.110:8080"

#elif TestSever

/**测试服务器*/
#define URL_main @""

#elif ProductSever

/**生产服务器*/
#define URL_main @""
#endif

#pragma mark ——————   首页相关   ——————
// 渠道列表

#define URL_getChannelMenuList NSStringFormat(@"%@%@",URL_main,@"/api/index/getChannelMenuList?")
// 商品类型列表
#define URL_getGoodsCategoryList NSStringFormat(@"%@%@",URL_main,@"/api/index/getGoodsCategoryList?")
//轮播图列表
#define URl_goods_rotation_list NSStringFormat(@"%@%@",URL_main,@"/api/index/getGoodsRotationList?parentId=1")

#pragma mark ——————   商品相关   ——————
// 普通商品列表
#define URL_getGoodsList NSStringFormat(@"%@%@",URL_main,@"/api/goods/getGoodsList?")
// 团购商品列表
#define URL_getGroupGoodsList NSStringFormat(@"%@%@",URL_main,@"/api/goods/getGroupGoodsList?")
// 新品首发列表
#define URL_getNewGoodsList NSStringFormat(@"%@%@",URL_main,@"/api/goods/getNewGoodsList?")

// 商品详情
#define URL_getGoodsDetails NSStringFormat(@"%@%@",URL_main,@"/api/goods/getGoodsDetails?")
// 添加商品评论
#define URL_comment_save @""
// 商品评论列表
#define URl_comment_list_two NSStringFormat(@"%@%@",URL_main,@"/api/goods/getCommentListTwo?")
// 商品评论列表，最近三条
#define URl_comment_list NSStringFormat(@"%@%@",URL_main,@"/api/goods/getCommentList?")
// 购物车列表
#define URl_getGoods2CartList NSStringFormat(@"%@%@",URL_main,@"/api/goods/getGoods2CartList?page=1&limit=10")

#pragma mark ——————  登陆授权接口  ——————
// 登录
#define URl_login NSStringFormat(@"%@%@",URL_main,@"/api/auth/login?")

#pragma mark ——————   个人中心    ——————
// 添加收货地址
#define URl_addressAdd NSStringFormat(@"%@%@",URL_main,@"/api/my/addressAdd?")
// 查询收货地址
#define URl_addressList NSStringFormat(@"%@%@",URL_main,@"/api/my/addressList")
// 查询一条地址
#define URl_addressListone NSStringFormat(@"%@%@",URL_main,@"/api/my/addressListone?")
// 删除收货地址
#define URl_addressDelete NSStringFormat(@"%@%@",URL_main,@"/api/my/addressDelete")
// 查询地址下级列表
#define URl_getRegionChildrenList NSStringFormat(@"%@%@",URL_main,@"/api/my/getRegionChildrenList?")

#pragma mark —————— 购买商品接口类 ——————
// 添加到购物车
#define URl_addToCar NSStringFormat(@"%@%@",URL_main,@"/api/buygoods/addToCart?")
// 立即购买 - 确认订单
#define URl_confirmGoods2Buy  NSStringFormat(@"%@%@",URL_main,@"/api/buygoods/confirmGoods2Buy?")
// 购物车 - 确认订单
#define URl_confirmGoods2Cart NSStringFormat(@"%@%@",URL_main,@"/api/buygoods/confirmGoods2Cart?")
// 确认订单页面数据 - 统一入口
#define URl_getConfirmGoods NSStringFormat(@"%@%@",URL_main,@"/api/buygoods/getConfirmGoods")
// 提交订单 - 统一入口
#define URl_submitOrder NSStringFormat(@"%@%@",URL_main,@"/api/buygoods/submitOrder?")
// 修改购物车中商品的数量
#define URl_updateNumber2Cart NSStringFormat(@"%@%@",URL_main,@"/api/buygoods/updateNumber2Cart?")
// 我的订单 - 列表统一入口
#define URl_getOrderList NSStringFormat(@"%@%@",URL_main,@"/api/order/getOrderList?")
#endif /* URLMacros_h */
