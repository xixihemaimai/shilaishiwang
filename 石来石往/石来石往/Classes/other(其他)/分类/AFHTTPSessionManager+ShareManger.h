//
//  AFHTTPSessionManager+ShareManger.h
//  大岸金融
//
//  Created by 徐龙 on 2017/3/1.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AFNetworking.h"

@interface AFHTTPSessionManager (ShareManger)

+ (AFHTTPSessionManager *)sharedHTTPSession;

@end
