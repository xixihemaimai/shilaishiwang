//
//  WXApiManager.m
//  iOS_Content
//
//  Created by mac on 2021/6/22.
//

#import "WXApiManager.h"

@implementation WXApiManager


+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}

////FIXME:微信支付
//- (void)wXPayHandOpenWithPayModel:(QWZWeChatQiWuCoinPayModel *)weChatQiWuCoinPayModel andSuccess:(void(^)(void))completeBlock{
//    PayReq *request = [[PayReq alloc] init];
//    request.partnerId = weChatQiWuCoinPayModel.partnerid;
//    request.prepayId = weChatQiWuCoinPayModel.prepayid;
//    request.package = weChatQiWuCoinPayModel.package;
//    request.nonceStr = weChatQiWuCoinPayModel.noncestr;
//    request.timeStamp = [weChatQiWuCoinPayModel.timestamp intValue];
//    request.sign = weChatQiWuCoinPayModel.sign;
//    [WXApi sendReq:request completion:^(BOOL success) {
//        if (completeBlock) {
//            completeBlock();
//        }
//    }];
//}




#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp
{
    if([resp isKindOfClass:[PayResp class]]){
        PayResp *payResp = (PayResp *)resp;
        [self.delegate wxPayResponse:payResp];
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg;
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
//                NSLog(@"=================成功========================");
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
//                NSLog(@"=================失败========================");
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
    
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *sendAuthResp = (SendAuthResp *)resp;
        [self.delegate wxSendAuthResponse:sendAuthResp];
    }
}




//FIXME:获取微信token和openid
- (void)getAccessTokenWithCode:(NSString *)code andSuccess:(nonnull void (^)(NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull))completeBlock{
    NSString *urlString =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",WXAPPID,WXSERECT,code];
    NSURL *url = [NSURL URLWithString:urlString];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *dataStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                NSLog(@"+++++++#@+++++++++++++++++++++%@",dict);
                if ([dict objectForKey:@"errcode"]) {
//                    NSLog(@"+++++++#@+++++++++++++++++++++%@",dict);
                }else {
//                    [NSUserDefaults setObject:[dict objectForKey:@"openid"] forKey:KUD_OpenID];
//                    [NSUserDefaults synchronize];
//                    NSLog(@"==微信openid======%@=====",[dict objectForKey:@"openid"]);
                  //  [self loginData:[dict objectForKey:@"openid"]];
                    if (completeBlock) {
                        completeBlock([dict objectForKey:@"access_token"],[dict objectForKey:@"openid"],[dict objectForKey:@"unionid"]);
                    }
                }
            }
        });
    });
}

//FIXME:微信返回的资料利用上面方法token和openId
- (void)getUserInfoWithAccessToken:(NSString *)accessToken andOpenId:(NSString *)openId andSuccess:(void(^)(NSString * nickname,NSString * openid,NSString * headimgurl,NSString * unionid,NSString * sex,NSString * language,NSString * city,NSString * country,NSString * province,NSArray * privilege))completeBlock
{
    
    NSString *urlString =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",accessToken,openId];
//    NSLog(@"%@=======",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *dataStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data)
                {
                 NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                 if ([dict objectForKey:@"errcode"])               {
 //AccessToken失效
                 }else
                 {
                     
                              
                     NSString * nickname = [dict objectForKey:@"nickname"];
                     NSString * openid = [dict objectForKey:@"openid"];
                     NSString * headimgurl = [dict objectForKey:@"headimgurl"];
                     NSString * unionid = [dict objectForKey:@"unionid"];
                     NSString * sex = [dict objectForKey:@"sex"];
                     
                     NSString * language = [dict objectForKey:@"language"];
                     NSString *  city = [dict objectForKey:@"city"];
                     NSString *  country = [dict objectForKey:@"country"];
                     NSString *  province = [dict objectForKey:@"province"];
                     NSArray * privilege = [dict objectForKey:@"privilege"];
//                     NSLog(@"------------------------------------------------%@",dict);
                     if (completeBlock) {
                         completeBlock(nickname,openid,headimgurl,unionid,sex,language,city,country,province,privilege);
                     }
                     //NSLog(@"%@===",dict);
                    /* NSDictionary *para = @{
                                            @"openid":[dict objectForKey:@"openid"]
                                            };*/ //这里就是拿你要的参数走自己登录了
                    // [self _loadData:para];
                 }
             }
         });
     });
    /*
          29      city = ****;
          30      country = CN;
          31      headimgurl = "http://wx.qlogo.cn/mmopen/q9UTH59ty0K1PRvIQkyydYMia4xN3gib2m2FGh0tiaMZrPS9t4yPJFKedOt5gDFUvM6GusdNGWOJVEqGcSsZjdQGKYm9gr60hibd/0";
          32      language = "zh_CN";
          33      nickname = “****";
          34      openid = oo*********;
          35      privilege =     (
          36      );
          37      province = *****;
          38      sex = 1;
          39      unionid = “o7VbZjg***JrExs";
          40      */
/*
            43      错误代码
            44      errcode = 42001;
            45      errmsg = "access_token expired";
            46      */
}





@end
