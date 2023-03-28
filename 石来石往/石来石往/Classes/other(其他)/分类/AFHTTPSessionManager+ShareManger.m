//
//  AFHTTPSessionManager+ShareManger.m
//  大岸金融
//
//  Created by 徐龙 on 2017/3/1.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AFHTTPSessionManager+ShareManger.h"

@implementation AFHTTPSessionManager (ShareManger)

static AFHTTPSessionManager *manager;
+ (AFHTTPSessionManager *)sharedHTTPSession{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", nil];
        manager.requestSerializer.timeoutInterval = 30.0f;
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        securityPolicy.validatesDomainName = NO;
        securityPolicy.allowInvalidCertificates = YES;
        manager.securityPolicy = securityPolicy;
        
    });
    return manager;
}
@end
