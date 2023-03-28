//
//  RSVideoServer.h
//  石来石往
//
//  Created by mac on 2018/7/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSVideoServer : NSObject

///视频名字
@property (nonatomic,strong) NSString *videoName;


/// 压缩视频
-(void)compressVideo:(NSURL *)path andVideoName:(NSString *)name andUserName:(NSString *)userName  andType:(NSString *)type andSave:(BOOL)saveState
     successCompress:(void(^)(NSURL *))successCompress;

/// 获取视频的首帧缩略图
- (UIImage *)imageWithVideoURL:(NSURL *)url;


@end
