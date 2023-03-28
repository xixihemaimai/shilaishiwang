//
//  RSLoginValidity.m
//  石来石往
//
//  Created by mac on 2017/8/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSLoginValidity.h"

#import "NSString+RSErrerResutl.h"



@interface RSLoginValidity ()


@end


@implementation RSLoginValidity


+ (void)LoginValiditWithVerifyKey:(NSString *)verifyKey  andViewController:(UIViewController *)Vc{
    /*
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    */
    if (verifyKey.length > 0) {
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key":[NSString get_uuid],@"Data":@"",@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
        __weak typeof(Vc) weakSelf = Vc;
        XLAFNetworkingBlock * netWork = [[XLAFNetworkingBlock alloc]init];
        [netWork getDataWithUrlString:URL_LOGIN_VALIDITY withParameters:parameters withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL Result = [json[@"Result"] boolValue];
                if (Result) {
                }else{
                    //请求之后，判断他的合法性
                    NSString * str = json[@"MSG_CODE"];
                    NSString  * errerStr = [[NSString alloc]init];
                    [errerStr stringErrerResult:str andViewController:weakSelf];
                }
            }else{
                //网络请求都不行
                //请求之后，判断他的合法性
                //            NSString * str = json[@"MSG_CODE"];
                //            NSString  * errerStr = [[NSString alloc]init];
                //            [errerStr stringErrerResult:str andViewController:weakSelf];
                [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
            }
        }];
    }else{
        [Vc.navigationController popViewControllerAnimated:NO];
    }
}

+ (void)LoginValiditWithModelVerifyKey:(NSString *)verifyKey  andViewController:(UIViewController *)Vc{
    /*
     NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
     NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
     */
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":@"",@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    __weak typeof(Vc) weakSelf = Vc;
    XLAFNetworkingBlock * netWork = [[XLAFNetworkingBlock alloc]init];
    [netWork getDataWithUrlString:URL_HEADER_LOGIN_VALIDITY_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = [json[@"Result"] boolValue];
            if (Result) {
            }else{
                //请求之后，判断他的合法性
                NSString * str = json[@"MSG_CODE"];
                NSString  * errerStr = [[NSString alloc]init];
               // [errerStr stringErrerResult:str andViewController:weakSelf];
                [errerStr stringModelErrerResult:str andViewController:weakSelf];
            }
        }else{
            //网络请求都不行
            [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        }
    }];
}



@end
