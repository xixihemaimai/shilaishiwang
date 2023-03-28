//
//  Utility.m
//  StoneOnlineApp
//
//  Created by 曾旭升 on 14-12-18.
//  Copyright (c) 2014年 RuishiInfo. All rights reserved.
//

#import "Utility.h"

static NSString *_key = @"123456781234567812345678";
static NSString *sqlliteKey = @"252888825288882528888888";

static const char _base64EncodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static const short _base64DecodingTable[256] = {
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
	52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
	-2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
	15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
	-2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
	41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
};

@implementation Utility

//md5加密
+ (NSString *) md5:(NSString *)str
{
    if (str == nil) {
        return @"";
    }
	const char *cStr = [str UTF8String];
	
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	
	CC_MD5( cStr, strlen(cStr), result );
	
	return [NSString 
			
			stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			
			result[0], result[1],
			
			result[2], result[3],
			
			result[4], result[5],
			
			result[6], result[7],
			
			result[8], result[9],
			
			result[10], result[11],
			
			result[12], result[13],
			
			result[14], result[15]
			
			];
}

//des加密
+ (NSString *) encryptStr:(NSString *) str
{
    NSData *retData = [Utility doCipher:str key:_key context:kCCEncrypt];
    //加密后base64编码
    NSString * sResult = [Utility encodeBase64WithData:retData];
    return sResult;
}

//des解密
+ (NSString *) decryptStr:(NSString	*) str
{
    NSData *retData = [Utility doCipher:str key:_key context:kCCDecrypt];
    NSString * sResult;
    //base64解码
    sResult = [[ NSString alloc] initWithData:retData encoding:NSUTF8StringEncoding];
 	return sResult;
}

//des加密nsdata
+ (NSData *)encryptData:(NSData *) data
{
	return [Utility doCipher:data key:_key context:kCCEncrypt];
}

//des解密nsdata
+ (NSData *)decryptData:(NSData *)data
{
    return [self doCipher:data key:_key context:kCCDecrypt];
}

/*
 *  用于密码加密解密，插入数据库
 */
+ (NSString *)decryptStrForSqlite3:(NSString *)str
{
    NSData *retData = [Utility doCipher:str key:sqlliteKey context:kCCDecrypt];
    NSString * sResult;
    //base64解码
    sResult = [[ NSString alloc] initWithData:retData encoding:NSUTF8StringEncoding];
 	return sResult;    
}
+ (NSString *)encryptStrForSqlite3:(NSString *)str
{
    NSData *retData = [Utility doCipher:str key:sqlliteKey context:kCCEncrypt];
    //加密后base64编码
    NSString * sResult = [Utility encodeBase64WithData:retData];
    return sResult;
}

//加密或解密
+ (NSData *)doCipher:(id)data key:(NSString *)sKey context:(CCOperation)encryptOrDecrypt {
	
    //要加密的数据
    NSMutableData * dTextIn;
    //编码类型
    NSStringEncoding EnC = NSUTF8StringEncoding;
    
    //传入的是字符串
    if ([data isKindOfClass:[NSString class]]) {
        if (encryptOrDecrypt == kCCDecrypt) //解密前base64解码
        {
            dTextIn = [[Utility decodeBase64WithString:data] mutableCopy];
        }
        else//加密前确保编码方式为utf-8
        {
            dTextIn = [[data dataUsingEncoding: EnC] mutableCopy];
        }
    }
    else if ([data isKindOfClass:[NSData class]])//nsdata数据
    {
        dTextIn = data;
    }
    else
    {
        NSLog(@"not support data type");
    }
    
    Byte kkk[24];
    for (int i = 0; i < 24; i++)
    {
        kkk[i] = (Byte)([sKey characterAtIndex:i] - 48);
    }
//    Byte key1[] = { 1, 2, 3, 4, 5, 6, 7, 8, 1, 2, 3, 4, 5, 6,7, 8, 1, 2, 3, 4, 5, 6, 7, 8 };
    NSMutableData * dKey = [NSMutableData dataWithBytes:kkk length:24];
    [dKey setLength:kCCBlockSizeDES];
    
    uint8_t *bufferPtr1 = NULL;
    size_t bufferPtrSize1 = 0;
    //输出字节长度
    size_t movedBytes1 = 0;
    //uint8_t iv[kCCBlockSizeDES];
	//memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    //混淆密码
//	Byte iv[] = {0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
    Byte iv[] = {0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08};
    
    //分配内存
    bufferPtrSize1 = ([data length] + kCCKeySizeDES) & ~(kCCKeySizeDES -1);
    bufferPtr1 = malloc(bufferPtrSize1 * sizeof(uint8_t));    
    memset((void *)bufferPtr1, 0x00, bufferPtrSize1);    
	
    CCCryptorStatus cryptStatus = CCCrypt(encryptOrDecrypt, // CCOperation op    
			kCCAlgorithmDES, // CCAlgorithm alg    
			kCCOptionPKCS7Padding, // CCOptions options    
			[dKey bytes], // const void *key    
			[dKey length], // size_t keyLength    
			iv, // const void *iv    
			[dTextIn bytes], // const void *dataIn
			[dTextIn length],  // size_t dataInLength    
			(void *)bufferPtr1, // void *dataOut    
			bufferPtrSize1,     // size_t dataOutAvailable 
			&movedBytes1);      // size_t *dataOutMoved    
    
    /*
     *  解密是否成功
     */
    if (cryptStatus == kCCSuccess)
    {
        NSData *data = [NSData dataWithBytes:bufferPtr1 length:movedBytes1];
        free(bufferPtr1);
        return data;
    }
    free(bufferPtr1);

	return nil;
}

