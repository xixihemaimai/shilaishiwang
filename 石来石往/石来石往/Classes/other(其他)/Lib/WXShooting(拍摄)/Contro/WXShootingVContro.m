//
//  WXShootingVContro.m
//  WeChart
//
//  Created by lk06 on 2018/4/26.
//  Copyright © 2018年 lk06. All rights reserved.
//

#import "WXShootingVContro.h"
#import "ShootingToolBar.h"
//#import "WXPlayerContro.h"
#import "RSCustomView.h"

//#import "VideoEditViewController.h"

//#import "RSColorViewController.h"


#import "RSVideoServer.h"

typedef void(^PropertyChangeBlock)(AVCaptureDevice *captureDevice);
//,VideoEditViewControllerDelegate
@interface WXShootingVContro ()<shootingToolBarDelegate,AVCaptureFileOutputRecordingDelegate,RSCustomViewDelegate>{
    
    
    /**中间值URL*/
    NSURL                * tempUrl;
}
//拍摄条
@property (nonatomic , strong) ShootingToolBar * toolBar;
//播放VC
//@property (nonatomic , strong) WXPlayerContro * palyerVc;
//显示视频的内容
@property (nonatomic , strong) UIView * userCamera;
//负责输入和输出设置之间的数据传递
@property (strong,nonatomic)   AVCaptureSession *captureSession;
//负责从AVCaptureDevice获得输入数据
@property (strong,nonatomic)   AVCaptureDeviceInput *captureDeviceInput;
//照片输出流
@property (strong,nonatomic)   AVCaptureStillImageOutput *captureStillImageOutput;
//视频输出流
@property (strong,nonatomic)   AVCaptureMovieFileOutput *captureMovieFileOutput;
//相机拍摄预览图层
@property (strong,nonatomic)   AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
//后台任务标示符
@property (nonatomic, assign)  UIBackgroundTaskIdentifier backgroundTaskIdentifier;
//保存的Url
//@property (nonatomic, strong)  NSURL * localMovieUrl;
//拍照的照片
@property (nonatomic, strong)  UIImage * image;

@property (nonatomic,strong)RSCustomView * customView;
/// 负责从AVCaptureDevice获得音频输入流
@property (nonatomic, strong) AVCaptureDeviceInput *audioCaptureDeviceInput;
/**AVCaptureDeviceFormat：输入设备的一些设置，可以用来修改一些设置，如ISO，慢动作，防抖等*/
@property (nonatomic, strong) AVCaptureDeviceFormat *defaultFormat;


@property (nonatomic) CMTime defaultMinFrameDuration;
@property (nonatomic) CMTime defaultMaxFrameDuration;


//保存的Url
@property (nonatomic, strong)NSURL * outputFileURL;

/**聚焦光标*/
@property (nonatomic, strong)UIImageView *focusCursor;


@end

@implementation WXShootingVContro
- (UIImageView *)focusCursor{
    
    if (!_focusCursor) {
        _focusCursor = [[UIImageView alloc]init];
        _focusCursor.image = [UIImage imageNamed:@"扫描"];
    }
    return _focusCursor;
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //self.navigationController.navigationBar.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDeviceOrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    [self setNewOrientation:YES];
    [self seingUI];
    [self startRecordVideo];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = 1;
    [self setupSubViews];

   
}

/**
 设置子控件
 */
-(void)setupSubViews
{
    [self.view addSubview:self.userCamera];
    [self.view addSubview:self.toolBar];
   // [self addChildViewController:self.palyerVc];
    [self.view addSubview:self.customView];
    [self.view addSubview:self.focusCursor];
    
    
    self.userCamera.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0);
    
    self.customView.sd_layout
    .rightSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0)
    .widthIs(80)
    .heightIs(80);
    
    
    self.focusCursor.sd_layout
    .centerXEqualToView(self.view)
    .centerYEqualToView(self.view)
    .widthIs(80)
    .heightIs(80);
    
    self.toolBar.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .heightIs(200);
    
    
    
}

