//
//  WXApiManager.h
//  iOS_Content
//
//  Created by mac on 2021/6/22.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
NS_ASSUME_NONNULL_BEGIN

@protocol WXApiManagerDelegate <NSObject>
@required

@optional
-(void)wxPayResponse:(PayResp *)resp;
-(void)wxSendAuthResponse:(SendAuthResp *)resp;


@end

@interface WXApiManager : NSObject<WXApiDelegate>
@property(nonatomic, weak) id <WXApiManagerDelegate> delegate;
+ (instancetype)sharedManager;


//FIXME:获取微信token和openid
- (void)getAccessTokenWithCode:(NSString *)code andSuccess:(void(^)(NSString * token,NSString * openId,NSString * unionid))completeBlock;

//FIXME:微信返回的资料
- (void)getUserInfoWithAccessToken:(NSString *)accessToken andOpenId:(NSString *)openId andSuccess:(void(^)(NSString * nickname,NSString * openid,NSString * headimgurl,NSString * unionid,NSString * sex,NSString * language,NSString * city,NSString * country,NSString * province,NSArray * privilege))completeBlock;


//FIXME:微信支付
//- (void)wXPayHandOpenWithPayModel:(QWZWeChatQiWuCoinPayModel *)weChatQiWuCoinPayModel andSuccess:(void(^)(void))completeBlock;

@end

NS_ASSUME_NONNULL_END