+ (NSString *)encodeBase64WithString:(NSString *)strData {
	return [Utility encodeBase64WithData:[strData dataUsingEncoding:NSUTF8StringEncoding]];
}

+ (NSString *)encodeBase64WithData:(NSData *)objData {
	const unsigned char * objRawData = [objData bytes];
	char * objPointer;
	char * strResult;
	
	// Get the Raw Data length and ensure we actually have data
	NSInteger intLength = [objData length];
	if (intLength == 0) return nil;
	
	// Setup the String-based Result placeholder and pointer within that placeholder
	strResult = (char *)calloc(((intLength + 1) / 3) * 4 + 1, sizeof(char));
	objPointer = strResult;
	
	// Iterate through everything
	while (intLength > 2) { // keep going until we have less than 24 bits
		*objPointer++ = _base64EncodingTable[objRawData[0] >> 2];
		*objPointer++ = _base64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)];
		*objPointer++ = _base64EncodingTable[((objRawData[1] & 0x0f) << 2) + (objRawData[2] >> 6)];
		*objPointer++ = _base64EncodingTable[objRawData[2] & 0x3f];
		
		// we just handled 3 octets (24 bits) of data
		objRawData += 3;
		intLength -= 3; 
	}
	
	// now deal with the tail end of things
	if (intLength != 0) {
		*objPointer++ = _base64EncodingTable[objRawData[0] >> 2];
		if (intLength > 1) {
			*objPointer++ = _base64EncodingTable[((objRawData[0] & 0x03) << 4) + (objRawData[1] >> 4)];
			*objPointer++ = _base64EncodingTable[(objRawData[1] & 0x0f) << 2];
			*objPointer++ = '=';
		} else {
			*objPointer++ = _base64EncodingTable[(objRawData[0] & 0x03) << 4];
			*objPointer++ = '=';
			*objPointer++ = '=';
		}
	}
	
	// Terminate the string-based result
	*objPointer = '\0';
	
	// Return the results as an NSString object
    NSString *result = [NSString stringWithCString:strResult encoding:NSASCIIStringEncoding];
    free(strResult);
	return result;
}

+ (NSData *)decodeBase64WithString:(NSString *)strBase64 {
	const char * objPointer = [strBase64 cStringUsingEncoding:NSASCIIStringEncoding];
    if (objPointer == nil)
    {
        NSLog(@"base64 fail");
        return nil;
    }
	int intLength = strlen(objPointer);
	int intCurrent;
	int i = 0, j = 0, k;
	
	unsigned char * objResult;
	objResult = calloc(intLength, sizeof(unsigned char));
	
	// Run through the whole string, converting as we go
	while ( ((intCurrent = *objPointer++) != '\0') && (intLength-- > 0) ) {
		if (intCurrent == '=') {
			if (*objPointer != '=' && ((i % 4) == 1)) {// || (intLength > 0)) {
                                                       // the padding character is invalid at this point -- so this entire string is invalid
				free(objResult);
				return nil;
			}
			continue;
		}
		
		intCurrent = _base64DecodingTable[intCurrent];
		if (intCurrent == -1) {
			// we're at a whitespace -- simply skip over
			continue;
		} else if (intCurrent == -2) {
			// we're at an invalid character
			free(objResult);
			return nil;
		}
		
		switch (i % 4) {
			case 0:
				objResult[j] = intCurrent << 2;
				break;
				
			case 1:
				objResult[j++] |= intCurrent >> 4;
				objResult[j] = (intCurrent & 0x0f) << 4;
				break;
				
			case 2:
				objResult[j++] |= intCurrent >>2;
				objResult[j] = (intCurrent & 0x03) << 6;
				break;
				
			case 3:
				objResult[j++] |= intCurrent;
				break;
		}
		i++;
	}
	
	// mop things up if we ended on a boundary
	k = j;
	if (intCurrent == '=') {
		switch (i % 4) {
			case 1:
				// Invalid state
				free(objResult);
				return nil;
				
			case 2:
				k++;
				// flow through
			case 3:
				objResult[k] = 0;
		}
	}
	
	// Cleanup and setup the return NSData
	NSData * objData = [[NSData alloc] initWithBytes:objResult length:j];
	free(objResult);
	return objData;
}