- (void)setNewOrientation:(BOOL)fullscreen{
    if (fullscreen) {
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }else{
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }
}


- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation{
    
    // AVCaptureConnection *captureConnection=[self.captureVideoPreviewLayer connection];
    // captureConnection.videoOrientation=(AVCaptureVideoOrientation)toInterfaceOrientation;
    
    UIDevice *device = [UIDevice currentDevice] ;
    switch (device.orientation) {
        case UIDeviceOrientationFaceUp:
            //NSLog(@"屏幕朝上平躺");
             self.userCamera.frame = self.view.bounds;
             self.captureVideoPreviewLayer.frame=self.view.bounds;
            break;
        case UIDeviceOrientationFaceDown:
           // NSLog(@"屏幕朝下平躺");
             self.userCamera.frame = self.view.bounds;
             self.captureVideoPreviewLayer.frame=self.view.bounds;
            break;
        case UIDeviceOrientationUnknown:
          //  NSLog(@"未知方向");
            break;
        case UIDeviceOrientationLandscapeLeft:
           // NSLog(@"屏幕向左");
            self.userCamera.frame = self.view.bounds;
            self.captureVideoPreviewLayer.frame=self.view.bounds;
            break;
        case UIDeviceOrientationLandscapeRight:
           // NSLog(@"屏幕向右");
            self.userCamera.frame = self.view.bounds;
            self.captureVideoPreviewLayer.frame=self.view.bounds;
            break;
        case UIDeviceOrientationPortrait:
          //  NSLog(@"屏幕向上");
            self.userCamera.frame = self.view.bounds;
            self.captureVideoPreviewLayer.frame=self.view.bounds;
            break;
        case UIDeviceOrientationPortraitUpsideDown:
          //  NSLog(@"屏幕向下");
            self.userCamera.frame = self.view.bounds;
            self.captureVideoPreviewLayer.frame=self.view.bounds;
            break;
    }
}

- (RSCustomView *)customView{
    if (!_customView) {
        
        _customView = [[RSCustomView alloc]init];
        //WithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80)];
        _customView.delegate = self;
        _customView.backgroundColor = [UIColor clearColor];
        
        
    }
    return _customView;
    
}


- (void)changeQieSheXiangeStatus:(BOOL)isSelect andQieBtn:(UIButton *)qieBtn{
    if (isSelect) {
        //前置摄像头
        [self cameraBackgroundDidClickChangeFront];
    }else{
        //后置摄像头
        [self cameraBackgroundDidClickChangeBack];
    }
}








#pragma mark - 切换到前摄像头
- (void)cameraBackgroundDidClickChangeFront {
    AVCaptureDevice *toChangeDevice;
    AVCaptureDevicePosition toChangePosition = AVCaptureDevicePositionFront;
    toChangeDevice = [self getCameraDeviceWithPosition:toChangePosition];
    AVCaptureDeviceInput *toChangeDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:toChangeDevice error:nil];
    [self addNotificationToCaptureDevice:toChangeDevice];
    [self.captureSession beginConfiguration];
    [self.captureSession removeInput:self.captureDeviceInput];
    if ([self.captureSession canAddInput:toChangeDeviceInput]) {
        [self.captureSession addInput:toChangeDeviceInput];
        self.captureDeviceInput = toChangeDeviceInput;
    }
    [self.captureSession commitConfiguration];
    
}

