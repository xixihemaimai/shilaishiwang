//
//  XLAFNetworkingBlock.m
//  K线图的绘制
//
//  Created by 徐龙 on 2017/2/15.
//  Copyright © 2017年 徐龙. All rights reserved.
//

#import "XLAFNetworkingBlock.h"
#import <AFHTTPSessionManager.h>
#import "AFHTTPSessionManager+ShareManger.h"

#import "RSVideoServer.h"
@interface XLAFNetworkingBlock()

@end

@implementation XLAFNetworkingBlock

static XLAFNetworkingBlock *lmanager;
+ (instancetype)sharedAPIManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lmanager = [[XLAFNetworkingBlock alloc] init];
        
    });
    return lmanager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lmanager = [super allocWithZone:zone];
    });
    return lmanager;
}

- (id)copyWithZone:(NSZone *)zone
{
    return lmanager;
}



-(void)getDataWithUrlString :(NSString *)url withParameters:(NSDictionary *)parameters withBlock:(AFNetworkingBlock)block{
    //void(^AFNetworkingBlock)(id json,BOOL success)
    
    [[AFHTTPSessionManager sharedHTTPSession] POST:url parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //请求成功
            block(responseObject,YES);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //请求失败
            block(error,NO);
        }];
    
    
//    [[AFHTTPSessionManager sharedHTTPSession]POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        //请求成功
//        block(responseObject,YES);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        //请求失败
//        block(error,NO);
//    }];
}


-(void)getDataWithUrlString :(NSString *)url withParameters:(NSDictionary *)parameters andSuccess:(Success)success andFailure:(Faliure)failure{
    //void(^AFNetworkingBlock)(id json,BOOL success)
    
    [[AFHTTPSessionManager sharedHTTPSession] POST:url parameters:parameters headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //请求成功
            if (success) {
                success(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //请求失败
            if (failure) {
                failure(error);
            }
        }];
    
    
//    [[AFHTTPSessionManager sharedHTTPSession]POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        //请求成功
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        //请求失败
//        if (failure) {
//            failure(error);
//        }
//    }];
}





- (void)getImageDataWithUrlString :(NSString *)url withParameters:(NSDictionary *)parameters  andDataArray:(NSMutableArray *)dataArray  withBlock:(AFNetworkingBlock)block{
 
    /*
     
     [mgr POST:_dateArr[1] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
     for (NSData *formImageData in dataArray)
     {
     [formData appendPartWithFileData:formImageData name:@"files" fileName:@"image.jpeg" mimeType:@"image/jpeg"];
     
     }
     } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
     
     
     
     [SVProgressHUD dismiss];
     
     NSString * code = responseObject[@"MSG_CODE"];
     NSString * data = responseObject[@"Data"];
     
     
     NSString *jsCode = [NSString stringWithFormat:@"%@('%@','%@');",_dateArr[2],code,data];
     //[_webView stringByEvaluatingJavaScriptFromString:jsCode];
     [_webView evaluateJavaScript:jsCode completionHandler:nil];
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     
     [SVProgressHUD showErrorWithStatus:@"上传失败"];
     }];
     
     */
    
    
    [[AFHTTPSessionManager sharedHTTPSession]POST:url parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSData *formImageData in dataArray)
        {
            [formData appendPartWithFileData:formImageData name:@"file" fileName:@"image.png" mimeType:@"image/jpg/png/jpeg"];
        }
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            block(responseObject,YES);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            block(error,NO);
        }];
    
//    [[AFHTTPSessionManager sharedHTTPSession]POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//        for (NSData *formImageData in dataArray)
//        {
//            [formData appendPartWithFileData:formImageData name:@"file" fileName:@"image.png" mimeType:@"image/jpg/png/jpeg"];
//        }
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        block(responseObject,YES);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        block(error,NO);
//    }];

}


#pragma mark -- 单张图片上传
- (void)getLeafletsImageDataWithUrlString:(NSString *)url withParameters:(NSDictionary *)parameters  andImage:(UIImage *)image  withBlock:(AFNetworkingBlock)block{
    [[AFHTTPSessionManager sharedHTTPSession]POST:url parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
        // 要解决此问题，
        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        [formatter setDateFormat:@"yyyyMMddHHmmss.SSS"];
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];
        /*
         *该方法的参数
         *1. appendPartWithFileData：要上传的照片[二进制流]
         *2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
         *3. fileName：要保存在服务器上的文件名
         *4. mimeType：上传的文件的类型
         */
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            block(responseObject,YES);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            block(error,NO);
        }];
    
    
    
//    [[AFHTTPSessionManager sharedHTTPSession]POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSData *imageData = UIImageJPEGRepresentation(image, 1);
//        // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
//        // 要解决此问题，
//        // 可以在上传时使用当前的系统事件作为文件名
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        // 设置时间格式
//        [formatter setDateFormat:@"yyyyMMddHHmmss.SSS"];
//        NSString *dateString = [formatter stringFromDate:[NSDate date]];
//        NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];
//        /*
//         *该方法的参数
//         *1. appendPartWithFileData：要上传的照片[二进制流]
//         *2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
//         *3. fileName：要保存在服务器上的文件名
//         *4. mimeType：上传的文件的类型
//         */
//        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
//
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        block(responseObject,YES);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        block(error,NO);
//    }];
}




