//
//  RSSelectNeedImageTool.m
//  石来石往
//
//  Created by mac on 2018/12/6.
//  Copyright © 2018年 mac. All rights reserved.
//
#import <MobileCoreServices/MobileCoreServices.h>
#import "RSSelectNeedImageTool.h"

#import "RSPersonSettingViewController.h"

@interface RSSelectNeedImageTool()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,weak)UIViewController * viewController;

@end


@implementation RSSelectNeedImageTool

- (void)openPhotoAlbumAndOpenCameraViewController:(UIViewController *)showController{
    _viewController = showController;
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开系统相机
        [self openCameraViewController:showController];
    }];
    [alert addAction:action1];
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开系统相册
        [self openPhotoAlbumViewController:showController];
    }];
    [alert addAction:action2];
    UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //这边去取消操作
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:action3];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        
        alert.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [showController presentViewController:alert animated:YES completion:nil];
    
}



#pragma mark -- 使用系统的方式打开相册
- (void)openPhotoAlbumViewController:(UIViewController *)showController{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
           
           picker.modalPresentationStyle = UIModalPresentationFullScreen;
       }
    [showController presentViewController:picker animated:YES completion:nil];
}

#pragma mark -- 使用系统的方式打开相机
- (void)openCameraViewController:(UIViewController *)showController{
    //调用系统的相机的功能
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //先检查相机可用是否
        BOOL cameraIsAvailable = [self checkCamera];
        if (YES == cameraIsAvailable) {
            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                
                picker.modalPresentationStyle = UIModalPresentationFullScreen;
            }
            [showController presentViewController:picker animated:YES completion:nil];
            
        }else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在iPhone的“设置-隐私-相机”选项中，允许本应用程序访问你的相机。" delegate:self cancelButtonTitle:@"好，我知道了" otherButtonTitles:nil];
            [alert show];
        }
    }
}







#pragma mark -- 当用户取消调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark -- 检查相机是否可用
- (BOOL)checkCamera
{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(AVAuthorizationStatusRestricted == authStatus ||
       AVAuthorizationStatusDenied == authStatus)
    {
        //相机不可用
        return NO;
    }
    //相机可用
    return YES;
}

#pragma mark -- 对图片进行压缩
- (UIImage *)scaleToSize:(UIImage *)img {
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    CGSize size = CGSizeMake(img.size.width*0.65, img.size.height*0.65);
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}



#pragma mark -- 当用户选取完成后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
        
        UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSDictionary *mediaMetadata = [info objectForKey:UIImagePickerControllerMediaMetadata];
        if (mediaMetadata)
        {
            
        } else {
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            __block NSDictionary *blockMediaMetadata = mediaMetadata;
            __block UIImage *blockImage = pickedImage;
            [library
             assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
             resultBlock: ^ (ALAsset *asset) {
                 ALAssetRepresentation *representation = [asset defaultRepresentation];
                 blockMediaMetadata = [representation metadata];
                 [picker dismissViewControllerAnimated:YES completion:nil];
                 [self processingPickedImage:blockImage mediaMetadata:blockMediaMetadata];
             }
             failureBlock: ^ (NSError *error) {
                 
             }];
        }
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        {
            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
            __block NSDictionary *blockMediaMetadata = mediaMetadata;
            __block UIImage *blockImage = pickedImage;
            [library
             assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
             resultBlock: ^ (ALAsset *asset) {
                 ALAssetRepresentation *representation = [asset defaultRepresentation];
                 blockMediaMetadata = [representation metadata];
                 [picker dismissViewControllerAnimated:YES completion:nil];
                 [self processingPickedImage:blockImage mediaMetadata:blockMediaMetadata];
             }
             failureBlock: ^ (NSError *error) {
             }];
            [picker dismissViewControllerAnimated:YES completion:nil];
        } else {
            
        }
    }
}

- (void)processingPickedImage:(UIImage *)pickedImage mediaMetadata:(NSDictionary *)mediaMetadata
{
 
    RSWeakself
    [PhotoUploadHelper
     processPickedUIImage:[self scaleToSize:pickedImage ]
     withMediaMetadata:mediaMetadata
     completeBlock:^(XPhotoUploaderContentEntity *photo) {
         _photoEntityWillUpload = photo;
       //  [weakSelf uploadUserHead];
         if (weakSelf.returnData) {
            weakSelf.returnData(_photoEntityWillUpload);
         }
       
         
     }
     failedBlock:^(NSDictionary *errorInfo) {
         
     }];
}




@end