#pragma mark - 切换到后摄像头
- (void)cameraBackgroundDidClickChangeBack {
    AVCaptureDevice *toChangeDevice;
    AVCaptureDevicePosition toChangePosition = AVCaptureDevicePositionBack;
    toChangeDevice = [self getCameraDeviceWithPosition:toChangePosition];
    AVCaptureDeviceInput *toChangeDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:toChangeDevice error:nil];
    [self addNotificationToCaptureDevice:toChangeDevice];
    [self.captureSession beginConfiguration];
    [self.captureSession removeInput:self.captureDeviceInput];
    if ([self.captureSession canAddInput:toChangeDeviceInput]) {
        [self.captureSession addInput:toChangeDeviceInput];
        self.captureDeviceInput = toChangeDeviceInput;
    }
    [self.captureSession commitConfiguration];
    
}




- (AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition)position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            if ([device supportsAVCaptureSessionPreset:AVCaptureSessionPreset1280x720]) return device;
            return nil;
        }
    }
    return nil;
}






#pragma --------------ShootingToolBar的代理方法-----------------start---
-(void)shooingStart:(ShootingToolBar *)toolBar actionType:(ActionType)type progress:(CGFloat)value
{
//    if (type==Photo) {
//        NSLog(@"拍照开始");
//    }
//    else{
    self.focusCursor.hidden = NO;
       // NSLog(@"视频开始");
        [self startRecordVideo];
   // }
}

-(void)shootingStop:(ShootingToolBar *)toolBar shootingType:(ActionType)type
{
    //取出播放视图
//      WXPlayerContro * vc = self.childViewControllers[0];
//     [self.view insertSubview:vc.view aboveSubview:self.userCamera];
//    if (type == Photo) {
//        NSLog(@"拍照结束");
//        [self takePhoto:vc];
//    }else{
       // NSLog(@"视频结束");
        [self stopRecordVideo];
        // vc.url = self.localMovieUrl;
   // }
}

- (void)shootingToolBarAction:(ShootingToolBar *)toolBar buttonIndex:(NSInteger)index {
    if (index==1) {//重新拍摄
        [self.captureSession startRunning];
         // [self.palyerVc removeSubViews];
         // [self.palyerVc.player pause];
        self.focusCursor.hidden = NO;
    }
    if (index==3) {
        //返回上一个页面
        [self.captureSession stopRunning];
        self.focusCursor.hidden = NO;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    if (index == 4) {
        //保存
    
        //NSLog(@"有没有走保存的方向");
        self.focusCursor.hidden = NO;
        //完成录制之后，要做一个重拍，还有就是保存的按键
        
        
        //这边要做一个添加水印和保存到相册的步骤，获取拿到这个视频的东西，添加到上一个界面的九宫格里面
        
        
        
//        UIBackgroundTaskIdentifier lastBackgroundTaskIdentifier=self.backgroundTaskIdentifier;
//        self.backgroundTaskIdentifier=UIBackgroundTaskInvalid;
//        ALAssetsLibrary *assetsLibrary=[[ALAssetsLibrary alloc]init];
//        [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:self.outputFileURL completionBlock:^(NSURL *assetURL, NSError *error) {
//            if (error) {
//                NSLog(@"保存视频到相簿过程中发生错误，错误信息：%@",error.localizedDescription);
//            }
//            if (lastBackgroundTaskIdentifier!=UIBackgroundTaskInvalid) {
//                [[UIApplication sharedApplication] endBackgroundTask:lastBackgroundTaskIdentifier];
//            }
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }];
        
        
        NSDateFormatter* formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyyMMddHHmmss"];
        NSString *randomName = [formater stringFromDate:[NSDate date]];
        
        PHAsset *myAsset = [[PHAsset alloc]init];
        RSWeakself
        NSString * type = @"2";
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        [[PHImageManager defaultManager] requestAVAssetForVideo:myAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
            NSURL *fileRUL = self.outputFileURL;
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
        
        
        
    }else if (index == 2){
        
        self.focusCursor.hidden = YES;
        [self.captureSession stopRunning];
        
    }
}




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
       // NSLog(@"找不到文件");
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
        
        if ([self.delegate respondsToSelector:@selector(sendUrl:)]) {
            [self.delegate sendUrl:url];
        }
          [weakSelf dismissViewControllerAnimated:YES completion:nil];
        
