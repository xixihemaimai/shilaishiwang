
//
//  RSMyPublishViewController.m
//  石来石往
//
//  Created by mac on 2017/8/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RSMyPublishViewController.h"

//#import "ZYQAssetPickerController.h"



//#import <AssetsLibrary/AssetsLibrary.h>
//#import <Photos/Photos.h>
#import "PhotoUploadHelper.h"
#import <HUPhotoBrowser.h>
//ZYQAssetPickerControllerDelegate

#import "RSVideoServer.h"



#import "WXShootingVContro.h"

//,UIImagePickerControllerDelegate,UINavigationControllerDelegate
@interface RSMyPublishViewController ()<TZImagePickerControllerDelegate,UITextViewDelegate,WXShootingVControDelegate>

{
    UIView               *_editv;
    UITextView           *_textView;
    UILabel              *_placeholderLabel;
    UIButton             *_addPic;
    NSMutableArray       *_imageArray;
    UIView               * _midview;
    UITextView           * _secondtextView;
    UILabel              * _secondPlaceholderLabel;
    UIView               * _secondMidView;
  
    /**临时数据*/
    NSString             * _StempStr;
    
    
    /**第二个_secondtextView的值*/
    NSString             * _secondTempStr;
    
    
    
    /**判断是选择图片还是视频*/
    NSString             * selectStyle; //0视频和图片都可以选择，1是图片可以选择(视频不能选择) 2是视频可以选择(图片不可以选择) 3是拍摄视频
    
    
    /**中间值URL*/
    NSURL                * tempUrl;
  
}

/** 视频播放控制器 */
@property (nonatomic,strong) AVPlayerViewController *playerVc;



@end

@implementation RSMyPublishViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//    self.tabBarController.tabBar.hidden = YES;
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:[UserManger Verifykey] andViewController:self];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"f9f9f9"];
    
    selectStyle = @"1";
    tempUrl = nil;
    
    self.title = @"发布商圈";
    
    [self addCustomNavigation];
    
    _imageArray = [NSMutableArray array];
    
    // 评论 + 照片
    _editv = [[UIView alloc] init];
    _editv.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_editv];
    
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 11.0) {
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _editv.frame = CGRectMake(0, 0, SCW, 0);
//    _secondtextView = [[UITextView alloc] initWithFrame:CGRectMake(0,15 , SCW - 40, 50)];
//    _secondtextView.backgroundColor = [UIColor whiteColor];
  //  _secondtextView.layer.borderWidth = 1;
   // _secondtextView.layer.borderColor = [UIColor colorWithHexColorStr:@"#f0f0f0"].CGColor;
   // _secondtextView.layer.cornerRadius = 4;
 //   _secondtextView.layer.masksToBounds = YES;
//    _secondtextView.delegate = self;
//    [_editv addSubview:_secondtextView];
//
//
//
//    _secondPlaceholderLabel = [[UILabel alloc] init];
//    _secondPlaceholderLabel.frame =CGRectMake(12, 6, CGRectGetWidth(_secondtextView.frame), 20);
//    _secondPlaceholderLabel.text = @"请输入主题...........";
//    _secondPlaceholderLabel.textColor = [UIColor colorWithWhite:0.4 alpha:0.6];
//    _secondPlaceholderLabel.font = [UIFont systemFontOfSize:15];
//    _secondPlaceholderLabel.enabled = NO; // lable必须设置为不可用
//    _secondPlaceholderLabel.backgroundColor = [UIColor clearColor];
//    [_secondtextView addSubview:_secondPlaceholderLabel];
    
 
//    UIView * midview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_secondtextView.frame)+10, SCW, 20)];
//    midview.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8F8"];
//    [_editv addSubview:midview];
//    _midview = midview;
    
    // 评论 UITextView
    
    //CGRectGetMaxY(_midview.frame)+10
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0,15,SCW - 40,100)];
    _textView.backgroundColor = [UIColor whiteColor];
   // _textView.layer.borderWidth = 1;
  //  _textView.layer.borderColor = [UIColor colorWithHexColorStr:@"#f0f0f0"].CGColor;
  //  _textView.layer.cornerRadius = 4;
  //  _textView.layer.masksToBounds = YES;
    _textView.delegate = self;
    [_editv addSubview:_textView];
    
    // 提示字
    _placeholderLabel = [[UILabel alloc] init];
    _placeholderLabel.frame =CGRectMake(12, 6, CGRectGetWidth(_textView.frame), 20);
    _placeholderLabel.text = @"请输入心情文字(字数500以内)........";
    _placeholderLabel.textColor = [UIColor colorWithWhite:0.4 alpha:0.6];
    _placeholderLabel.font = [UIFont systemFontOfSize:18];
    _placeholderLabel.enabled = NO; // lable必须设置为不可用
    _placeholderLabel.backgroundColor = [UIColor clearColor];
    [_textView addSubview:_placeholderLabel];
    
    
    
    
    UIView * secondmidview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_textView.frame)+10, SCW, 0)];
    secondmidview.backgroundColor = [UIColor colorWithHexColorStr:@"#F8F8F8"];
    [_editv addSubview:secondmidview];
    _secondMidView = secondmidview;
    
    

    // + pic
    _addPic = [UIButton buttonWithType:UIButtonTypeCustom];
    _addPic.frame = CGRectMake(12, CGRectGetMaxY(_secondMidView.frame)+10, 70, 70);
    [_addPic setImage:[UIImage imageNamed:@"AlbumAddBtn"] forState:UIControlStateNormal];
    [_addPic addTarget:self action:@selector(addPicEvent) forControlEvents:UIControlEventTouchUpInside];
    [_editv addSubview:_addPic];
    _editv.frame = CGRectMake(0, 0, SCW, CGRectGetMaxY(_addPic.frame)+20);
    
}

