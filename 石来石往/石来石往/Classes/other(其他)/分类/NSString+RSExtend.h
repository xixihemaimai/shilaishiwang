//
//  NSString+RSExtend.h
//  石来石往
//
//  Created by mac on 17/5/31.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Utility.h"
@interface NSString (RSExtend)
+ (NSString
   *)get_verifyCode;

/*
 *	从字符串转换成long型的ip
 *
 *	@return	long型的ip
 */
+ (NSString *)StringReverse:(NSString *)str from:(int)from to:(int)to;


+ (NSString *)get_uuid;

@end
