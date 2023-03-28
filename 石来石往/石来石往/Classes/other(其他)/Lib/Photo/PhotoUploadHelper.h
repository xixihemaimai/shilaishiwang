//
//  PhotoUploadHelper.h
//  RS
//
//  Created by Tony on 12/19/13.
//  Copyright (c) 2013 RS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XPhotoUploaderContentEntity;
@interface PhotoUploadHelper : NSObject

+ (void)checkIfPhotoMetadataComplete:(NSDictionary *)metadata
                       completeBlock:(void (^)())completeBlock
                     inCompleteBlock:(void (^)(NSDictionary *errorInfo))inCompleteBlock;

+ (void)processPickedUIImage:(UIImage *)pickedImage
           withMediaMetadata:(NSDictionary *)mediaMetadata
               completeBlock:(void (^)(XPhotoUploaderContentEntity *photo))completeBlock
                 failedBlock:(void (^)(NSDictionary *errorInfo))failedBlock;

+ (void)writeImageToSavedPhotosAlbum:(NSDictionary *)imagePickinfo;

+ (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage;

+ (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize;

@end
