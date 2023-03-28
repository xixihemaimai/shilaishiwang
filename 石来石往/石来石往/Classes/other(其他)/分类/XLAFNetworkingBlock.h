//
//  XLAFNetworkingBlock.h
//  K线图的绘制
//
//  Created by 徐龙 on 2017/2/15.
//  Copyright © 2017年 徐龙. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AFNetworkingBlock)(id json,BOOL success);
typedef void(^Success)(id json);
typedef void(^Faliure)(NSError * error);

@interface XLAFNetworkingBlock : NSObject<NSCopying>
//类的对象方法
-(void)getDataWithUrlString :(NSString *)url withParameters:(NSDictionary *)parameters withBlock:(AFNetworkingBlock)block;

//另一种形式
-(void)getDataWithUrlString :(NSString *)url withParameters:(NSDictionary *)parameters andSuccess:(Success)success andFailure:(Faliure)failure;

//类方法
+(void)getDataWithUrlString :(NSString *)url withParameters:(NSDictionary *)parameters withBlock:(AFNetworkingBlock)block;

//上传单图的图片
- (void)getImageDataWithUrlString :(NSString *)url withParameters:(NSDictionary *)parameters  andDataArray:(NSMutableArray *)dataArray  withBlock:(AFNetworkingBlock)block;


//上传多图的图片
- (void)getMoreImageDataWithUrlString :(NSString *)url withParameters:(NSDictionary *)parameters  andDataArray:(NSMutableArray *)dataArray  withBlock:(AFNetworkingBlock)block;

//上传单张图片
- (void)getLeafletsImageDataWithUrlString:(NSString *)url withParameters:(NSDictionary *)parameters  andImage:(UIImage *)image  withBlock:(AFNetworkingBlock)block;

//视频上传
- (void)getVideoDataWithUrlString:(NSString *)url withParameters:(NSDictionary *)parameters andDataArray:(NSMutableArray *)imageArray andUImage:(UIImage *)image withBlock:(AFNetworkingBlock)block;

@end