//        [_imageArray addObject:url];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [weakSelf nineGrid];
//        });
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
            
            if ([self.delegate respondsToSelector:@selector(sendUrl:)]) {
                [self.delegate sendUrl:URL];
            }
              [weakSelf dismissViewControllerAnimated:YES completion:nil];
//            [_imageArray addObject:url];
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakSelf nineGrid];
//            });
        }]];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            alertController.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:alertController animated:YES completion:nil];
    }else if(sizemb > 25){
        message = [NSString stringWithFormat:@"视频%@，超过25MB，不能上传，抱歉.", sizeString];
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                                  message: message
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        
        
        
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [[NSFileManager defaultManager] removeItemAtPath:[URL path] error:nil];//取消之后就删除，以免占用手机硬盘空间（沙盒）
             [weakSelf dismissViewControllerAnimated:YES completion:nil];
            
        }]];
        
        
//        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//            //  RSVideoServer *videoServer = [[RSVideoServer alloc] init];
//            //  UIImage * image = [videoServer imageWithVideoURL:URL];
//            NSURL * url = URL;
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



#pragma mark ----------------ShootingToolBar-----------------------end---


#pragma mark ------AVCaptureFileOutputRecordingDelegate 实现代理-------statr------
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didStartRecordingToOutputFileAtURL:(NSURL *)fileURL fromConnections:(NSArray *)connections
{
    //NSLog(@"开始录制");
    
    //后面俩句话是对点击录像没有出现拍摄画面的处理
    self.userCamera.frame = self.view.bounds;
    self.captureVideoPreviewLayer.frame=self.view.bounds;
    
}