#pragma mark - sha1加密 -
/**
 *	安全哈希算法
 *
 *	@param input 需要加密的字符串
 *
 *	@return 加密后的字符串
 */
+ (NSString *)sha1:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH*2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}


/**
 *  显示几分钟前、几小时前等 str格式：yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)compareCurrentTime:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    long temp = 0;
    NSString *result;
    if (timeInterval/60 < 1) {
    result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
    result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = temp/60) <24){
    result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if((temp = temp/24) <30){
    result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    else if((temp = temp/30) <12){
    result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
    temp = temp/12;
    result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    return  result;
    
    
    //2019-01-05 14:20:39.33
    //把字符串转为NSdate
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *timeDate = [dateFormatter dateFromString:str];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
//    //得到与当前时间差
//    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
//    timeInterval = -timeInterval;
//
//    //标准时间和北京时间差8个小时
//    timeInterval = timeInterval - 8*60*60;
//    long temp = 0;
//    NSString *result;
//    if (timeInterval < 60) {
//        result = [NSString stringWithFormat:@"刚刚"];
//    }
//    else if((temp = timeInterval/60) <60){
//        result = [NSString stringWithFormat:@"%ld分钟前",temp];
//    }
//
//    else if((temp = temp/60) <24){
//        result = [NSString stringWithFormat:@"%ld小时前",temp];
//    }
//
//    else if((temp = temp/24) <30){
//        result = [NSString stringWithFormat:@"%ld天前",temp];
//    }
//
//    else if((temp = temp/30) <12){
//        result = [NSString stringWithFormat:@"%ld月前",temp];
//    }
//    else{
//        temp = temp/12;
//        result = [NSString stringWithFormat:@"%ld年前",temp];
//    }
//
//    return  result;
}


+ (NSString *)getDateFormatByTimestamp:(long long)timestamp
{
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval nowTimestamp = [dat timeIntervalSince1970] ;
    long long int timeDifference = nowTimestamp - timestamp;
    long long int secondTime = timeDifference;
    long long int minuteTime = secondTime/60;
    long long int hoursTime = minuteTime/60;
    long long int dayTime = hoursTime/24;
    long long int monthTime = dayTime/30;
    long long int yearTime = monthTime/12;
    
    if (1 <= yearTime) {
        return [NSString stringWithFormat:@"%lld年前",yearTime];
    }
    else if(1 <= monthTime) {
        return [NSString stringWithFormat:@"%lld月前",monthTime];
    }
    else if(1 <= dayTime) {
        return [NSString stringWithFormat:@"%lld天前",dayTime];
    }
    else if(1 <= hoursTime) {
        return [NSString stringWithFormat:@"%lld小时前",hoursTime];
    }
    else if(1 <= minuteTime) {
        return [NSString stringWithFormat:@"%lld分钟前",minuteTime];
    }
    else if(1 <= secondTime) {
        return [NSString stringWithFormat:@"%lld秒前",secondTime];
    }
    else {
        return @"刚刚";
    }
}

#pragma mark - 获取单张图片的实际size
+ (CGSize)getSingleSize:(CGSize)singleSize
{
    CGFloat max_width = SCW - 150;
    CGFloat max_height = SCW - 130;
    CGFloat image_width = singleSize.width;
    CGFloat image_height = singleSize.height;
    
    CGFloat result_width = 0;
    CGFloat result_height = 0;
    if (image_height/image_width > 3.0) {
        result_height = max_height;
        result_width = result_height/2;
    }  else  {
        result_width = max_width;
        result_height = max_width*image_height/image_width;
        if (result_height > max_height) {
            result_height = max_height;
            result_width = max_height*image_width/image_height;
        }
    }
    return CGSizeMake(result_width, result_height);
}


+ (CGSize)videogetSingleSize:(CGSize)singleSize
{
    CGFloat max_width = SCW - 150;
    CGFloat max_height = SCW - 130;
    CGFloat image_width = singleSize.width;
    CGFloat image_height = singleSize.height;
    
    CGFloat result_width = 0;
    CGFloat result_height = 0;
    if (image_height/image_width > 3.0) {
        result_height = max_height;
        result_width = result_height/2;
    }  else  {
        if(image_width>image_height){
        result_width = max_width;
        result_height = max_width*image_height/image_width;
//        if (result_height > max_height) {
//            result_height = max_height;
//            result_width = max_height*image_width/image_height;
//        }
        }else{
            result_height = max_height;
            result_width = max_height*image_width/image_height;
//            if (result_width > max_width) {
//                result_width = max_width;
//                result_height = max_width*image_height/image_width;
//            }
        }
    }
    return CGSizeMake(result_height, result_width);
    
}





@end
