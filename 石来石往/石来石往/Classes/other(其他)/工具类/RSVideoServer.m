//
//  RSVideoServer.m
//  石来石往
//
//  Created by mac on 2018/7/26.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "RSVideoServer.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface RSVideoServer()




@end


@implementation RSVideoServer




//压缩视频
-(void)compressVideo:(NSURL *)path andVideoName:(NSString *)name andUserName:(NSString *)userName  andType:(NSString *)type andSave:(BOOL)saveState
     successCompress:(void(^)(NSURL *))successCompress  //saveState 是否保存视频到相册
{
    self.videoName = name;
    
    
    [SVProgressHUD showInfoWithStatus:@"正在上传中........."];
    
    NSString * outputPath  = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"dafei-%@.mp4",self.videoName]];
    
    NSURL *outputURL = [NSURL fileURLWithPath:outputPath];
   
    
    
    
    
    
    //如果文件已经存在，先移除，否则会报无法存储的错误
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:outputPath error:nil];
    
    AVURLAsset *avAsset = [[AVURLAsset alloc] initWithURL:path options:nil];
    
    
    AVMutableComposition *mixComposition = [[AVMutableComposition alloc] init];
    
    
    //3 视频通道
    AVMutableCompositionTrack *videoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo
                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
    [videoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, avAsset.duration)
                        ofTrack:[[avAsset tracksWithMediaType:AVMediaTypeVideo] firstObject]
                         atTime:kCMTimeZero error:nil];
    
    
    //2 音频通道
    AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio
                                                                        preferredTrackID:kCMPersistentTrackID_Invalid];
    [audioTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, avAsset.duration)
                        ofTrack:[[avAsset tracksWithMediaType:AVMediaTypeAudio] firstObject]
                         atTime:kCMTimeZero error:nil];
    
    //3.1 AVMutableVideoCompositionInstruction 视频轨道中的一个视频，可以缩放、旋转等
    AVMutableVideoCompositionInstruction *mainInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    mainInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, avAsset.duration);
    
    // 3.2 AVMutableVideoCompositionLayerInstruction 一个视频轨道，包含了这个轨道上的所有视频素材
    AVMutableVideoCompositionLayerInstruction *videolayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
    
    [videolayerInstruction setOpacity:0.0 atTime:avAsset.duration];
    
    // 3.3 - Add instructions
    mainInstruction.layerInstructions = [NSArray arrayWithObjects:videolayerInstruction,nil];
    
    //AVMutableVideoComposition：管理所有视频轨道，水印添加就在这上面
    AVMutableVideoComposition *mainCompositionInst = [AVMutableVideoComposition videoComposition];
    
    
    // 视频转向
    int degrees = [self degressFromVideoFileWithAsset:avAsset];
    
    AVAssetTrack *videoAssetTrack = [[avAsset tracksWithMediaType:AVMediaTypeVideo] firstObject];
    CGSize naturalSize = videoAssetTrack.naturalSize;
    
//    float renderWidth, renderHeight;
//    renderWidth = naturalSize.width;
//    renderHeight = naturalSize.height;
    CGAffineTransform translateToCenter;
    CGAffineTransform mixedTransform;
    
    
 
 //   mainCompositionInst.renderSize = CGSizeMake(renderWidth, renderHeight);
   // mainCompositionInst.instructions = [NSArray arrayWithObject:mainInstruction];
    mainCompositionInst.frameDuration = CMTimeMake(1, 30);
    
    
    
    if (degrees == 90) // UIImageOrientationRight
    {
        
        // 顺时针旋转90°
        translateToCenter = CGAffineTransformMakeTranslation(videoTrack.naturalSize.height, 0.0);
        mixedTransform = CGAffineTransformRotate(translateToCenter, M_PI_2);
        mainCompositionInst.renderSize = CGSizeMake(videoTrack.naturalSize.height, videoTrack.naturalSize.width);
        [videolayerInstruction setTransform:mixedTransform atTime:kCMTimeZero];
    }
    else if (degrees == 180) // UIImageOrientationDown
    {
        
        // 顺时针旋转180°
        translateToCenter = CGAffineTransformMakeTranslation(videoTrack.naturalSize.width, videoTrack.naturalSize.height);
        mixedTransform = CGAffineTransformRotate(translateToCenter, M_PI);
        mainCompositionInst.renderSize = CGSizeMake(videoTrack.naturalSize.width, videoTrack.naturalSize.height);
        [videolayerInstruction setTransform:mixedTransform atTime:kCMTimeZero];
    }
    else if (degrees == 270) // UIImageOrientationLeft
    {
        
        // 顺时针旋转270°
        translateToCenter = CGAffineTransformMakeTranslation(0.0, videoTrack.naturalSize.width);
        mixedTransform = CGAffineTransformRotate(translateToCenter, M_PI_2 * 3.0);
        mainCompositionInst.renderSize = CGSizeMake(videoTrack.naturalSize.height, videoTrack.naturalSize.width);
        [videolayerInstruction setTransform:mixedTransform atTime:kCMTimeZero];
    }else if (degrees == 0){
        
        mainCompositionInst.renderSize = CGSizeMake(naturalSize.width, naturalSize.height);
        
        
    }
    // 方向是 0 不做处理
    
    mainInstruction.layerInstructions = @[videolayerInstruction];
    mainCompositionInst.instructions = @[mainInstruction]; // 加入视频方向信息