-(void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error
{
    self.focusCursor.hidden = YES;
   // NSLog(@"完成录制");
    self.outputFileURL = outputFileURL;
}
#pragma mark ------AVCaptureFileOutputRecordingDelegate 实现代理-------end------
/**
 用来显示录像内容
 
 @return UIView
 */
-(UIView*)userCamera
{
    if (!_userCamera) {
        _userCamera = [[UIView alloc]init];
        _userCamera.backgroundColor = [UIColor blackColor];
        
    }
    return _userCamera;
}

-(void)seingUI{
    //初始化会话
    _captureSession=[[AVCaptureSession alloc]init];
    if ([_captureSession canSetSessionPreset:AVCaptureSessionPreset1280x720]) {//设置分辨率
        _captureSession.sessionPreset=AVCaptureSessionPreset1280x720;
    }
    
    //获得输入设备
    AVCaptureDevice *captureDevice=[self getCameraDeviceWithPosition:AVCaptureDevicePositionBack];//取得后置摄像头
    if (!captureDevice) {
       // NSLog(@"取得后置摄像头时出现问题.");
        return;
    }
    
    
    NSError *error=nil;
    //根据输入设备初始化设备输入对象，用于获得输入数据
      _captureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (error) {
       // NSLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
        return;
    }
    
    
    //添加一个音频输入设备
    AVCaptureDevice *audioCaptureDevice= [[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio] firstObject];
    _audioCaptureDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:audioCaptureDevice error:&error];
    if (error) {
       // NSLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
        return;
    }
    
    // 将视频和音频输入添加到AVCaptureSession
    if ([_captureSession canAddInput:_captureDeviceInput] && [_captureSession canAddInput:_audioCaptureDeviceInput]) {
        [_captureSession addInput:_captureDeviceInput];
        [_captureSession addInput:_audioCaptureDeviceInput];
    }
    
    //初始化设备输出对象，用于获得输出数据
    _captureMovieFileOutput=[[AVCaptureMovieFileOutput alloc]init];
    
    //将设备输入添加到会话中
    if ([_captureSession canAddOutput:_captureMovieFileOutput]) {
        [_captureSession addOutput:_captureMovieFileOutput];
        
        AVCaptureConnection *captureConnection=[_captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
        if ([captureDevice.activeFormat isVideoStabilizationModeSupported:AVCaptureVideoStabilizationModeCinematic]) {
            captureConnection.preferredVideoStabilizationMode=AVCaptureVideoStabilizationModeAuto;
        }
    }
    
    //    //将设备输出添加到会话中
    //    if ([_captureSession canAddOutput:_captureMovieFileOutput]) {
    //        [_captureSession addOutput:_captureMovieFileOutput];
    //    }
    /*-----------*/
    //照片输出
//         _captureStillImageOutput=[[AVCaptureStillImageOutput alloc]init];
//        NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
//        [_captureStillImageOutput setOutputSettings:outputSettings];//输出设置
//        //将设备输出添加到会话中
//        if ([_captureSession canAddOutput:_captureStillImageOutput]) {
//            [_captureSession addOutput:_captureStillImageOutput];
//        }
    /*-----------*/
    
    // 保存默认的AVCaptureDeviceFormat
    _defaultFormat = captureDevice.activeFormat;
    _defaultMinFrameDuration = captureDevice.activeVideoMinFrameDuration;
    _defaultMaxFrameDuration = captureDevice.activeVideoMaxFrameDuration;
    
    //创建视频预览层，用于实时展示摄像头状态
    _captureVideoPreviewLayer=[[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    
    CALayer *layer=self.userCamera.layer;
    layer.masksToBounds=YES;
    
    
    _captureVideoPreviewLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;//填充模式
    _captureVideoPreviewLayer.frame=layer.bounds;
    //将视频预览层添加到界面中
    //[layer addSublayer:_captureVideoPreviewLayer];
    [layer insertSublayer:_captureVideoPreviewLayer below:self.focusCursor.layer];
    
    //AVCaptureDevice
    [self addNotificationToCaptureDevice:captureDevice];
    [self addGenstureRecognizer];
    
}


#pragma mark - 通知
/**
 *  给输入设备添加通知
 */
-(void)addNotificationToCaptureDevice:(AVCaptureDevice *)captureDevice{
    //注意添加区域改变捕获通知必须首先设置设备允许捕获
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        captureDevice.subjectAreaChangeMonitoringEnabled=YES;
    }];
    NSNotificationCenter *notificationCenter= [NSNotificationCenter defaultCenter];
    //捕获区域发生改变
    [notificationCenter addObserver:self selector:@selector(areaChange:) name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
}

/**
 *  捕获区域改变
 *
 *  @param notification 通知对象
 */
-(void)areaChange:(NSNotification *)notification{
    NSLog(@"捕获区域改变...");
}



/**
 *  添加点按手势，点按时聚焦
 */
-(void)addGenstureRecognizer{
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapScreen:)];
    [self.view addGestureRecognizer:tapGesture];
}
-(void)tapScreen:(UITapGestureRecognizer *)tapGesture{
    CGPoint point= [tapGesture locationInView:self.view];
    //将UI坐标转化为摄像头坐标
    CGPoint cameraPoint= [self.captureVideoPreviewLayer captureDevicePointOfInterestForPoint:point];
    [self setFocusCursorWithPoint:point];
    [self focusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
}

/**
 *  设置聚焦光标位置
 *
 *  @param point 光标位置
 */
-(void)setFocusCursorWithPoint:(CGPoint)point{
    self.focusCursor.center=point;
    self.focusCursor.transform=CGAffineTransformMakeScale(1.5, 1.5);
    self.focusCursor.alpha=1.0;
    [UIView animateWithDuration:1.0 animations:^{
        self.focusCursor.transform=CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.focusCursor.alpha=0;
        
    }];
}

/**
 *  设置聚焦点
 *
 *  @param point 聚焦点
 */
-(void)focusWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isFocusModeSupported:focusMode]) {
            [captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        if ([captureDevice isFocusPointOfInterestSupported]) {
            [captureDevice setFocusPointOfInterest:point];
        }
        if ([captureDevice isExposureModeSupported:exposureMode]) {
            [captureDevice setExposureMode:AVCaptureExposureModeAutoExpose];
        }
        if ([captureDevice isExposurePointOfInterestSupported]) {
            [captureDevice setExposurePointOfInterest:point];
        }
    }];
}