#pragma mark -- 添加自定义导航栏
- (void)addCustomNavigation{
    UIButton * publishBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    [publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    [publishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [publishBtn addTarget:self action:@selector(loadServie:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:publishBtn];
    self.navigationItem.rightBarButtonItem = rightitem;
}

#pragma mark - UIbutton event
- (void)addPicEvent
{
//    if ([selectStyle isEqualToString:@"0"]) {
        //都可以选择
        if (_imageArray.count >= 9) {
            [SVProgressHUD showInfoWithStatus:@"最多提交9张图片"];
        } else {
            RSWeakself
              RSSelectNeedImageTool * selectNeedImageTool = [[RSSelectNeedImageTool alloc]init];
              selectNeedImageTool.returnData = ^(XPhotoUploaderContentEntity * _Nonnull photoEntityWillUpload) {
                _photoEntityWillUpload = photoEntityWillUpload;
                if (_imageArray.count < 9) {
                     selectStyle = @"1";
                    [_imageArray addObject:_photoEntityWillUpload.image];
                    [weakSelf nineGrid];
                }
            };
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
//                if ([selectStyle isEqualToString:@"1"] || [selectStyle isEqualToString:@"0"]) {
                    //打开系统相机
                [selectNeedImageTool openCameraViewController:weakSelf];
                  //  [weakSelf openCamera];
//                }else{
//                    [SVProgressHUD showInfoWithStatus:@"只能选择视频"];
//                }
            }];
            [alert addAction:action1];
            UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                if ([selectStyle isEqualToString:@"1"] || [selectStyle isEqualToString:@"0"]) {
                    //打开系统相册
                    [weakSelf selectPictures];
//                }else{
//                    [SVProgressHUD showInfoWithStatus:@"只能选择视频"];
//                }
            }];
            [alert addAction:action2];
//            UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                //这边去视频操作
//                if ([selectStyle isEqualToString:@"2"] || [selectStyle isEqualToString:@"0"]) {
//                    //这边是视频
//                    [weakSelf selectVideo];
//                }else{
//                    [SVProgressHUD showInfoWithStatus:@"只能选择图片"];
//                }
//            }];
//            [alert addAction:action3];
            
            //拍摄视频的按键
            UIAlertAction * action4 = [UIAlertAction actionWithTitle:@"视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //这边拍摄视频操作
//                if ([selectStyle isEqualToString:@"3"] || [selectStyle isEqualToString:@"0"]) {
                    //这边是视频
                   [weakSelf filmingVideo];
//                }else{
//                    [SVProgressHUD showInfoWithStatus:@"只能选择图片"];
//                }
            }];
            [alert addAction:action4];
  
            UIAlertAction * action5 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //这边去取消操作
                [alert dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:action5];
            if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                alert.modalPresentationStyle = UIModalPresentationFullScreen;
            }
            [self presentViewController:alert animated:YES completion:nil];
           
        }