//
    
//    CATextLayer *subtitle1Text = [[CATextLayer alloc] init];
//    [subtitle1Text setFont:@"Helvetica-Bold"];
//
//    [subtitle1Text setFrame:CGRectMake(0,mainCompositionInst.renderSize.height - 50, mainCompositionInst.renderSize.width, 50)];
//    [subtitle1Text setString:@"石来石往"];
//    [subtitle1Text setAlignmentMode:kCAAlignmentLeft];
//    [subtitle1Text setForegroundColor:[[UIColor whiteColor] CGColor]];
    
    
    CATextLayer *subtitle2Text = [[CATextLayer alloc] init];
    [subtitle2Text setFont:@"Helvetica-Bold"];
   
    
    [subtitle2Text setString:userName];
    [subtitle2Text setAlignmentMode:kCAAlignmentRight];
    [subtitle2Text setForegroundColor:[[UIColor whiteColor] CGColor]];
    
    

    
    CALayer *overlayLayer = [CALayer layer];
    CALayer *imgLayer = [CALayer layer];
   
    
    if (![type isEqualToString:@"3"]) {
         UIImage * image = [UIImage imageNamed:@"石来石往logo"];
         imgLayer.contents = (id)image.CGImage;
    }
    // 2 - The usual overlay
    //imgLayer.bounds = CGRectMake(0, 10, 90, 42);
   
    CGFloat rate = 0.0;
    if (mainCompositionInst.renderSize.width < mainCompositionInst.renderSize.height) {
        
         rate = ((CGFloat)mainCompositionInst.renderSize.width/360);
    }else{
        rate = ((CGFloat)mainCompositionInst.renderSize.height/480);
    }
    
 
    
    
    
    CGFloat logoW = ((CGFloat)90 * rate);
    CGFloat logoH = ((CGFloat)42/(CGFloat)90) * logoW;
   
    CGFloat bord = ((CGFloat)12 * rate);
    CGFloat textH = ((CGFloat)50 * rate);
    CGFloat fontSize = ((CGFloat)20 * rate);
//    if ([type isEqualToString:@"1"]) {
//
//        //[subtitle1Text setFontSize:35];
//
//
//        if (mainCompositionInst.renderSize.width <= 360 && mainCompositionInst.renderSize.height <= 480) {
//            // imgLayer.frame = CGRectMake(0, 0, 100, 30);
//            imgLayer.position = CGPointMake(mainCompositionInst.renderSize.width - (SCW - bord) ,mainCompositionInst.renderSize.height - 50);
//
//            imgLayer.bounds = CGRectMake(0, 10, logoW, logoH);
//
//
//            [subtitle2Text setFontSize:fontSize];
//
//        }else{
    
             imgLayer.position = CGPointMake( bord  + (36 * rate),mainCompositionInst.renderSize.height - textH);
             imgLayer.bounds = CGRectMake(0, 10, logoW, logoH);
      // [subtitle2Text setFrame:CGRectMake(12, 0, mainCompositionInst.renderSize.width - 24, 50)];
    
    subtitle2Text.frame = CGRectMake(12, 0, mainCompositionInst.renderSize.width - 24, textH);
            [subtitle2Text setFontSize:fontSize];
            