/**
 *  改变设备属性的统一操作方法
 *
 *  @param propertyChange 属性改变操作
 */
-(void)changeDeviceProperty:(PropertyChangeBlock)propertyChange{
    AVCaptureDevice *captureDevice= [self.captureDeviceInput device];
    NSError *error;
    //注意改变设备属性前一定要首先调用lockForConfiguration:调用完之后使用unlockForConfiguration方法解锁
    if ([captureDevice lockForConfiguration:&error]) {
        propertyChange(captureDevice);
        [captureDevice unlockForConfiguration];
    }else{
      //  NSLog(@"设置设备属性过程发生错误，错误信息：%@",error.localizedDescription);
    }
}
/**
 *  设置聚焦模式
 *
 *  @param focusMode 聚焦模式
 */
-(void)setFocusMode:(AVCaptureFocusMode )focusMode{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isFocusModeSupported:focusMode]) {
            [captureDevice setFocusMode:focusMode];
        }
    }];
}

/**
 *  设置曝光模式
 *
 *  @param exposureMode 曝光模式
 */
-(void)setExposureMode:(AVCaptureExposureMode)exposureMode{
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isExposureModeSupported:exposureMode]) {
            [captureDevice setExposureMode:exposureMode];
        }
    }];
}


-(void)removeNotificationFromCaptureDevice:(AVCaptureDevice *)captureDevice{
    NSNotificationCenter *notificationCenter= [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
}


/**
 *  取得指定位置的摄像头
 *
 *  @param position 摄像头位置
 *
 *  @return 摄像头设备
 */
//-(AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition )position{
//    [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    AVCaptureDevice * camera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    return camera;
//}

// 准备录制视频
- (void)startRecordVideo
{
    
    AVCaptureConnection *connection = [self.captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    
    if (![self.captureSession isRunning]) {
        //如果捕获会话没有运行
        
        [self.captureSession startRunning];
        
    }
    
    //根据连接取得设备输出的数据
    
    if (![self.captureMovieFileOutput isRecording]) {
        //如果输出 没有录制
        
        //如果支持多任务则则开始多任务
        
        if ([[UIDevice currentDevice] isMultitaskingSupported]) {
            
            self.backgroundTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
            [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
        }
        
        //预览图层和视频方向保持一致
        connection.videoOrientation = [self.captureVideoPreviewLayer connection].videoOrientation;
        if (connection.active) {
            //开始录制视频使用到了代理 AVCaptureFileOutputRecordingDelegate 同时还有录制视频保存的文件地址的
            
            //  NSString * outputPath  = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"dafei-%@.mp4",self.videoName]];
            NSString *outputFielPath=[NSTemporaryDirectory() stringByAppendingString:@"myMovie.mov"];
           // NSLog(@"save path is :%@",outputFielPath);
            NSURL *fileUrl=[NSURL fileURLWithPath:outputFielPath];
            [self.captureMovieFileOutput startRecordingToOutputFileURL:fileUrl recordingDelegate:self];
            
        }else{
        }
    }
}

//停止录制
-(void)stopRecordVideo
{
    if ([self.captureMovieFileOutput isRecording]) {
        
        [self.captureMovieFileOutput stopRecording];
        
    }//把捕获会话也停止的话，预览视图就停了
    
    if ([self.captureSession isRunning]) {
        
        [self.captureSession stopRunning];
    }
}

//开始拍照
//-(void)takePhoto:(WXPlayerContro*)vc
//{
//    //根据设备输出获得连接
//    AVCaptureConnection *captureConnection=[self.captureStillImageOutput connectionWithMediaType:AVMediaTypeVideo];
//
//    //根据连接取得设备输出的数据
//    [self.captureStillImageOutput captureStillImageAsynchronouslyFromConnection:captureConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
//        if (imageDataSampleBuffer) {
//
//            NSData *imageData=[AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
//            UIImage *image=[UIImage imageWithData:imageData];
//            vc.image = image;
            //是否是自拍的情况下，如果是话镜像进行调换。
//            if (_isFront)
//            {
//                resultImage = [UIImage imageWithCGImage:image.CGImage scale:1.0 orientation:UIImageOrientationLeftMirrored];
//
//            }else{
//                resultImage=image;
//            }
//            [self presentImg:resultImage video:nil];
//
//        }
//
//    }];
//}


#pragma mark 设置视频保存地址
//- (NSURL *)localMovieUrl
//{
//    if (_localMovieUrl == nil) {
//        //一个临时的地址   如果使用NSUserDefault 存储的话，重启app还是能够播放
//        NSString *outputFilePath=[NSTemporaryDirectory() stringByAppendingString:@"ui"];
//
//        NSURL *fileUrl=[NSURL fileURLWithPath:outputFilePath];
//
//
//        _localMovieUrl = fileUrl;
//    }
//
//    return _localMovieUrl;
//
//}

/**
 拍摄工具条
 
 @return ShootingToolBar
 */
-(ShootingToolBar*)toolBar
{
    if (!_toolBar) {
        //WithFrame:CGRectMake(0, HEIGHT_SCREEN-200-BottomYFit, self.view.frame.size.width, 200)
        _toolBar = [[ShootingToolBar alloc]init];
        _toolBar.shootingToolBarDelegate = self;
        _toolBar.backgroundColor = [UIColor clearColor];
    }
    return _toolBar;
}

//FIXME:编辑视频
- (void)videoUrlPath{
    [SVProgressHUD showInfoWithStatus:@"等待后续的开发....."];
    [self.toolBar buttonAnimation:NO];
    [self.toolBar showExpression:NO];
    //VideoEditViewController * videoeditVc = [[VideoEditViewController alloc]init];
    //videoeditVc.outputFileURL = self.outputFileURL;
    //videoeditVc.delegate = self;
    //[self.navigationController pushViewController:videoeditVc animated:YES];
    //[self presentViewController:videoeditVc animated:YES completion:nil];

}

//FIXME:添加其他功能
- (void)videoOtherFunction{
    [SVProgressHUD showInfoWithStatus:@"等待后续的开发....."];
    [self.toolBar buttonAnimation:NO];
    [self.toolBar showExpression:NO];
    
   // RSColorViewController * colorVc = [[RSColorViewController alloc]init];
   // colorVc.outputFileURL = self.outputFileURL;
    //[self presentViewController:colorVc animated:YES completion:nil];
    //__weak typeof(self) weakSelf = self;
//    colorVc.block = ^(NSInteger index) {
//        if (index == 1) {
//
//         //这边要重新显示拍摄的按键，和隐藏底下俩个文字的显示
//            [weakSelf.toolBar buttonAnimation:NO];
//            [weakSelf.toolBar showExpression:NO];
//
//
//        }
//    };
}



- (void)reVideo{
    [self.toolBar buttonAnimation:NO];
    [self.toolBar showExpression:NO];
}



- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;  //支持横向
}

//设置为允许旋转
- (BOOL) shouldAutorotate {
    return YES;
}





/**
 展示Vc
 
 @return WXPlayerContro
 */
//-(WXPlayerContro*)palyerVc
//{
//    if (!_palyerVc) {
//        _palyerVc = [[WXPlayerContro alloc]init];
//    }
//    return _palyerVc;
//}
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.captureSession stopRunning];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self setNewOrientation:YES];
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = 0;
}


@end