//    }
}

//#pragma mark -- 使用系统的方式打开相机
//- (void)openCamera{
//    //调用系统的相机的功能
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        picker.delegate = self;
//        //设置拍照后的图片可被编辑
//        picker.allowsEditing = YES;
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        //先检查相机可用是否
//        BOOL cameraIsAvailable = [self checkCamera];
//        if (YES == cameraIsAvailable) {
//            [self presentViewController:picker animated:YES completion:nil];
//        }else {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在iPhone的“设置-隐私-相机”选项中，允许本应用程序访问你的相机。" delegate:self cancelButtonTitle:@"好，我知道了" otherButtonTitles:nil];
//            [alert show];
//        }
//    }
//}
//
//#pragma mark -- 检查相机是否可用
//- (BOOL)checkCamera
//{
//    NSString *mediaType = AVMediaTypeVideo;
//    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
//    if(AVAuthorizationStatusRestricted == authStatus ||
//       AVAuthorizationStatusDenied == authStatus)
//    {
//        //相机不可用
//        return NO;
//    }
//    //相机可用
//    return YES;
//}
//
//
//
//#pragma mark -- 当用户选取完成后调用
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
//    if ([mediaType isEqualToString:(NSString*)kUTTypeImage]) {
//
//        UIImage *pickedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
//        NSDictionary *mediaMetadata = [info objectForKey:UIImagePickerControllerMediaMetadata];
//        if (mediaMetadata)
//        {
//
//        } else {
//            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//            __block NSDictionary *blockMediaMetadata = mediaMetadata;
//            __block UIImage *blockImage = pickedImage;
//            [library
//             assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
//             resultBlock: ^ (ALAsset *asset) {
//                 ALAssetRepresentation *representation = [asset defaultRepresentation];
//                 blockMediaMetadata = [representation metadata];
//                 [picker dismissViewControllerAnimated:YES completion:nil];
//                 [self processingPickedImage:blockImage mediaMetadata:blockMediaMetadata];
//             }
//             failureBlock: ^ (NSError *error) {
//
//             }];
//        }
//
//        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
//        {
//            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//            __block NSDictionary *blockMediaMetadata = mediaMetadata;
//            __block UIImage *blockImage = pickedImage;
//            [library
//             assetForURL:[info objectForKey:UIImagePickerControllerReferenceURL]
//             resultBlock: ^ (ALAsset *asset) {
//                 ALAssetRepresentation *representation = [asset defaultRepresentation];
//                 blockMediaMetadata = [representation metadata];
//                 [picker dismissViewControllerAnimated:YES completion:nil];
//                 [self processingPickedImage:blockImage mediaMetadata:blockMediaMetadata];
//             }
//             failureBlock: ^ (NSError *error) {
//
//             }];
//            [picker dismissViewControllerAnimated:YES completion:nil];
//
//        } else {
//
//        }
//    }
//}
//
//
//
//- (void)processingPickedImage:(UIImage *)pickedImage mediaMetadata:(NSDictionary *)mediaMetadata
//{
//    selectStyle = @"1";
//    RSWeakself
//    [PhotoUploadHelper
//     processPickedUIImage:[self scaleToSize:pickedImage ]
//     withMediaMetadata:mediaMetadata
//     completeBlock:^(XPhotoUploaderContentEntity *photo) {
//
//         _photoEntityWillUpload = photo;
//         if (_imageArray.count < 9) {
//             [_imageArray addObject:_photoEntityWillUpload.image];
//             [weakSelf nineGrid];
//         }
//
//     }
//     failedBlock:^(NSDictionary *errorInfo) {
//
//     }];
//}
//
//#pragma mark -- 对图片进行压缩
//- (UIImage *)scaleToSize:(UIImage *)img {
//    // 创建一个bitmap的context
//    // 并把它设置成为当前正在使用的context
//    CGSize size = CGSizeMake(img.size.width*0.65, img.size.height*0.65);
//
//    UIGraphicsBeginImageContext(size);
//    // 绘制改变大小的图片
//    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
//    // 从当前context中创建一个改变大小后的图片
//    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
//    // 使当前的context出堆栈
//    UIGraphicsEndImageContext();
//    //返回新的改变大小后的图片
//    return scaledImage;
//}
//
//


