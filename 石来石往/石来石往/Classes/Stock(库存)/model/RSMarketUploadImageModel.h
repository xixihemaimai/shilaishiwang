//
//  RSMarketUploadImageModel.h
//  石来石往
//
//  Created by mac on 2022/9/16.
//  Copyright © 2022 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSMarketUploadImageModel : NSObject

@property (nonatomic,copy)NSString * uploadImageId;

@property (nonatomic,copy)NSString * fileName;

@property (nonatomic,copy)NSString * path;

@property (nonatomic,copy)NSString * url;

@property (nonatomic,copy)NSString * urlOrigin;

@property (nonatomic,copy)NSString * fileType;

@property (nonatomic,copy)NSString * remark;


@property (nonatomic,assign)CGFloat fileSize;

@property (nonatomic,assign)NSInteger status;

@property (nonatomic,assign)NSInteger operatorId;



@end

NS_ASSUME_NONNULL_END
