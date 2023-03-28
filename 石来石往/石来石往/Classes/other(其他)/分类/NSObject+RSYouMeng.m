//
//  NSObject+RSYouMeng.m
//  石来石往
//
//  Created by mac on 2019/10/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "NSObject+RSYouMeng.h"

//#import <AppKit/AppKit.h>


@implementation NSObject (RSYouMeng)
+ (void)load{
    
    SEL originalSelector = @selector(doesNotRecognizeSelector:);
    SEL swizzledSelector = @selector(sw_doesNotRecognizeSelector:);
    
    Method originalMethod = class_getClassMethod(self, originalSelector);
    Method swizzledMethod = class_getClassMethod(self, swizzledSelector);
    
    if(class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))){
        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)sw_doesNotRecognizeSelector:(SEL)aSelector{
    //处理 _LSDefaults 崩溃问题
    if([[self description] isEqualToString:@"_LSDefaults"] && (aSelector == @selector(sharedInstance))){
        //冷处理...
        return;
    }
    [self sw_doesNotRecognizeSelector:aSelector];
}


- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    //为了解决json字符串先赋值给oc字典后，类型转换crash问题，如:
    //json->oldValue:0
    //model中值为NSString类型
    //如果先将json转为dic，dic中对应value值为NSNumber类型，则向oldValue发送isEqualToString消息会crash
    id tempValue = oldValue;
    if ([property.type.code isEqualToString:@"NSString"]) {
        tempValue = [NSString stringWithFormat:@"%@", tempValue];
        if ([tempValue isKindOfClass:[NSNull class]] || tempValue == nil || [tempValue isEqual:[NSNull null]] ||  [tempValue isEqualToString:@"(null)"] ||  [tempValue isEqualToString:@"(\n)"] ) {
            return @"";
        }
    }
    if ([property.type.code isEqualToString:@"NSNumber"]) {
//        tempValue = [NSNumber numberWithFloat:[tempValue floatValue]];
        if ([tempValue isKindOfClass:[NSNull class]] || tempValue == nil || [tempValue isEqual:[NSNull null]] ||  [tempValue isEqualToString:@"(null)"] ||  [tempValue isEqualToString:@"(\n)"] ) {
            return @0;
        }
    }
    return tempValue;
}

@end