//这边是视频
- (void)selectVideo{
    
    TZImagePickerController * imagePickerVc = [[TZImagePickerController alloc]initWithMaxImagesCount:0 delegate:self];
    imagePickerVc.allowPickingImage = NO;
    imagePickerVc.allowPickingVideo = YES;
    imagePickerVc.allowPickingVideo = YES;
    imagePickerVc.allowTakePicture = NO;
//    imagePickerVc.videoMaximumDuration = 10;
    
    //不显示原图选项
    imagePickerVc.allowPickingOriginalPhoto = NO;
    //按时间排序
    imagePickerVc.sortAscendingByModificationDate = YES;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        
        imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}


- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset{
        selectStyle = @"2";
   // if ([selectStyle isEqualToString:@"2"]) {
        [_imageArray removeAllObjects];
        tempUrl = nil;
        [self nineGrid];
 //   }
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyyMMddHHmmss"];
    NSString *randomName = [formater stringFromDate:[NSDate date]];
    //当然自己的项目不是这样写的，这里为了解释
    //下面本菜鸟遇到的坑-->视频流路径竟然不一样，分iOS 8 以上、以下视频流的获取处理
    PHAsset *myAsset = asset;
    RSWeakself
    NSString * type = @"1";
    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.version = PHImageRequestOptionsVersionCurrent;
    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
    [[PHImageManager defaultManager] requestAVAssetForVideo:myAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
        NSURL *fileRUL = [asset valueForKey:@"URL"];
        RSVideoServer *videoServer = [[RSVideoServer alloc] init];
        [videoServer compressVideo:fileRUL andVideoName:randomName andUserName:self.usermodel.userName andType:type andSave:NO successCompress:^(NSURL * resultUrl) {
            if (resultUrl == nil) {
                //这边是压缩失败的地方,传没有压缩
                [weakSelf alertUploadVideo:fileRUL];
            }else{
                //这边是压缩成功的地方，传压缩
                [weakSelf alertUploadVideo:resultUrl];
            }
        }];
    }];
}


- (void)filmingVideo{
    WXShootingVContro * vc = [[WXShootingVContro alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.usermodel = self.usermodel;
    vc.delegate = self;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:vc animated:YES completion:nil];
    
}


- (CGFloat) getVideoLength:(NSURL *)URL
{
    AVURLAsset *avUrl = [AVURLAsset assetWithURL:URL];
    CMTime time = [avUrl duration];
    int second = ceil(time.value/time.timescale);
    return second;
}//此方法可以获取视频文件的时长。



- (CGFloat) getFileSize:(NSString *)path
{
    //NSLog(@"%@",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    float filesize = -1.0;
    if ([fileManager fileExistsAtPath:path]) {
        NSDictionary *fileDic = [fileManager attributesOfItemAtPath:path error:nil];//获取文件的属性
        unsigned long long size = [[fileDic objectForKey:NSFileSize] longLongValue];
        filesize = 1.0*size/1024;
    }else{
        //NSLog(@"找不到文件");
    }
    return filesize;
}//此方法可以获取文件的大小，返回的是单位是KB。



//提醒文件的大小
-(void)alertUploadVideo:(NSURL*)URL{
    CGFloat size = [self getFileSize:[URL path]];
    NSString *message;
    NSString *sizeString;
    tempUrl = URL;
    RSWeakself
    selectStyle = @"2";
    CGFloat sizemb= size/1024;
    if(size<=1024){
        sizeString = [NSString stringWithFormat:@"%.2fKB",size];
    }else{
        sizeString = [NSString stringWithFormat:@"%.2fMB",sizemb];
    }
    if(sizemb <= 2){
        //[self uploadVideo:URL];
        
        //RSVideoServer *videoServer = [[RSVideoServer alloc] init];
        //UIImage * image = [videoServer imageWithVideoURL:URL];
        NSURL * url = URL;
        [_imageArray addObject:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf nineGrid];
        });
    }
    
    else if(sizemb > 2){
        message = [NSString stringWithFormat:@"视频%@，大于2MB会有点慢，确定上传吗？", sizeString];
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                                  message: message
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
          //  [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshwebpages" object:nil userInfo:nil];
            [[NSFileManager defaultManager] removeItemAtPath:[URL path] error:nil];//取消之后就删除，以免占用手机硬盘空间（沙盒）
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            
           // RSVideoServer *videoServer = [[RSVideoServer alloc] init];
           // UIImage * image = [videoServer imageWithVideoURL:URL];
           // [_imageArray addObject:image];
            
            NSURL * url = URL;
            [_imageArray addObject:url];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf nineGrid];
            });
        }]];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            alertController.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:alertController animated:YES completion:nil];
       
    }else if(sizemb>25){
        message = [NSString stringWithFormat:@"视频%@，超过25MB，不能上传，抱歉.", sizeString];
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                                  message: message
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [[NSFileManager defaultManager] removeItemAtPath:[URL path] error:nil];//取消之后就删除，以免占用手机硬盘空间（沙盒）
            
        }]];
        
        
