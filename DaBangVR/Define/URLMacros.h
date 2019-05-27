//
//  URLMacros.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//

/**开发服务器*/
#define URL_main @"http://www.vrzbgw.com/dabang"
//#define URL_main @"http://192.168.1.115:8080" // 强
//#define URL_main @"http://192.168.1.168:8080" // 邓
//#define URL_main @"http://192.168.1.109:8080" // 豪

#pragma mark ——————   首页相关   ——————
// 渠道列表
#define URL_getChannelMenuList NSStringFormat(@"%@%@",URL_main,@"/api/index/getChannelMenuList?")
// 商品类型列表
#define URL_getGoodsCategoryList NSStringFormat(@"%@%@",URL_main,@"/api/index/getGoodsCategoryList?")
// 轮播图列表
#define URl_getGoodsRotationList NSStringFormat(@"%@%@",URL_main,@"/api/index/getGoodsRotationList?")
// 搜索接口
#define URl_getSearchGoodsList NSStringFormat(@"%@%@",URL_main,@"/api/index/getSearchGoodsList?")

#pragma mark ——————   商品相关   ——————
// 普通商品列表
#define URL_getGoodsList NSStringFormat(@"%@%@",URL_main,@"/api/goods/getGoodsList?")
// 团购商品列表
#define URL_getGroupGoodsList NSStringFormat(@"%@%@",URL_main,@"/api/goods/getGroupGoodsList?")
// 新品首发列表
#define URL_newGoodsList NSStringFormat(@"%@%@",URL_main,@"/api/goods/newGoodsList?")
// 商品详情
#define URL_getGoodsDetails NSStringFormat(@"%@%@",URL_main,@"/api/goods/getGoodsDetails?")
// 添加商品评论
#define URL_comment_save @""
// 商品评论列表
#define URl_getCommentListTwo NSStringFormat(@"%@%@",URL_main,@"/api/goods/getCommentListTwo?")
// 购物车列表
#define URl_getGoods2CartList NSStringFormat(@"%@%@",URL_main,@"/api/goods/getGoods2CartList?page=1&limit=10")
// 全球购商品列表
#define URl_getGlobalList NSStringFormat(@"%@%@",URL_main,@"/api/goods/getGlobalList?")
// 根据国家列表，查询商品
#define URl_getGlobalLists NSStringFormat(@"%@%@",URL_main,@"/api/goods/getGlobalLists?")
// 秒杀商品列表
#define URl_getSecondsKillGoodsList NSStringFormat(@"%@%@",URL_main,@"/api/goods/getSecondsKillGoodsList?")
// 添加商品评论
#define URl_getCommentSave NSStringFormat(@"%@%@",URL_main,@"/api/goods/getCommentSave?")
// 全部商品列表
#define URl_getGoodsLists NSStringFormat(@"%@%@",URL_main,@"/api/goods/getGoodsLists?")

#pragma mark ——————  登陆授权接口  ——————
// 登录
#define URl_login NSStringFormat(@"%@%@",URL_main,@"/api/auth/login?")
// 用户修改信息
#define URl_update NSStringFormat(@"%@%@",URL_main,@"/api/auth/update?")
// 获取用户信息接口
#define URl_getUserInfo NSStringFormat(@"%@%@",URL_main,@"/api/auth/getUserInfo")

#pragma mark ——————  订单接口类  ——————
// 订单详情
#define URl_getOrderDetails NSStringFormat(@"%@%@",URL_main,@"/api/order/getOrderDetails?")
// 我的订单 - 列表统一入口
#define URl_getOrderList NSStringFormat(@"%@%@",URL_main,@"/api/order/getOrderList?")
// 物流查询接口
#define URl_getOrderLogisticsDetails NSStringFormat(@"%@%@",URL_main,@"/api/order/getOrderLogisticsDetails?")

#pragma mark ——————   个人中心    ——————
// 添加收货地址
#define URl_addressAdd NSStringFormat(@"%@%@",URL_main,@"/api/my/addressAdd?")
// 查询收货地址
#define URl_addressList NSStringFormat(@"%@%@",URL_main,@"/api/my/addressList")
// 查询一条地址
#define URl_addressListone NSStringFormat(@"%@%@",URL_main,@"/api/my/addressListone?")
// 删除收货地址
#define URl_addressDelete NSStringFormat(@"%@%@",URL_main,@"/api/my/addressDelete")
// 修改收货地址
#define URl_addressUpdate NSStringFormat(@"%@%@",URL_main,@"/api/my/addressUpdate?")
// 查询地址下级列表
#define URl_getRegionChildrenList NSStringFormat(@"%@%@",URL_main,@"/api/my/getRegionChildrenList?")
// 添加商品收藏
#define URl_getGoodsCollectSave NSStringFormat(@"%@%@",URL_main,@"/api/my/getGoodsCollectSave?")
// 商品收藏列表
#define URl_getGoodsCollectList NSStringFormat(@"%@%@",URL_main,@"/api/my/getGoodsCollectList")

