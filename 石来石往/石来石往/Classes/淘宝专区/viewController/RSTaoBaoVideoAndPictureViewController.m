//
//  RSTaoBaoVideoAndPictureViewController.m
//  石来石往
//
//  Created by mac on 2019/8/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSTaoBaoVideoAndPictureViewController.h"
#import "RSPublishingProjectCaseFirstButton.h"

#import "WXShootingVContro.h"
#import "RSVideoServer.h"
#import "RSTaobaoVideoAndPictureModel.h"

@interface RSTaoBaoVideoAndPictureViewController ()<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,WXShootingVControDelegate>
{
    
    //视频
    RSPublishingProjectCaseFirstButton * _addVideoBtn;
    //图片
    RSPublishingProjectCaseFirstButton * _addPicBtn;
    
    NSMutableArray       *_imageArray;
    NSMutableArray       *_videoArray;
    
}
@property (nonatomic,strong)UIView * headerView;

@property (nonatomic,strong) UIView * footView;

@property (nonatomic,strong)UITableView * tableview;

/** 视频播放控制器 */
@property (nonatomic,strong) AVPlayerViewController *playerVc;

@property (nonatomic,strong)NSURL * tempVideoUrl;


@end

@implementation RSTaoBaoVideoAndPictureViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"相册";
    self.tempVideoUrl = nil;
    
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentAutomatic];
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    CGFloat Y = 0.0;
    if (iphonex || iPhoneXR || iPhoneXSMax || iPhoneXS) {
        Y = 88;
    }else{
        Y = 64;
    }
    UITableView * tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, Y, SCW, SCH - Y) style:UITableViewStylePlain];
    self.tableview = tableview;
    self.tableview.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.contentInset = UIEdgeInsetsMake(0, 0, 98, 0);
    [self.view addSubview:tableview];
    
    
//    UIButton * saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
//    [saveBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
//    saveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    saveBtn.frame = CGRectMake(0, 0, 50, 50);
//    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
//    self.navigationItem.rightBarButtonItem = item;
    
    
    _imageArray = [NSMutableArray array];
    _videoArray = [NSMutableArray array];
    [self setTableViewCustomHeaderView];
    [self setTableviewCustomFootView];
    
    if (self.taobaoManagementmodel.imageList.count > 0) {
        for (int i = 0; i < self.taobaoManagementmodel.imageList.count; i++) {
              RSTaobaoVideoAndPictureModel * taobaoVideoAndPicturemodel = self.taobaoManagementmodel.imageList[i];
            
             [_imageArray addObject:taobaoVideoAndPicturemodel];
        }
        [self nineGrid];
    }
    
    
    if (self.taobaoManagementmodel.videoAndPicturemodel.videoId != 0) {
        [_videoArray addObject:self.taobaoManagementmodel.videoAndPicturemodel];
        [self nineVideoGrid];
    }
    
  
}



- (void)setTableViewCustomHeaderView{
    //视频
    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 130)];
    headerView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.headerView = headerView;
    
    RSPublishingProjectCaseFirstButton * addVideoBtn = [[RSPublishingProjectCaseFirstButton alloc]initWithFrame:CGRectMake(12, 10,110, 110)];
    [addVideoBtn setImage:[UIImage imageNamed:@"视频"] forState:UIControlStateNormal];
    [addVideoBtn setTitle:@"添加视频" forState:UIControlStateNormal];
    [addVideoBtn addTarget:self action:@selector(addVideoAction:) forControlEvents:UIControlEventTouchUpInside];
    addVideoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    addVideoBtn.layer.cornerRadius = 5;
    [addVideoBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#F9F9F9"]];
    addVideoBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#E8E8E8"].CGColor;
    addVideoBtn.layer.borderWidth = 1;
    [addVideoBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    [headerView addSubview:addVideoBtn];
    _addVideoBtn = addVideoBtn;
    addVideoBtn.imageView.sd_layout
    .widthIs(20)
    .heightIs(17)
    .centerXEqualToView(addVideoBtn)
    .topSpaceToView(addVideoBtn, 20);
    
    [headerView setupAutoHeightWithBottomView:addVideoBtn bottomMargin:10];
    [headerView layoutIfNeeded];
    self.tableview.tableHeaderView = headerView;
}



//添加视频
- (void)addVideoAction:(UIButton *)addVideoBtn{
      // [self filmingVideo];
    [self selectVideo];
}


//这边是视频
- (void)selectVideo{
    if (_videoArray.count < 1) {
        TZImagePickerController * imagePickerVc = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
        imagePickerVc.allowPickingImage = NO;
        imagePickerVc.allowPickingVideo = YES;
        imagePickerVc.allowPickingVideo = true;
        imagePickerVc.allowTakePicture = NO;
//        imagePickerVc.videoMaximumDuration = 100;
        //不显示原图选项
        imagePickerVc.allowPickingOriginalPhoto = NO;
        //按时间排序
        imagePickerVc.sortAscendingByModificationDate = YES;
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:imagePickerVc animated:YES completion:nil];
        
        
    }else{
        [SVProgressHUD showInfoWithStatus:@"视频只允许上传一个"];
    }
}


- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset{
    //selectStyle = @"2";
    // if ([selectStyle isEqualToString:@"2"]) {
    //[_videoArray removeAllObjects];
    //tempUrl = nil;
    //[self nineVideoGrid];
    //   }
    [SVProgressHUD showInfoWithStatus:@"正在上传中........."];
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyyMMddHHmmss"];
    NSString *randomName = [formater stringFromDate:[NSDate date]];
    //当然自己的项目不是这样写的，这里为了解释
    //下面本菜鸟遇到的坑-->视频流路径竟然不一样，分iOS 8 以上、以下视频流的获取处理
    PHAsset *myAsset = asset;
    RSWeakself
    NSString * type = @"3";
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
                [SVProgressHUD dismiss];
            }else{
                //这边是压缩成功的地方，传压缩
                [weakSelf alertUploadVideo:resultUrl];
                [SVProgressHUD dismiss];
            }
        }];
    }];
}




- (void)reloadVideoAndPictureNewData:(NSString *)type andImage:(UIImage *)image{
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    //URL_TAOBAOGETINVENTORYLIST_IOS
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    if ([type isEqualToString:@"picture"]) {
        [phoneDict setObject:@"uploadPic" forKey:@"optType"];
    }else{
        [phoneDict setObject:@"uploadVideo" forKey:@"optType"];
    }
    [phoneDict setObject:self.taobaoManagementmodel.identityId forKey:@"identityId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    
    if ([type isEqualToString:@"picture"]) {
        NSArray *avatarArray = [NSArray arrayWithObject:image];
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        NSData *imageData;
        for (UIImage *avatar in avatarArray)
        {
            imageData = UIImageJPEGRepresentation(avatar, 1);
            [dataArray addObject:imageData];
        }
        [network getImageDataWithUrlString:URL_TAOBAOUPLOADINVENTORYFILES_IOS withParameters:parameters andDataArray:dataArray withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL isresult = [json[@"success"]boolValue];
                if (isresult) {
                    RSTaobaoVideoAndPictureModel * taobaoVideoAndPicturemodel = [[RSTaobaoVideoAndPictureModel alloc]init];
                    taobaoVideoAndPicturemodel.imageId = [json[@"data"][@"imageId"] integerValue];
                    taobaoVideoAndPicturemodel.imageUrl = json[@"data"][@"imageUrl"];
                    taobaoVideoAndPicturemodel.videoId = [json[@"data"][@"videoId"] integerValue];
                    taobaoVideoAndPicturemodel.videoUrl = json[@"data"][@"videoUrl"];
                    [_imageArray addObject:taobaoVideoAndPicturemodel];
                    weakSelf.taobaoManagementmodel.imageList = _imageArray;
                    [weakSelf nineGrid];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"上传图片失败"];
                }
            }else{
                 [SVProgressHUD showErrorWithStatus:@"上传图片失败"];
            }
        }];
    }else{
        RSVideoServer *videoServer = [[RSVideoServer alloc] init];
        UIImage * image = [videoServer imageWithVideoURL:_tempVideoUrl];
        NSMutableArray * array = [NSMutableArray array];
        [array addObject:_tempVideoUrl];
        [network getVideoDataWithUrlString:URL_TAOBAOUPLOADINVENTORYFILES_IOS withParameters:parameters andDataArray:array andUImage:image withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL isresult = [json[@"success"]boolValue];
                if (isresult) {
                    RSTaobaoVideoAndPictureModel * taobaoVideoAndPicturemodel = [[RSTaobaoVideoAndPictureModel alloc]init];
                    taobaoVideoAndPicturemodel.imageId = [json[@"data"][@"imageId"] integerValue];
                    taobaoVideoAndPicturemodel.imageUrl = json[@"data"][@"imageUrl"];
                    taobaoVideoAndPicturemodel.videoId = [json[@"data"][@"videoId"] integerValue];
                    taobaoVideoAndPicturemodel.videoUrl = json[@"data"][@"videoUrl"];
                    weakSelf.taobaoManagementmodel.videoAndPicturemodel = taobaoVideoAndPicturemodel;
                    [_videoArray addObject:taobaoVideoAndPicturemodel];
                    [weakSelf nineVideoGrid];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"上传视频失败"];
                }
            }else{
                [SVProgressHUD showErrorWithStatus:@"上传视频失败"];
            }
        }];
    }
}






