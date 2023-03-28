//
//  RSInitUserInfoTool.h
//  石来石往
//
//  Created by rsxx on 2018/2/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^Obtain)(BOOL isValue);
@interface RSInitUserInfoTool : NSObject

+ (void)registermodelUSER_CODE:(NSString *)USER_CODE andVERIFYKEY:(NSString *)VERIFYKEY andViewController:(UIViewController *)weakSelf andObtain:(Obtain)obtain;




@end
