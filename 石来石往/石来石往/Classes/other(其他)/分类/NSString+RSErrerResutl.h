//
//  NSString+RSErrerResutl.h
//  石来石往
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RSErrerResutl)


#pragma mark -- push的方式跳转
-(void)stringErrerResult:(NSString *)Message  andViewController:(UIViewController *)viewVc;


#pragma mark -- model的方式
- (void)stringModelErrerResult:(NSString *)message andViewController:(UIViewController *)viewVc;

@end