- (void)setTableviewCustomFootView{
    //图片
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCW, 130)];
    footView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.footView = footView;
    RSPublishingProjectCaseFirstButton * addPicBtn = [[RSPublishingProjectCaseFirstButton alloc]initWithFrame:CGRectMake(12, 10,110, 110)];
    [addPicBtn setImage:[UIImage imageNamed:@"拍照"] forState:UIControlStateNormal];
    [addPicBtn setTitle:@"添加照片" forState:UIControlStateNormal];
    [addPicBtn addTarget:self action:@selector(addPictureAction:) forControlEvents:UIControlEventTouchUpInside];
    addPicBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    addPicBtn.layer.cornerRadius = 5;
    [addPicBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#F9F9F9"]];
    addPicBtn.layer.borderColor = [UIColor colorWithHexColorStr:@"#E8E8E8"].CGColor;
    addPicBtn.layer.borderWidth = 1;
    [addPicBtn setTitleColor:[UIColor colorWithHexColorStr:@"#666666"] forState:UIControlStateNormal];
    [footView addSubview:addPicBtn];
    addPicBtn.imageView.sd_layout
    .widthIs(20)
    .heightIs(17)
    .centerXEqualToView(addPicBtn)
    .topSpaceToView(addPicBtn, 20);
    
    
    
    _addPicBtn = addPicBtn;
    [footView setupAutoHeightWithBottomView:addPicBtn bottomMargin:10];
    [footView layoutIfNeeded];
    self.tableview.tableFooterView = footView;
}


//添加照片
- (void)addPictureAction:(UIButton *)addPicBtn{
    if (_imageArray.count < 5) {
        RSWeakself
        TZImagePickerController * tzimagepicker = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
        tzimagepicker.allowPickingVideo = false;
        tzimagepicker.allowTakePicture = YES;
        [tzimagepicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                           {
                               for (int i=0; i<photos.count; i++)
                               {
                                   UIImage * tempImg = photos[i];
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       [weakSelf reloadVideoAndPictureNewData:@"picture" andImage:tempImg];
                                   });
                               }
                           });
        }];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
            
            tzimagepicker.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self presentViewController:tzimagepicker animated:YES completion:nil];
        
    }else{
        [SVProgressHUD showInfoWithStatus:@"最多只能上传5张"];
    }
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
   // tempUrl = URL;
    RSWeakself
   // selectStyle = @"2";
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
        _tempVideoUrl = url;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadVideoAndPictureNewData:@"Video" andImage:nil];
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
            _tempVideoUrl = url;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //reloadVideoAndPictureNewData
                
                [self reloadVideoAndPictureNewData:@"Video" andImage:nil];
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


