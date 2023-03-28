//
//  XPhotoUploaderContentEntity.m
//  RS
//
//  Created by Tony on 12/13/13.
//  Copyright (c) 2013 RS. All rights reserved.
//

#import <ImageIO/ImageIO.h>
#import "UIImage+Resize.h"
#import "UIImage+AutoRotation.h"
#import "XPhotoUploaderContentEntity.h"

@interface XPhotoUploaderContentEntity ()
{
    __strong UIImage             *_image;
    __strong NSMutableDictionary *_metadata;
}

@end


@implementation XPhotoUploaderContentEntity

- (id)initWithData:(NSData *)inData
{
    if (self = [super init]) {
        _data = inData;
    }
    return self;
}

- (id)initWithImage:(UIImage *)inImage
{
    if (self = [super init]) {
        _image = inImage;
        _data = UIImageJPEGRepresentation(_image, 1.0);
    }
    
    return self;
}

- (id)initWithImage:(UIImage *)inImage metaData:(NSDictionary *)inMetadata
{
    if (self = [super init]) {
        _image = inImage;
        NSMutableDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:inMetadata];
        UIImage *compressedImage = [self compressImageByResize:inImage metaData:metadata];
        NSData *orgData = UIImageJPEGRepresentation(compressedImage, 1.0);
        _data = [self megerImageData:orgData withMetadata:metadata];
    }
    return self;
}

- (UIImage *)image
{
    if (_image == nil)
        _image = [UIImage imageWithData:_data];
    return _image;
}

- (NSMutableDictionary *)metadata
{
    if (_metadata == nil) {
        CGImageSourceRef cfImage = CGImageSourceCreateWithData((__bridge CFDataRef)_data, NULL);
        NSDictionary *metadata = (__bridge_transfer NSDictionary *)CGImageSourceCopyPropertiesAtIndex(cfImage, 0, nil);
        CFRelease(cfImage);
        _metadata = [NSMutableDictionary dictionaryWithDictionary:metadata];
        _metadata[@"{TIFF}"][@"Orientation"] = @(UIImageOrientationUp);
        _metadata[@"Orientation"] = @(UIImageOrientationUp);
    }
    return _metadata;
}

#pragma mark - Private Methods
- (UIImage *)compressImageByResize:(UIImage *)inImage metaData:(NSMutableDictionary *)inMetadata
{
    inMetadata[@"{TIFF}"][@"Orientation"] = @(UIImageOrientationUp);
    inMetadata[@"Orientation"] = @(UIImageOrientationUp);
    
    CGSize orgSize = inImage.size;
    CGSize compressSize;
    CGFloat shortEdge = orgSize.width > orgSize.height ? orgSize.height : orgSize.width;
    CGFloat compressFactor = 1.f;
    if (shortEdge > 1500) {
        compressFactor = shortEdge / 1500;
        compressSize.width = orgSize.width / compressFactor;
        compressSize.height = orgSize.height / compressFactor;
        
        inMetadata[@"PixelHeight"] = @(compressSize.height);
        inMetadata[@"PixelWidth"] = @(compressSize.width);
        inMetadata[@"{Exif}"][@"PixelYDimension"] = @(compressSize.height);
        inMetadata[@"{Exif}"][@"PixelXDimension"] = @(compressSize.width);
        return [[inImage fixOrientation] resizedImage:compressSize interpolationQuality:kCGInterpolationHigh];
    } else {
        return [inImage fixOrientation];
    }
}

- (NSData *)megerImageData:(NSData *)inData withMetadata:(NSDictionary *)inMetadata
{
    if (inMetadata == nil)
        return nil;
    
    CGImageSourceRef img = CGImageSourceCreateWithData((__bridge CFDataRef)inData, NULL);
    if (img == nil) {
        NSLog(@"megerImageData failed, data should be image.");
        return nil;
    }
    
    NSMutableData *imageData = [[NSMutableData alloc] init];
    CGImageDestinationRef dest = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)imageData, CGImageSourceGetType(img), 1, NULL);
    if (dest == nil) {
        NSLog(@"megerImageData failed, create image destination with data return nil");
        CFRelease(img);
        return nil;
    }
    
    CGImageDestinationAddImageFromSource(dest, img, 0, (__bridge CFDictionaryRef)inMetadata);
    CGImageDestinationFinalize(dest);
    CFRelease(img);
    CFRelease(dest);
    return imageData;
}

@end