//        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//          //  RSVideoServer *videoServer = [[RSVideoServer alloc] init];
//          //  UIImage * image = [videoServer imageWithVideoURL:URL];
////             NSURL * url = URL;
////            [_imageArray addObject:url];
////            dispatch_async(dispatch_get_main_queue(), ^{
////                [weakSelf nineGrid];
////            });
//        }]];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            
            alertController.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }
}








// 本地相册选择多张照片
- (void)selectPictures
{
    TZImagePickerController * imagePickerVc = [[TZImagePickerController alloc]initWithMaxImagesCount:9 delegate:self];
    RSWeakself
    imagePickerVc.allowPickingVideo = YES;
    imagePickerVc.allowTakePicture = YES;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
       selectStyle = @"1";

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                                {
                                              for (int i=0; i<photos.count; i++)
                                              {
                                                  // = photos[i]
                                                 // ALAsset *asset = assets[i];
                                                  //UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                                                  if (_imageArray.count < 9) {
                                                      UIImage * tempImg = photos[i];
                                                      [_imageArray addObject:tempImg];
                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                          [weakSelf nineGrid];
                                                      });
                                                      
                                                  }
                                               
                                              }
                                          });
    }];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        
        imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
//    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
//    picker.maximumNumberOfSelection = 9-_imageArray.count;
//    picker.assetsFilter = [ALAssetsFilter allPhotos];
//    picker.showEmptyGroups = NO;
//    picker.delegate = self;
//    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings)
//                              {
//                                  if ([[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo])
//                                  {
//                                      NSTimeInterval duration = [[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
//
//                                      return duration >= 5;
//                                  } else {
//                                      return YES;
//                                  }
//                              }];
//
//    [self presentViewController:picker animated:YES completion:NULL];
}



- (void)sendUrl:(NSURL *)url{
    selectStyle = @"2";
    if ([selectStyle isEqualToString:@"2"]) {
        [_imageArray removeAllObjects];
        tempUrl = nil;
        [self nineGrid];
    }
    [_imageArray addObject:url];
    tempUrl = url;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self nineGrid];
    });
}



