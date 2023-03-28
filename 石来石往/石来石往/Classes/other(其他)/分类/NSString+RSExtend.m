//
//  NSString+RSExtend.m
//  石来石往
//
//  Created by mac on 17/5/31.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "NSString+RSExtend.h"

@implementation NSString (RSExtend)

+ (NSString *)get_uuid
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    
    return uuid;
}

+ (NSString *)get_verifyCode
{
    //格林威治时间到当前时间的毫秒数
    NSTimeInterval time=[[NSDate date] timeIntervalSince1970] * 1000;
    long long localTime = time;//NSTimeInterval返回的是double类型
//    CLog(@"=============================================%lld",[[[NSUserDefaults standardUserDefaults] objectForKey:@"kTimeIntervalForPhoneAndServer"] longLongValue]);
    
    long long sections = [[[NSUserDefaults standardUserDefaults] objectForKey:@"kTimeIntervalForPhoneAndServer"] longLongValue];
    NSString *verifyCode = [NSString stringWithFormat:@"%lld",localTime + sections];
//    CLog(@"-----------------------------%@",verifyCode);
    if (verifyCode.length < 4) {
//        CLog(@"+#@+++++++++++++++++!1111111111");
        verifyCode = [self CharacterStringMainString:verifyCode AddDigit:5 AddString:@"0"];
    }
    //去除后面4位
    verifyCode = [verifyCode substringWithRange:NSMakeRange(0, verifyCode.length - 4)];
    //MD5加密
    verifyCode = [NSString stringWithFormat:@"%@",[Utility md5:verifyCode]];
    //第34位与78位对调
    verifyCode = [NSString StringReverse:verifyCode from:3 to:7];
    return verifyCode;
}

+ (NSString *)StringReverse:(NSString *)str from:(int)from to:(int)to
{
    NSString *str1 = [str substringWithRange:NSMakeRange(0, from - 1)];  //前两位
    NSString *strFrom = [str substringWithRange:NSMakeRange(from - 1, 2)];  //第三、四位
    NSString *str2 = [str substringWithRange:NSMakeRange(from + 1, to - from - 2)];  //第5、6位
    NSString *strTo = [str substringWithRange:NSMakeRange(to - 1, 2)];  //第七、八位
    NSString *str3 = [str substringWithRange:NSMakeRange(to + 1, str.length - to - 1)];  //后面几位
    NSString *reverseString = [NSString stringWithFormat:@"%@%@%@%@%@",str1,strTo,str2,strFrom,str3];
    return  reverseString;
}

+ (NSString *)CharacterStringMainString:(NSString*)MainString AddDigit:(int)AddDigit AddString:(NSString*)AddString
{
  NSString * ret = [[NSString alloc]init];
  ret = MainString;
  for(int y =0;y < (AddDigit - MainString.length) ;y++ ){
    ret = [NSString stringWithFormat:@"%@%@",ret,AddString];
  }
    return ret;
}


@end
