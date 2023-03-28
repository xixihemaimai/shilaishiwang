//
//  RSNSStringColorTool.m
//  石来石往
//
//  Created by mac on 2017/12/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSNSStringColorTool.h"

@implementation RSNSStringColorTool
+ (NSMutableAttributedString *)compareSearchAndModelStr:(NSString *)search andModelStr:(NSString *)modelStr{
    // 设置标签文字
    NSMutableAttributedString *attrituteString = [[NSMutableAttributedString alloc] initWithString:modelStr];
    if (search.length > 1) {
        //之后执行一次的
        // 获取标红的位置和长度
         NSRange range = [modelStr rangeOfString:search];
        // 设置标签文字的属性
            [attrituteString setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexColorStr:@"#3385FF"],   NSFontAttributeName : [UIFont systemFontOfSize:12]} range:range];
    }else{
        //执行多次的时候
        NSString *temp = nil;
        for(int i =0; i < [modelStr length]; i++)
        {
            temp = [modelStr substringWithRange:NSMakeRange(i, 1)];
            if ([temp isEqualToString:search])
            {
                NSRange range = NSMakeRange(i, temp.length);
                [attrituteString setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexColorStr:@"#3385FF"],   NSFontAttributeName : [UIFont systemFontOfSize:12]} range:range];
            }
        }
     }
    return attrituteString;
}

/**
 *  返回重复字符的location
 *
 *  @param text     初始化的字符串
 *  @param findText 查找的字符
 *
 *  @return 返回重复字符的location
 */
//+ (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText
//{
//    NSMutableArray *arrayRanges = [NSMutableArray arrayWithCapacity:20];
//    if (findText == nil && [findText isEqualToString:@""]) {
//        return nil;
//    }
//    NSRange rang = [text rangeOfString:findText];
//    if (rang.location != NSNotFound && rang.length != 0) {
//        [arrayRanges addObject:[NSNumber numberWithInteger:rang.location]];
//        NSRange rang1 = {0,0};
//        NSInteger location = 0;
//        NSInteger length = 0;
//        for (int i = 0;; i++)
//        {
//            if (0 == i) {
//                location = rang.location + rang.length;
//                length = text.length - rang.location - rang.length;
//                rang1 = NSMakeRange(location, length);
//            }else
//            {
//                location = rang1.location + rang1.length;
//                length = text.length - rang1.location - rang1.length;
//                rang1 = NSMakeRange(location, length);
//            }
//            rang1 = [text rangeOfString:findText options:NSCaseInsensitiveSearch range:rang1];
//            if (rang1.location == NSNotFound && rang1.length == 0) {
//                break;
//            }else
//                [arrayRanges addObject:[NSNumber numberWithInteger:rang1.location]];
//        }
//        return arrayRanges;
//    }
//    return nil;
//}






@end
