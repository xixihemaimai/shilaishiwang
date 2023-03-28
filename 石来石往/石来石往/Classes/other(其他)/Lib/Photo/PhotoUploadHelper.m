//
//  PhotoUploadHelper.m
//  RS
//
//  Created by Tony on 12/19/13.
//  Copyright (c) 2013 RS. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import "PhotoUploadHelper.h"
#import "XPhotoUploaderContentEntity.h"

@implementation PhotoUploadHelper

+ (void)checkIfPhotoMetadataComplete:(NSDictionary *)metadata
                       completeBlock:(void (^)())completeBlock
                     inCompleteBlock:(void (^)(NSDictionary *errorInfo))inCompleteBlock
{
 
    NSArray *photoEditSoftwares = @[@"Adobe", @"ACD", @"meitu", @"capture nx"];
    BOOL complete = YES;
    NSDictionary *exifDict = metadata[@"{Exif}"];
    if ([exifDict[@"DateTimeOriginal"] length] == 0)
        complete = NO;
    else if (exifDict[@"FNumber"] == nil)
        complete = NO;
    else {
        NSDictionary *tiffDict = metadata[@"{TIFF}"];
        if ([tiffDict isKindOfClass:[NSDictionary class]]) {
            
            // 经过常见图片编辑软件处理过的图片判定为修改过。
            NSString *software = tiffDict[@"Software"];
            for (NSString *photoEditSoftware in photoEditSoftwares) {
                NSRange rng = [software rangeOfString:photoEditSoftware options:0];
                if (rng.location != NSNotFound) {
                    complete = NO;
                    break;
                }
            }
        }
    }
    
    if (complete) {
        completeBlock();
    } else {
        inCompleteBlock(@{@"msg":@"请选择未经处理的原始图片"});
    }
}

+ (void)processPickedUIImage:(UIImage *)pickedImage
           withMediaMetadata:(NSDictionary *)mediaMetadata
               completeBlock:(void (^)(XPhotoUploaderContentEntity *photo))completeBlock
                 failedBlock:(void (^)(NSDictionary *errorInfo))failedBlock
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        XPhotoUploaderContentEntity *photoEntity = [[XPhotoUploaderContentEntity alloc] initWithImage:pickedImage metaData:mediaMetadata];
        dispatch_async(dispatch_get_main_queue(), ^{
            completeBlock(photoEntity);
        });
    });
}

+ (void)writeImageToSavedPhotosAlbum:(NSDictionary *)info
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *photo = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSDictionary *metaData = [info objectForKey:UIImagePickerControllerMediaMetadata];
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library
         writeImageToSavedPhotosAlbum:photo.CGImage
         metadata:metaData completionBlock:^(NSURL *assetURL, NSError *error2) {
             if (error2)
                 NSLog(@"ERROR: the image failed to be written");
             else
                 NSLog(@"PHOTO SAVED - assetURL: %@", assetURL);
         }];
    });
}

#pragma mark - Image scale utility
+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage
{
    const CGFloat kMaxWidth = SCW * 2;
    if (sourceImage.size.width < kMaxWidth)
        return sourceImage;
    
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = kMaxWidth;
        btWidth = sourceImage.size.width * (kMaxWidth / sourceImage.size.height);
    } else {
        btWidth = kMaxWidth;
        btHeight = sourceImage.size.height * (kMaxWidth / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

+ (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5f;
        else if (widthFactor < heightFactor)
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5f;
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

@end