//        }
    
        
//    }else{
//        //[subtitle1Text setFontSize:35];
//        [subtitle2Text setFontSize:35];
//    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    [overlayLayer addSublayer:imgLayer];

   // [overlayLayer addSublayer:subtitle1Text];
    [overlayLayer addSublayer:subtitle2Text];
    
    
    
    
    
    
    
    
    
    
    overlayLayer.frame = CGRectMake(0, 0, mainCompositionInst.renderSize.width, mainCompositionInst.renderSize.height);
    [overlayLayer setMasksToBounds:YES];
    CALayer *parentLayer = [CALayer layer];
    CALayer *videoLayer = [CALayer layer];
    parentLayer.frame = CGRectMake(0, 0, mainCompositionInst.renderSize.width, mainCompositionInst.renderSize.height);
    videoLayer.frame = CGRectMake(0, 0, mainCompositionInst.renderSize.width, mainCompositionInst.renderSize.height);
    // 这里看出区别了吧，我们把overlayLayer放在了videolayer的上面，所以水印总是显示在视频之上的。
    [parentLayer addSublayer:videoLayer];
    [parentLayer addSublayer:overlayLayer];
    mainCompositionInst.animationTool = [AVVideoCompositionCoreAnimationTool
                                videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
         
    
    //[self applyVideoEffectsToComposition:mainCompositionInst size:naturalSize];
    
//    //    // 4 - 输出路径
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:
//                             [NSString stringWithFormat:@"FinalVideo-%d.mp4",arc4random() % 1000]];
//    NSURL* videoUrl = [NSURL fileURLWithPath:myPathDocs];
    
    // 5 - 视频文件输出
    AVAssetExportSession *exporter = [[AVAssetExportSession alloc] initWithAsset:mixComposition
                                                                      presetName:AVAssetExportPresetHighestQuality];
    exporter.outputURL = outputURL;
    //exporter.outputFileType = AVFileTypeMPEG4;
    exporter.audioMix = nil;
    exporter.videoComposition = mainCompositionInst;
//    [exporter exportAsynchronouslyWithCompletionHandler:^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            if( exporter.status == AVAssetExportSessionStatusCompleted ){
//
//                UISaveVideoAtPathToSavedPhotosAlbum(myPathDocs, nil, nil, nil);
//
//            }else if( exporter.status == AVAssetExportSessionStatusFailed )
//            {
//                NSLog(@"failed");
//            }
//
//        });
//    }];
   NSArray *supportedTypeArray = exporter.supportedFileTypes;
     if ([supportedTypeArray containsObject:AVFileTypeMPEG4])
     {
        exporter.outputFileType = AVFileTypeMPEG4;
     }
     else
     {
       exporter.outputFileType = AVFileTypeQuickTimeMovie;
     }
    exporter.shouldOptimizeForNetworkUse = true;
    [exporter exportAsynchronouslyWithCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            // 如果导出的状态为完成
            [SVProgressHUD dismiss];
            if (exporter.status == AVAssetExportSessionStatusCompleted) {
                //NSLog(@"视频压缩成功,压缩后大小 %f MB",[self fileSize:[self compressedURL]]);
            
                
                if (saveState) {
                    [self saveVideo:outputURL];//保存视频到相册
                }
                //压缩成功视频流回调回去
                // successCompress([NSData dataWithContentsOfURL:[self compressedURL]].length > 0?[NSData dataWithContentsOfURL:[self compressedURL]]:nil);
                //NSURL * outputURL = [self compressedURL];
                
                successCompress(outputURL);
                
            }else{
                //压缩失败的回调

                successCompress(nil);
            }
        });
    }];
    
    
    
    
    
    
//    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
//    if ([compatiblePresets containsObject:AVAssetExportPresetLowQuality]) {
//
//        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPreset640x480];
//        exportSession.outputURL = outputURL;//设置压缩后视频流导出的路径
//        exportSession.shouldOptimizeForNetworkUse = true;
//        //转换后的格式
//        exportSession.outputFileType = AVFileTypeMPEG4;
        //异步导出
