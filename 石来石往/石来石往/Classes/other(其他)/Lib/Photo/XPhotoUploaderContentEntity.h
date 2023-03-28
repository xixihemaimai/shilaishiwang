//
//  XPhotoUploaderContentEntity.h
//  RS
//
//  Created by Tony on 12/13/13.
//  Copyright (c) 2013 RS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XPhotoUploaderContentEntity : NSObject

@property (strong, nonatomic)   NSData    *data;
@property (readonly, nonatomic) NSMutableDictionary *metadata;
@property (readonly, nonatomic) UIImage   *image;

- (id)initWithData:(NSData *)data;
- (id)initWithImage:(UIImage *)image;
- (id)initWithImage:(UIImage *)image metaData:(NSDictionary *)metadata;

@end
