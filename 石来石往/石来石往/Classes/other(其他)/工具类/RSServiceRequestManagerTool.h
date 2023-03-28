//
//  RSServiceRequestManagerTool.h
//  石来石往
//
//  Created by mac on 2021/9/2.
//  Copyright © 2021 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSServiceRequestManagerTool : NSObject


//TODO:这边主要是所有网络请求的方法管理工具




//获取店铺的数据
- (void)reloadShopWithParameters:(NSMutableDictionary *)dict andSuccess:(void(^)(id json,BOOL success))Success andFailure:(void(^)(NSError * error,BOOL failure))Failure;


@end

NS_ASSUME_NONNULL_END