//        [exportSession exportAsynchronouslyWithCompletionHandler:^{
//            // 如果导出的状态为完成
//            if ([exportSession status] == AVAssetExportSessionStatusCompleted) {
//                //NSLog(@"视频压缩成功,压缩后大小 %f MB",[self fileSize:[self compressedURL]]);
//
//
//                if (saveState) {
//                    [self saveVideo:outputURL];//保存视频到相册
//                }
//                //压缩成功视频流回调回去
//               // successCompress([NSData dataWithContentsOfURL:[self compressedURL]].length > 0?[NSData dataWithContentsOfURL:[self compressedURL]]:nil);
//                //NSURL * outputURL = [self compressedURL];
//
//                successCompress(outputURL);
//
//            }else{
//                //压缩失败的回调
//                successCompress(nil);
//            }
//        }];
//    }
}
/// 获取视频角度
- (int)degressFromVideoFileWithAsset:(AVAsset *)asset
{
    int degress = 0;
    NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo]; //获取轨道资源
    if ([tracks count] > 0)
    {
        AVAssetTrack *videoTrack = [tracks objectAtIndex:0];
        CGAffineTransform t = videoTrack.preferredTransform; // 处理形变的类型
        if (t.a == 0 && t.b == 1.0 && t.c == -1.0 && t.d == 0)
        {
            //     x = -y / y = x  逆时针旋转 90 度
            degress = 90; //UIImageOrientationRight
        }
        else if (t.a == 0 && t.b == -1.0 && t.c == 1.0 && t.d == 0)
        {
            //     x = y / y = -x    逆时针旋转 270 度
            degress = 270; // UIImageOrientationLeft
        }
        else if (t.a == 1.0 && t.b == 0 && t.c == 0 && t.d == 1.0)
        {
            //   x = y / y = y         向右 ------ 旋转0度
            degress = 0; //UIImageOrientationUp
        }
        else if (t.a == -1.0 && t.b == 0 && t.c == 0 && t.d == -1.0)
        {
            // LandscapeLeft     x = -x / y = -y   逆时针旋转180
            degress = 180; //UIImageOrientationDown
        }
    }
    return degress;
    /*
     [a b   0]
     [c d    0]
     [tx ty   1]
     x = ax + cy + tx
     y = bx + dy + ty
     其中tx---x轴方向--平移,ty---y轴方向平移;a--x轴方向缩放,d--y轴缩放;abcd共同控制旋转
     */
}






#pragma mark 保存压缩
- (NSURL *)compressedURL
{
    return [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"dafei-%@.mp4",self.videoName]]];
}

#pragma mark 计算视频大小
- (CGFloat)fileSize:(NSURL *)path
{
    return [[NSData dataWithContentsOfURL:path] length]/1024.00 /1024.00;
}


#pragma mark 保存视频到相册
- (void)saveVideo:(NSURL *)outputFileURL
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library writeVideoAtPathToSavedPhotosAlbum:outputFileURL completionBlock:^(NSURL *assetURL, NSError *error) {
        if (error) {
          //  NSLog(@"保存视频失败:%@",error);
        } else {
          //  NSLog(@"保存视频到相册成功");
        }
    }];
}

/**
 *  通过视频的URL，获得视频缩略图
 *  @param url 视频URL
 *  @return首帧缩略图
 */
#pragma mark 获取视频的首帧缩略图
- (UIImage *)imageWithVideoURL:(NSURL *)url
{
        // 封装任务
        NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
        AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
        // 根据asset构造一张图
        AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
        // 设定缩略图的方向
        // 如果不设定，可能会在视频旋转90/180/270°时，获取到的缩略图是被旋转过的，而不是正向的（自己的理解）
        generator.appliesPreferredTrackTransform = YES;
        // 设置图片的最大size(分辨率)
        generator.maximumSize = CGSizeMake(600, 450);
        NSError *error = nil;
        // 根据时间，获得第N帧的图片
        // CMTimeMake(a, b)可以理解为获得第a/b秒的frame
        CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10000) actualTime:NULL error:&error];
        UIImage *image = [UIImage imageWithCGImage: img];
        CGImageRelease(img);
    return image;
}


@end
