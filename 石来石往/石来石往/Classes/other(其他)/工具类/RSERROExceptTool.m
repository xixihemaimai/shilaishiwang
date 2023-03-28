//
//  RSERROExceptTool.m
//  石来石往
//
//  Created by mac on 2018/1/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSERROExceptTool.h"

@implementation RSERROExceptTool




+ (void)showErrorExceptErrorStr:(NSString *)errorStr{
    
    //这边是显示错误的信息出来
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid],@"Data":@"",@"VerifyKey":@"",@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    
    XLAFNetworkingBlock * netWork = [[XLAFNetworkingBlock alloc]init];
    [netWork getDataWithUrlString:URL_ERRORNEWTORK_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        
        
        if (success) {
            
            
            
            
        }else{
            
            
        }
        
        
        
    }];
}



@end