#pragma mark -- 多张图片
- (void)getMoreImageDataWithUrlString :(NSString *)url withParameters:(NSDictionary *)parameters  andDataArray:(NSMutableArray *)dataArray  withBlock:(AFNetworkingBlock)block{
    
    
    [[AFHTTPSessionManager sharedHTTPSession]POST:url parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < dataArray.count; i++) {
            UIImage *image = dataArray[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 1);
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss.SSS"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
        }
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            block(responseObject,YES);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            block(error,NO);
        }];
    
    
//    [[AFHTTPSessionManager sharedHTTPSession]POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
////        for (NSData *formImageData in dataArray)
////        {
////            [formData appendPartWithFileData:formImageData name:@"photo" fileName:@"image.png" mimeType:@"image/jpg/png/jpeg"];
//        //        }
//        for (int i = 0; i < dataArray.count; i++) {
//            UIImage *image = dataArray[i];
//            NSData *imageData = UIImageJPEGRepresentation(image, 1);
//            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
//            // 要解决此问题，
//            // 可以在上传时使用当前的系统事件作为文件名
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            // 设置时间格式
//            [formatter setDateFormat:@"yyyyMMddHHmmss.SSS"];
//            NSString *dateString = [formatter stringFromDate:[NSDate date]];
//            NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];
//            /*
//             *该方法的参数
//             1. appendPartWithFileData：要上传的照片[二进制流]
//             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
//             3. fileName：要保存在服务器上的文件名
//             4. mimeType：上传的文件的类型
//             */
//            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
//        }
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        block(responseObject,YES);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        block(error,NO);
//    }];
}

//视频上传
- (void)getVideoDataWithUrlString:(NSString *)url withParameters:(NSDictionary *)parameters andDataArray:(NSMutableArray *)imageArray andUImage:(UIImage *)image withBlock:(AFNetworkingBlock)block{
    
    
    [[AFHTTPSessionManager sharedHTTPSession]POST:url parameters:parameters headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < imageArray.count; i++) {
            NSURL *url = imageArray[i];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss.SSS"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSData *imageData = UIImageJPEGRepresentation(image, 1);
            NSData *videoData = [NSData dataWithContentsOfURL:url];
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            //NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
           // [formatter setDateFormat:@"yyyyMMddHHmmss.SSS"];
           // NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];
            /*
             *该方法的参数
             *1. appendPartWithFileData：要上传的照片[二进制流]
             *2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             *3. fileName：要保存在服务器上的文件名
             *4. mimeType：上传的文件的类型
             */
            //图片
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
            //视频
            [formData appendPartWithFileData:videoData name:@"file" fileName:@"video.mp4"  mimeType:@"video/mp4"];
//            UIImage *image = dataArray[i];
//            NSData *imageData = UIImageJPEGRepresentation(image, 1);
//            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
//            // 要解决此问题，
//            // 可以在上传时使用当前的系统事件作为文件名
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            // 设置时间格式
//            [formatter setDateFormat:@"yyyyMMddHHmmss.SSS"];
//            NSString *dateString = [formatter stringFromDate:[NSDate date]];
//            NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];
//            /*
//             *该方法的参数
//             1. appendPartWithFileData：要上传的照片[二进制流]
//             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
//             3. fileName：要保存在服务器上的文件名
//             4. mimeType：上传的文件的类型
//             */
//            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
        }
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            block(responseObject,YES);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            block(error,NO);
        }];
    
    
//    [[AFHTTPSessionManager sharedHTTPSession]POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        for (int i = 0; i < imageArray.count; i++) {
//            NSURL *url = imageArray[i];
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            // 设置时间格式
//            [formatter setDateFormat:@"yyyyMMddHHmmss.SSS"];
//            NSString *dateString = [formatter stringFromDate:[NSDate date]];
//            NSData *imageData = UIImageJPEGRepresentation(image, 1);
//            NSData *videoData = [NSData dataWithContentsOfURL:url];
//            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
//            // 要解决此问题，
//            // 可以在上传时使用当前的系统事件作为文件名
//            //NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            // 设置时间格式
//           // [formatter setDateFormat:@"yyyyMMddHHmmss.SSS"];
//           // NSString *dateString = [formatter stringFromDate:[NSDate date]];
//            NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];
//            /*
//             *该方法的参数
//             *1. appendPartWithFileData：要上传的照片[二进制流]
//             *2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
//             *3. fileName：要保存在服务器上的文件名
//             *4. mimeType：上传的文件的类型
//             */
//            //图片
//            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
//            //视频
//            [formData appendPartWithFileData:videoData name:@"file" fileName:@"video.mp4"  mimeType:@"video/mp4"];
////            UIImage *image = dataArray[i];
////            NSData *imageData = UIImageJPEGRepresentation(image, 1);
////            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
////            // 要解决此问题，
////            // 可以在上传时使用当前的系统事件作为文件名
////            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
////            // 设置时间格式
////            [formatter setDateFormat:@"yyyyMMddHHmmss.SSS"];
////            NSString *dateString = [formatter stringFromDate:[NSDate date]];
////            NSString *fileName = [NSString  stringWithFormat:@"%@.png", dateString];
////            /*
////             *该方法的参数
////             1. appendPartWithFileData：要上传的照片[二进制流]
////             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
////             3. fileName：要保存在服务器上的文件名
////             4. mimeType：上传的文件的类型
////             */
////            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
//        }
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        block(responseObject,YES);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        block(error,NO);
//    }];
}





+(void)getDataWithUrlString :(NSString *)url withParameters:(NSDictionary *)parameters withBlock:(AFNetworkingBlock)block
{
    [[[self class] sharedAPIManager] getDataWithUrlString:url withParameters:parameters withBlock:^(id json, BOOL success) {
         block(json,success);
    }];
}


@end
