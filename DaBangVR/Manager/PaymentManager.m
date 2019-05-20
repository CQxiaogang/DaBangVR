//
//  PaymentManager.m
//  DaBangVR
//
//  Created by mac on 2019/3/8.
//  Copyright © 2019 DaBangVR. All rights reserved.
//

#import "PaymentManager.h"

@implementation PaymentManager
// 单例
SINGLETON_FOR_CLASS(PaymentManager)

- (void)weiXinPayWithOrderSn:(NSString *)orderSn andPayOrderSnType:(NSString *)payOrderSnType{
    
    NSDictionary *dic = @{@"orderSn"       :orderSn,
                          @"payOrderSnType":payOrderSnType
                          };
    [NetWorkHelper POST:URl_prepayOrder parameters:dic success:^(id  _Nonnull responseObject) {
        
        NSDictionary * dic = KJSONSerialization(responseObject)[@"data"];
        //配置调起微信支付所需要的参数
        PayReq *req   = [[PayReq alloc] init];
        req.openID    = [dic objectForKey:@"appid"];
        req.partnerId = [dic objectForKey:@"partnerid"];
        req.prepayId  = [dic objectForKey:@"prepayid"];
        req.package   = [dic objectForKey:@"package"];
        req.nonceStr  = [dic objectForKey:@"noncestr"];
        req.timeStamp = [dic[@"timestamp"] intValue];
        req.sign      = [dic objectForKey:@"sign"];
        //调起微信支付
        [WXApi sendReq:req];
        
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
//重新支付
-(void)weiXinPayWithOrderID:(NSString *)orderID{
    [NetWorkHelper POST:URl_prepayOrderAgain parameters:@{@"orderId":orderID} success:^(id  _Nonnull responseObject) {
        NSDictionary * dic = KJSONSerialization(responseObject)[@"data"];
        //配置调起微信支付所需要的参数
        PayReq *req   = [[PayReq alloc] init];
        req.openID    = [dic objectForKey:@"appid"];
        req.partnerId = [dic objectForKey:@"partnerid"];
        req.prepayId  = [dic objectForKey:@"prepayid"];
        req.package   = [dic objectForKey:@"package"];
        req.nonceStr  = [dic objectForKey:@"noncestr"];
        req.timeStamp = [dic[@"timestamp"] intValue];
        req.sign      = [dic objectForKey:@"sign"];
        //调起微信支付
        [WXApi sendReq:req];
    } failure:nil];
}

// 微信支付返回结果回调
-(void)onResp:(BaseResp*)resp{
    NSString *strMsg = [NSString stringWithFormat:@"%d",resp.errCode];
    NSString *strTitle;
    NSString *strNote;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"successPay" object:strMsg];
    if ([resp isKindOfClass:[PayResp class]]) {
        // 支付返回结果,实际支付结果需要去微信服务器端查询
        strTitle = @"支付结果";
    }
    switch (resp.errCode) {
        case WXSuccess:{
            strMsg = @"支付成功";
            strNote = @"success";
            break;
        }
        case WXErrCodeUserCancel:{
            strMsg = @"支付已取消";
            strNote = @"cancel";
            break;
        }
        case WXErrCodeSentFail: {
            strMsg = @"支付失败,请重新支付";
            strNote = @"fail";
            break;
        }
        default:{
            strMsg = @"支付失败";
            strNote = @"fail";
            break;
        }
    }
}

@end
