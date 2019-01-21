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
#define URL_main @"http://www.vrzbgw.com"

#elif TestSever

/**测试服务器*/
#define URL_main @""

#elif ProductSever

/**生产服务器*/
#define URL_main @""
#endif

#pragma mark —— 首页相关
// 渠道列表
#define URL_channel_menu_list NSStringFormat(@"%@%@",URL_main,@"/dabang/api/index/getChannelMenuList?mallSpeciesId=1")
// 商品类型列表
#define URL_goods_title NSStringFormat(@"%@%@",URL_main,@"/dabang/api/index/getGoodsCategoryList?parentId=1036096")
//轮播图列表
#define URl_goods_rotation_list NSStringFormat(@"%@%@",URL_main,@"/dabang/api/index/getGoodsRotationList?mallSpeciesId=1")

#pragma mark —— 商品相关
// 商品列表
#define URL_goods_list NSStringFormat(@"%@%@",URL_main,@"/dabang/api/goods/getGoodsList?")
// 商品详情
#define URL_goods_details NSStringFormat(@"%@%@",URL_main,@"/dabang/api/goods/getGoodsDetails?")
// 添加商品评论
#define URL_comment_save @""
// 商品评论列表
#define URl_comment_list_two NSStringFormat(@"%@%@",URL_main,@"/dabang/api/goods/getCommentListTwo?")
// 商品评论列表，最近三条
#define URl_comment_list NSStringFormat(@"%@%@",URL_main,@"/dabang/api/goods/getCommentList?")

#pragma mark —— 登陆授权接口
// 登录
#define URl_login @"http://192.168.1.103:8080/api/auth/login?"

#pragma mark —— 个人中心

#endif /* URLMacros_h */
