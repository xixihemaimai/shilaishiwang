//
//  Utility.h
//  StoneOnlineApp
//
//  Created by 曾旭升 on 14-12-18.
//  Copyright (c) 2014年 RuishiInfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>


@interface Utility : NSObject {
    
}

+ (NSString *) md5:(NSString *)str;

+ (NSData *) doCipher:(id)sTextIn key:(NSString *)sKey context:(CCOperation)encryptOrDecrypt;

+ (NSString *) encryptStr:(NSString *) str;
+ (NSString *) decryptStr:(NSString	*) str;

+ (NSData *) encryptData:(NSData *) data;
+ (NSData *) decryptData:(NSData *)data;

#pragma mark Based64
+ (NSString *) encodeBase64WithString:(NSString *)strData;
+ (NSString *) encodeBase64WithData:(NSData *)objData;
+ (NSData *) decodeBase64WithString:(NSString *)strBase64;

/*
 *  用于密码加密解密，插入数据库
 */
+ (NSString *)decryptStrForSqlite3:(NSString *)str;
+ (NSString *)encryptStrForSqlite3:(NSString *)str;

#pragma mark - sha1加密 -
/**
 *	安全哈希算法
 *
 *	@param input 需要加密的字符串
 *
 *	@return 加密后的字符串
 */
+ (NSString *)sha1:(NSString *)input;



/**
 时间戳转日期
 
 @param timestamp 时间戳
 @return 日期
 */
+ (NSString *)getDateFormatByTimestamp:(long long)timestamp;




+ (NSString *)compareCurrentTime:(NSString *)str;


/**
 获取单张图片的实际size
 
 @param singleSize 原始
 @return 结果
 */
+ (CGSize)getSingleSize:(CGSize)singleSize;

+ (CGSize)videogetSingleSize:(CGSize)singleSize;

@end