- (void)nineVideoGrid{
    //视频
    for (UIImageView * imgv in self.headerView.subviews) {
        if ([imgv isKindOfClass:[UIImageView class]]) {
            [imgv removeFromSuperview];
        }
    }
    CGFloat width = 110;
    CGFloat height = 110;
    CGFloat widthSpace = 11;
    CGFloat heightSpace = 11;
    NSInteger count = _videoArray.count;
    _videoArray.count > 10000 ? (count = 10000) : (count = _videoArray.count);
    if (_videoArray.count > 0) {
        for (int i=0; i<count; i++)
        {
            NSInteger row = i / 3;
            NSInteger colom = i % 3;
            CGFloat imageX =  colom * (11 + width) + 11;
            CGFloat imageY =  row * (11 + height) + 11;
            //RSVideoServer *videoServer = [[RSVideoServer alloc] init];
            //UIImage * image = [videoServer imageWithVideoURL:_videoArray[i]];
            UIImageView * imgv = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, width, height)];
            //imgv.image = image;
            
            RSTaobaoVideoAndPictureModel * taobaoVideoAndPicturemodel = _videoArray[i];
            [imgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",taobaoVideoAndPicturemodel.imageUrl]] placeholderImage:[UIImage imageNamed:@"512"]];
            imgv.userInteractionEnabled = YES;
            [self.headerView addSubview:imgv];
            imgv.layer.cornerRadius = 5;
            imgv.layer.masksToBounds = YES;
            //添加手势
            imgv.tag = 10000+i;
            //            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture:)];
            //            [imgv addGestureRecognizer:tap];
            UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
            
            UIImageView * playerImage = [[UIImageView alloc]initWithFrame:CGRectMake(40,40,30,30)];
            playerImage.image = [UIImage imageNamed:@"shiping"];
            [imgv addSubview:playerImage];
            [playerImage bringSubviewToFront:imgv];
            playerImage.userInteractionEnabled = YES;
            
            
            UITapGestureRecognizer * playTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playerVideoAction:)];
            [playerImage addGestureRecognizer:playTap];
            playTap.view.tag = 10000+i;
            
            delete.frame = CGRectMake(width-16, 0, 16, 16);
            //        delete.backgroundColor = [UIColor greenColor];
            [delete setImage:[UIImage imageNamed:@"现货删除"] forState:UIControlStateNormal];
            [delete addTarget:self action:@selector(deleteEvent:) forControlEvents:UIControlEventTouchUpInside];
            delete.tag = 1000000000 + i;
            [imgv addSubview:delete];
            if (self.taobaoManagementmodel.status == 1) {
                delete.hidden = YES;
                _addVideoBtn.hidden = YES;
            }else{
                delete.hidden = NO;
                _addVideoBtn.hidden = NO;
            }
            if (i == _videoArray.count - 1)
            {
                if (_videoArray.count % 3 == 0) {
                    _addVideoBtn.frame = CGRectMake(12, CGRectGetMaxY(imgv.frame) + heightSpace, width, 110);
                } else {
                    _addVideoBtn.frame = CGRectMake(CGRectGetMaxX(imgv.frame) + widthSpace, CGRectGetMinY(imgv.frame), width, 110);
                }
                if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
                    self.headerView.frame = CGRectMake(0, 0, SCW, CGRectGetMaxY(_addVideoBtn.frame) + 10);
                }else{
                    self.headerView.frame = CGRectMake(0, 0, SCW, CGRectGetMaxY(_addVideoBtn.frame) + 10);
                }
            }
        }
        
    }else{
        _addVideoBtn.frame = CGRectMake(12, 10,110, 110);
        if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
            self.headerView.frame = CGRectMake(0, 0, SCW, CGRectGetMaxY(_addVideoBtn.frame) + 10);
        }else{
            self.headerView.frame = CGRectMake(0, 0, SCW, CGRectGetMaxY(_addVideoBtn.frame) + 10);
        }
    }
    
    [self.headerView setupAutoHeightWithBottomView:_addVideoBtn bottomMargin:10];
    [self.headerView layoutIfNeeded];
    self.tableview.tableHeaderView = self.headerView;
}