#pragma mark —————— 购买商品接口类 ——————
// 加入购物车
#define URl_addToCar NSStringFormat(@"%@%@",URL_main,@"/api/buygoods/addToCart?")
// 立即购买 - 确认订单
#define URl_confirmGoods2Buy  NSStringFormat(@"%@%@",URL_main,@"/api/buygoods/confirmGoods2Buy?")
// 购物车 - 确认订单
#define URl_confirmGoods2Cart  NSStringFormat(@"%@%@",URL_main,@"/api/buygoods/confirmGoods2Cart?")
// 单独购买、发起拼团、参加拼团 - 确认订单
#define URl_confirmGoods2groupbuy NSStringFormat(@"%@%@",URL_main,@"/api/buygoods/confirmGoods2groupbuy?")
// 秒杀商品 - 确认订单
#define URl_confirmGoods2seconds NSStringFormat(@"%@%@",URL_main,@"/api/buygoods/confirmGoods2seconds?")
// 确认订单页面数据 - 统一入口
#define URl_getConfirmGoods NSStringFormat(@"%@%@",URL_main,@"/api/buygoods/getConfirmGoods")
// 获取“发起拼团”的用户列表
#define URl_getInitiateGroupUserList NSStringFormat(@"%@%@",URL_main,@"/api/buygoods/getInitiateGroupUserList?")
// 提交订单 - 统一入口
#define URl_submitOrder NSStringFormat(@"%@%@",URL_main,@"/api/buygoods/submitOrder?")
// 修改购物车中商品的数量
#define URl_updateNumber2Cart NSStringFormat(@"%@%@",URL_main,@"/api/buygoods/updateNumber2Cart?")

#pragma mark —————— 微信支付接口类 ——————
//微信支付统一入口
#define URl_prepayOrder NSStringFormat(@"%@%@",URL_main,@"/api/payorder/prepayOrder?")
//微信支付回调接口（APP主动调用)
#define URl_notifyApp NSStringFormat(@"%@%@",URL_main,@"/api/payorder/notifyApp?")
//取消订单及退款申请接口
#define URl_refundRequest NSStringFormat(@"%@%@",URL_main,@"/api/payorder/refundRequest?")
//订单列表重新支付订单
#define URl_prepayOrderAgain NSStringFormat(@"%@%@",URL_main,@"/api/payorder/prepayOrderAgain?")


#pragma mark —————— 直播管理接口 ——————
//创建推流
#define URl_create NSStringFormat(@"%@%@",URL_main,@"/api/pili/create?")
//获取所有正在直播的流列表
#define URl_getLiveStreamsList NSStringFormat(@"%@%@",URL_main,@"/api/pili/getLiveStreamsList")
//获取可直播的商品列表
#define URl_getLiveGoodgsList NSStringFormat(@"%@%@",URL_main,@"/api/pili/getLiveGoodgsList")
//获取当前主播所关联的商品列表
#define URl_getAnchorLiveGoodsList NSStringFormat(@"%@%@",URL_main,@"/api/pili/getAnchorLiveGoodsList?")

#pragma mark —————— 商家接口类 ——————
//申请成为主播
#define URl_appAnchor NSStringFormat(@"%@%@",URL_main,@"/api/config/uploadFiles")

#pragma mark —————— 配置文件接口类 ——————
//获取七牛云token
#define URl_getUploadConfigToken NSStringFormat(@"%@%@",URL_main,@"/api/config/getUploadConfigToken")
//获取某个直播在线人数
#define URl_getLookCountStreamList NSStringFormat(@"%@%@",URL_main,@"/api/pili/getLookCountStreamList?")

#pragma mark —————— 外   卖 ——————
//附近门店列表
#define URl_getNearbyDeptList NSStringFormat(@"%@%@",URL_main,@"/api/delivery/getNearbyDeptList?")
