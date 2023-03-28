//
//  RSTimeTool.h
//  石来石往
//
//  Created by mac on 2017/8/25.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSTimeTool : NSObject


/**获取当前的时间戳*/
-(NSString*)getCurrentTimestamp;



/**
 *
 * 从时间戳里面获取时间
 * parmas timeStr 时间戳
 */
- (NSString *)timeStampGetCurrent:(NSString *)timeStr;


/**
 *  仿QQ空间时间显示
 *  @param string eg:2015年5月24日 02时21分30秒
 */
- (NSString *)format:(NSString *)string;


/**时间的对比*/
- (NSString *)compareDate:(NSDate *)date;

@end
