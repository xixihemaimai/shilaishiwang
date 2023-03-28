//
//  RSSelectNeedImageTool.h
//  石来石往
//
//  Created by mac on 2018/12/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPhotoUploaderContentEntity.h"
#import "PhotoUploadHelper.h"
NS_ASSUME_NONNULL_BEGIN



typedef void(^ReturnData) (XPhotoUploaderContentEntity * photoEntityWillUpload);
@interface RSSelectNeedImageTool : NSObject
{
    XPhotoUploaderContentEntity  *_photoEntityWillUpload;
}

@property (nonatomic,strong)ReturnData returnData;


- (void)openPhotoAlbumAndOpenCameraViewController:(UIViewController *)showController;



//打开系统的相机
- (void)openCameraViewController:(UIViewController *)showController;

//使用系统的方式打开相册
- (void)openPhotoAlbumViewController:(UIViewController *)showController;


@end

NS_ASSUME_NONNULL_END