// 9宫格图片布局
- (void)nineGrid
{
    //这边要判断是图片还是视频
    if ([selectStyle isEqualToString:@"1"]) {
        //图片
        for (UIImageView *imgv in _editv.subviews)
        {
            if ([imgv isKindOfClass:[UIImageView class]]) {
                [imgv removeFromSuperview];
            }
        }
        CGFloat width = 70;
        CGFloat widthSpace = (SCW - 8*4 - 70*4) / 3.0;
        CGFloat heightSpace = 10;
        NSInteger count = _imageArray.count;
        _imageArray.count > 9 ? (count = 9) : (count = _imageArray.count);
        for (int i=0; i<count; i++)
        {
            UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(20+(width+widthSpace)*(i%4), (i/4)*(width+heightSpace) + CGRectGetMaxY(_secondMidView.frame)+10, width, width)];
            imgv.image = _imageArray[i];
            imgv.userInteractionEnabled = YES;
            [_editv addSubview:imgv];
            //添加手势
            imgv.tag = 10000+i;
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture:)];
            [imgv addGestureRecognizer:tap];
            
            UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
            delete.frame = CGRectMake(width-16, 0, 16, 16);
            //        delete.backgroundColor = [UIColor greenColor];
            [delete setImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateNormal];
            [delete addTarget:self action:@selector(deleteEvent:) forControlEvents:UIControlEventTouchUpInside];
            delete.tag = 10+i;
            [imgv addSubview:delete];
            if (i == _imageArray.count - 1)
            {
                if (_imageArray.count % 4 == 0) {
                    _addPic.frame = CGRectMake(15, CGRectGetMaxY(imgv.frame) + heightSpace, 70, 70);
                } else {
                    _addPic.frame = CGRectMake(CGRectGetMaxX(imgv.frame) + widthSpace, CGRectGetMinY(imgv.frame), 70, 70);
                }
                _editv.frame = CGRectMake(0, 0, SCW, CGRectGetMaxY(_addPic.frame)+20);
                
            }
        }
    }else{
       //视频
        for (UIImageView * imgv in _editv.subviews) {
            if ([imgv isKindOfClass:[UIImageView class]]) {
                [imgv removeFromSuperview];
            }
        }
        CGFloat width = 70;
        CGFloat widthSpace = (SCW - 8*4 - 70*4) / 3.0;
        CGFloat heightSpace = 10;
        NSInteger count = _imageArray.count;
        _imageArray.count > 1 ? (count = 1) : (count = _imageArray.count);
        if (_imageArray.count == 0) {
            _addPic.frame = CGRectMake(15, CGRectGetMaxY(_secondMidView.frame)+10, 70, 70);
            _addPic.hidden = NO;
        }else{
            for (int i=0; i<count; i++)
            {
                RSVideoServer *videoServer = [[RSVideoServer alloc] init];
                UIImage * image = [videoServer imageWithVideoURL:_imageArray[i]];
                UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(20+(width+widthSpace)*(i%4), (i/4)*(width+heightSpace) + CGRectGetMaxY(_secondMidView.frame)+10, width, width)];
                imgv.image = image;
                imgv.userInteractionEnabled = YES;
                [_editv addSubview:imgv];
                
                //添加手势
                //  imgv.tag = 10000+i;
                //            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture:)];
                //            [imgv addGestureRecognizer:tap];
                UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
                
                UIImageView * playerImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, CGRectGetWidth(imgv.frame) - 20, CGRectGetHeight(imgv.frame) - 20)];
                playerImage.image = [UIImage imageNamed:@"播放"];
                [imgv addSubview:playerImage];
                playerImage.userInteractionEnabled = YES;
                
                UITapGestureRecognizer * playTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playerVideoAction:)];
                [playerImage addGestureRecognizer:playTap];
                
                delete.frame = CGRectMake(width-16, 0, 16, 16);
                //        delete.backgroundColor = [UIColor greenColor];
                [delete setImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateNormal];
                [delete addTarget:self action:@selector(deleteEvent:) forControlEvents:UIControlEventTouchUpInside];
                delete.tag = 1000000000 + i;
                [imgv addSubview:delete];
                
                if (i == _imageArray.count - 1)
                {
                    if (_imageArray.count % 4 == 0) {
                        //                    _addPic.frame = CGRectMake(15, CGRectGetMaxY(imgv.frame) + heightSpace, 70, 70);
                        //                    _addPic.hidden = NO;
                    } else {
                        _addPic.frame = CGRectMake(CGRectGetMaxX(imgv.frame) + widthSpace, CGRectGetMinY(imgv.frame), 70, 70);
                        _addPic.hidden = YES;
                    }
                    _editv.frame = CGRectMake(0, 0, SCW, CGRectGetMaxY(_addPic.frame)+20);
                }
            }
        }
    }
}


//播放视频
- (void)playerVideoAction:(UITapGestureRecognizer *)tap{
    NSURL * url = _imageArray[0];
    // 创建视频播放控制器(iOS8.0)
    self.playerVc = [[AVPlayerViewController alloc] init];
    // 创建播放器
    AVPlayer *player = [AVPlayer playerWithURL:url];
    // 给频播放控制器设置播放器
    self.playerVc.player = player;
    [self.playerVc.player play];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        
        self.playerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:self.playerVc animated:YES completion:nil];
    
    
}