- (void)sendUrl:(NSURL *)url{
    _tempVideoUrl = url;
    dispatch_async(dispatch_get_main_queue(), ^{
        //[self nineVideoGrid];
         [self reloadVideoAndPictureNewData:@"Video" andImage:nil];
    });
}

//视频播放
- (void)playerVideoAction:(UITapGestureRecognizer *)tap{
//    NSURL * url = _videoArray[tap.view.tag - 10000];
    RSTaobaoVideoAndPictureModel * taobaoVideoAndPicturemodel = _videoArray[tap.view.tag - 10000];
    NSURL * url = [NSURL URLWithString:taobaoVideoAndPicturemodel.videoUrl];
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


//删除视频
- (void)deleteEvent:(UIButton *)deleteBtn{
    
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"确实要删除该视频吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       [self deleteVideoAndPictureNewData:@"video" andIndex:deleteBtn.tag - 1000000000];
    }];
    [alertView addAction:alert];
    UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertView addAction:alert1];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        
        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:alertView animated:YES completion:nil];
    
    
    
}






- (void)nineGrid
{
    //图片
    for (UIImageView * imgv in self.footView.subviews)
    {
        if ([imgv isKindOfClass:[UIImageView class]]) {
            [imgv removeFromSuperview];
        }
    }
    //(self.bounds.size.width - (ECA + 1)*margin)/ECA
    CGFloat width = 110;
    CGFloat height = 110;
    CGFloat widthSpace = 11;
    CGFloat heightSpace = 11;
    NSInteger count = _imageArray.count;
    _imageArray.count > 10000 ? (count = 10000) : (count = _imageArray.count);
    
    if (_imageArray.count > 0) {
        
        for (int i=0; i<count; i++)
        {
            NSInteger row = i / 3;
            NSInteger colom = i % 3;
            CGFloat imageX =  colom * (11 + width) + 11;
            CGFloat imageY =  row * (11 + height) + 11;
            //            UIView * imageSelectView = [[UIView alloc]initWithFrame:CGRectMake(imageX, imageY, width, 75)];
            UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, width, height)];
          
           // imgv.image = _imageArray[i];
            RSTaobaoVideoAndPictureModel * taobaoVideoAndPicturemodel = _imageArray[i];
            [imgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",taobaoVideoAndPicturemodel.imageUrl]] placeholderImage:[UIImage imageNamed:@"512"]];
            
            imgv.contentMode = UIViewContentModeScaleAspectFill;
            imgv.clipsToBounds = YES;
            [self.footView addSubview:imgv];
            imgv.layer.cornerRadius = 5;
            
            imgv.userInteractionEnabled = YES;
            imgv.tag = 10000 + i;
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture:)];
            [imgv addGestureRecognizer:tap];
            
            tap.view.tag = 10000 + i;
            
            UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
            delete.frame = CGRectMake(width - 16, 0, 16, 16);
            
            [delete setImage:[UIImage imageNamed:@"现货删除"] forState:UIControlStateNormal];
            [delete addTarget:self action:@selector(deleteQuestionFeedBackEvent:) forControlEvents:UIControlEventTouchUpInside];
            delete.tag = 10+i;
            [imgv addSubview:delete];
            if (self.taobaoManagementmodel.status == 1) {
                delete.hidden = YES;
                _addPicBtn.hidden = YES;
            }else{
                delete.hidden = NO;
                _addPicBtn.hidden = NO;
            }
            if (i == _imageArray.count - 1)
            {
                if (_imageArray.count % 3 == 0) {
                    _addPicBtn.frame = CGRectMake(12, CGRectGetMaxY(imgv.frame) + heightSpace, width, 110);
                } else {
                    _addPicBtn.frame = CGRectMake(CGRectGetMaxX(imgv.frame) + widthSpace, CGRectGetMinY(imgv.frame), width, 110);
                }
                // _editv.frame = CGRectMake(0, 64, SCW, CGRectGetMaxY(_addPic.frame)+20);
                if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
                    self.footView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), SCW, CGRectGetMaxY(_addPicBtn.frame) + 10);
                }else{
                    self.footView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), SCW, CGRectGetMaxY(_addPicBtn.frame) + 10);
                }
            }
        }
    }else{
        _addPicBtn.frame = CGRectMake(12, 10,110, 110);
        if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
            self.footView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), SCW, CGRectGetMaxY(_addPicBtn.frame) + 10);
        }else{
            self.footView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), SCW, CGRectGetMaxY(_addPicBtn.frame) + 10);
        }
    }
    [self.footView setupAutoHeightWithBottomView:_addPicBtn bottomMargin:10];
    [self.footView layoutIfNeeded];
    self.tableview.tableFooterView = self.footView;
}