// 删除照片
- (void)deleteEvent:(UIButton *)sender
{
    UIButton *btn = (UIButton *)sender;
//    if ([selectStyle isEqualToString:@"0"]) {
//
//
//    }else
    if ([selectStyle isEqualToString:@"1"]) {
        [_imageArray removeObjectAtIndex:btn.tag-10];
    }else{
        tempUrl = nil;
        [_imageArray removeObjectAtIndex:btn.tag - 1000000000];
    }
    [self nineGrid];
    if (_imageArray.count == 0)
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        selectStyle = @"1";
        tempUrl = nil;
        _addPic.frame = CGRectMake(15, CGRectGetMaxY(_secondMidView.frame)+10, 70, 70);
        //_editv.frame = CGRectMake(0, 64, SCW, CGRectGetMaxY(_addPic.frame)+20);
       
            _editv.frame = CGRectMake(0, 0, SCW, CGRectGetMaxY(_addPic.frame)+20);
        
    }
}

//#pragma mark - ZYQAssetPickerController Delegate

//- (void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
//{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
//                   {
//                       for (int i=0; i<assets.count; i++)
//                       {
//                           ALAsset *asset = assets[i];
//                           UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
//                           [_imageArray addObject:tempImg];
//                           dispatch_async(dispatch_get_main_queue(), ^{
//                               [self nineGrid];
//                           });
//                       }
//                   });
//}

#pragma makr - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView == _textView) {
        NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([temp length]!=0) {
            _placeholderLabel.text = @"";
            temp = [self delSpaceAndNewline:temp];
            _StempStr = temp;
        }else{
            _placeholderLabel.text = @"请输入心情文字(字数500以内)........";
            _StempStr = @"";
        }
    }
//    else{
//        NSString *temp = [textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        if ([temp length]!=0) {
//            temp = [self delSpaceAndNewline:temp];
//            _secondTempStr = temp;
//            _secondPlaceholderLabel.text = @"";
//        }else{
//            _secondTempStr = @"";
//            _secondPlaceholderLabel.text = @"请输入主题........";
//        }
//    }
}

- (NSString *)delSpaceAndNewline:(NSString *)string;{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
}

- (void)textViewDidEndEditing:(UITextView *)textView{
}

#pragma mark -- 显示图片浏览器
- (void)showPicture:(UITapGestureRecognizer *)tap{
    [HUPhotoBrowser showFromImageView:tap.view.subviews[tap.view.tag - 10000] withImages:_imageArray atIndex:tap.view.tag-10000];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location < 500)
    {
        if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
            //在这里做你响应return键的代码
            [textView resignFirstResponder];
            return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
        }
        return  YES;
    } else {
        return NO;
    }
}

#pragma mark -- 发表的按键，也是上传服务器
- (void)loadServie:(UIButton *)btn{
     NSString *temp = [_StempStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString * secondTemp = [_secondTempStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    //&& secondTemp.length > 0 && _imageArray.count > 0
    if (temp.length > 0  && temp.length < 500 && _imageArray.count <= 9 ) {
//        if ([selectStyle isEqualToString:@"0"]) {
//            [SVProgressHUD showInfoWithStatus:@"请选择要上传的内容"];
//        }else
        if ([selectStyle isEqualToString:@"1"]) {
            //这边是图片
            //[self loadSuccessArray:_imageArray andText:temp andSecondText:secondTemp];
            if (_imageArray.count < 1) {
                [self loadSuccessArray:_imageArray andText:temp andSecondText:secondTemp andviewType:@"text"];
            }else{
                [self loadSuccessArray:_imageArray andText:temp andSecondText:secondTemp andviewType:@"picture"];
            }
            
        }else{
            //这边是视频
            if (tempUrl != nil) {
                  //[self uploadVideo:tempUrl andText:temp andSecondText:secondTemp];
                //[self loadSuccessArray:_imageArray andText:temp andSecondText:secondTemp andviewType:@"video"];
                 [self uploadVideo:tempUrl andText:temp andSecondText:secondTemp andViewTpye:@"video" andDataArray:_imageArray];

            }else{
                
                [SVProgressHUD showErrorWithStatus:@"没有添加视频进去"];
            }
        }
          btn.enabled = YES;
    }else{
        if (temp.length < 1) {
            btn.enabled = YES;
            [self showAlertPromptingString:@"输入的内容要大于1个字符"];
        }else if (temp.length > 500){
             btn.enabled = YES;
            [self showAlertPromptingString:@"输入的内容不能大于500个字符"];
        }
        
//        else if (_imageArray.count < 1){
//             btn.enabled = YES;
//            [self showAlertPromptingString:@"未上传图片"];
//        }
//
        else if (_imageArray.count > 10){
             btn.enabled = YES;
            [self showAlertPromptingString:@"上传图片只能9张"];
        }
//        else if (secondTemp.length < 1){
//             btn.enabled = YES;
//            [self showAlertPromptingString:@"请输入主题"];
//        }
    }
}

#pragma mark -- RSMyPublishViewControlerDelegate --- 多图上传，还有评论和视频
- (void)loadSuccessArray:(NSMutableArray *)imageArray andText:(NSString *)tempStr andSecondText:(NSString *)secondText andviewType:(NSString *)viewType{
        //发布商圈:  添加类别 viewType     图片传 picture   视频传 video
        [SVProgressHUD showWithStatus:@"正在上传中....."];
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:self.usermodel.userPhone forKey:@"mobilePhone"];
        [dict setObject:[NSString stringWithFormat:@"%@",tempStr] forKey:@"content"];
        [dict setObject:[NSString stringWithFormat:@"%@",secondText] forKey:@"theme"];
        [dict setObject:@"1" forKey:@"erpId"];
        [dict setObject:viewType forKey:@"viewType"];
        [dict setObject:self.tempStr forKey:@"friendType"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        RSWeakself
        NSDictionary *parameters = @{@"key": [NSString get_uuid] , @"Data" : dataStr, @"VerifyKey" : verifykey, @"VerifyCode" : [NSString get_verifyCode],@"erpId":applegate.ERPID};
        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
        [network getMoreImageDataWithUrlString:URL_HEADER_DOUBLEPICTURE withParameters:parameters andDataArray:imageArray withBlock:^(id json, BOOL success) {
            if (success) {
                [SVProgressHUD dismiss];
                weakSelf.navigationItem.rightBarButtonItem.enabled = YES;
                [weakSelf.navigationController popViewControllerAnimated:YES];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshMyFriendData" object:nil];
            }else{
                weakSelf.navigationItem.rightBarButtonItem.enabled = YES;
                [SVProgressHUD showErrorWithStatus:@"上传失败"];
            }
        }];
}

//视频上传
- (void)uploadVideo:(NSURL *)url andText:(NSString *)tempStr andSecondText:(NSString *)secondText andViewTpye:(NSString *)viewType andDataArray:(NSMutableArray *)imageArray{
     [SVProgressHUD showWithStatus:@"正在上传中....."];
    RSVideoServer *videoServer = [[RSVideoServer alloc] init];
    UIImage * image = [videoServer imageWithVideoURL:_imageArray[0]];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    [dict setObject:self.usermodel.userPhone forKey:@"mobilePhone"];
    [dict setObject:[NSString stringWithFormat:@"%@",tempStr] forKey:@"content"];
    [dict setObject:[NSString stringWithFormat:@"%@",secondText] forKey:@"theme"];
    [dict setObject:@"1" forKey:@"erpId"];
    [dict setObject:[NSNumber numberWithDouble:image.size.width] forKey:@"coverWidth"];
    [dict setObject:[NSNumber numberWithDouble:image.size.height] forKey:@"coverHeight"];
    [dict setObject:viewType forKey:@"viewType"];
    [dict setObject:self.tempStr forKey:@"friendType"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    RSWeakself
    NSDictionary *parameters = @{@"key": [NSString get_uuid] , @"Data" : dataStr, @"VerifyKey" : verifykey, @"VerifyCode" : [NSString get_verifyCode],@"erpId":applegate.ERPID};
   // NSString * str = @"http://192.168.1.128:8080/slsw/sendArticle.do";
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getVideoDataWithUrlString:URL_HEADER_DOUBLEPICTURE withParameters:parameters andDataArray:imageArray andUImage:image withBlock:^(id json, BOOL success) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
        weakSelf.navigationItem.rightBarButtonItem.enabled = YES;
        [weakSelf.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshMyFriendData" object:nil];
        }else{
            weakSelf.navigationItem.rightBarButtonItem.enabled = YES;
            [SVProgressHUD showErrorWithStatus:@"上传失败"];
        }
    }];
}


- (void)showAlertPromptingString:(NSString *)alertStr{
    [JHSysAlertUtil presentAlertViewWithTitle:@"温馨提示" message:alertStr confirmTitle:@"确定" handler:^{
    }];
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:alertStr preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction * actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//    [alert addAction:actionConfirm];
//    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
//        alert.modalPresentationStyle = UIModalPresentationFullScreen;
//    }
//    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