//FIXME:查看大图
- (void)showPicture:(UITapGestureRecognizer *)tap{
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < _imageArray.count; i++) {
        RSTaobaoVideoAndPictureModel * taobaoVideoAndPicturemodel = _imageArray[i];
        [array addObject:taobaoVideoAndPicturemodel.imageUrl];
    }
    UIImageView * imgv = (UIImageView *)self.footView.subviews[tap.view.tag - 10000];
    [HUPhotoBrowser showFromImageView:imgv withURLStrings:array atIndex:tap.view.tag - 10000];
}


//FIXME:删除
- (void)deleteQuestionFeedBackEvent:(UIButton *)deleteBtn{
    
    
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"提示" message:@"确实要删除该图片吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteVideoAndPictureNewData:@"picture" andIndex:deleteBtn.tag - 10];
    }];
    [alertView addAction:alert];
    UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertView addAction:alert1];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        
        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:alertView animated:YES completion:nil];
  
}



- (void)deleteVideoAndPictureNewData:(NSString *)type andIndex:(NSInteger)index{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    if ([type isEqualToString:@"picture"]) {
        
        RSTaobaoVideoAndPictureModel * taobaoVideoAndPicturemodel = _imageArray[index];
        
        [phoneDict setObject:[NSNumber numberWithInteger:taobaoVideoAndPicturemodel.imageId] forKey:@"imageId"];
    }else{
        RSTaobaoVideoAndPictureModel * taobaoVideoAndPicturemodel = _videoArray[index];
        [phoneDict setObject:[NSNumber numberWithInteger:taobaoVideoAndPicturemodel.imageId] forKey:@"imageId"];
        [phoneDict setObject:[NSNumber numberWithInteger:taobaoVideoAndPicturemodel.videoId] forKey:@"videoId"];
    }
    [phoneDict setObject:self.taobaoManagementmodel.identityId forKey:@"identityId"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_TAOBAODELETEINVENTORYFILES_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"]boolValue];
            if (isresult) {
                if ([type isEqualToString:@"picture"]) {
                    [_imageArray removeObjectAtIndex:index];
                    //[self.taobaoManagementmodel.imageList removeObjectAtIndex:index];
                    self.taobaoManagementmodel.imageList = _imageArray;
                    [weakSelf nineGrid];
                }else{
                    self.taobaoManagementmodel.videoAndPicturemodel.imageId = 0;
                    self.taobaoManagementmodel.videoAndPicturemodel.videoId = 0;
                    self.taobaoManagementmodel.videoAndPicturemodel.imageUrl = @"";
                    self.taobaoManagementmodel.videoAndPicturemodel.videoUrl = @"";
                    [_videoArray removeObjectAtIndex:index];
                    [weakSelf nineVideoGrid];
                }
            }else{
                if ([type isEqualToString:@"picture"]) {
                      [SVProgressHUD showErrorWithStatus:@"删除图片失败"];
                }else{
                      [SVProgressHUD showErrorWithStatus:@"删除视频失败"];
                }
            }
        }else{
            if ([type isEqualToString:@"picture"]) {
                [SVProgressHUD showErrorWithStatus:@"删除图片失败"];
            }else{
                [SVProgressHUD showErrorWithStatus:@"删除视频失败"];
            }
        }
    }];
}







- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * VIDEOANDPICTURECELLID = @"VIDEOANDPICTURECELLID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:VIDEOANDPICTURECELLID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:VIDEOANDPICTURECELLID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
