//
//  RSBLPerfectPictureViewController.m
//  石来石往
//
//  Created by mac on 2019/6/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSBLPerfectPictureViewController.h"
#import "RSPublishingProjectCaseFirstButton.h"
#import "RSPwmsMtlImgsModel.h"
@interface RSBLPerfectPictureViewController ()<TZImagePickerControllerDelegate>

{
    
    NSMutableArray * _imageArray;
}
@property (nonatomic,strong) UIView * contentPictureView ;

@property (nonatomic,strong) RSPublishingProjectCaseFirstButton * addPic;




@end

@implementation RSBLPerfectPictureViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"完善图片";
    _imageArray = [NSMutableArray array];
    
    
    
//    UIButton * saveBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
//    [saveBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
//    saveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//    UIBarButtonItem * rightitem = [[UIBarButtonItem alloc]initWithCustomView:saveBtn];
//    self.navigationItem.rightBarButtonItem = rightitem;
//    [saveBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    UIView * contentPictureView = [[UIView alloc]init];
    self.contentPictureView.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    self.contentPictureView = contentPictureView;
    [self.view addSubview:self.contentPictureView];
    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
        self.contentPictureView.frame = CGRectMake(0, 88, SCW, 132);
    }else{
        self.contentPictureView.frame = CGRectMake(0, 64, SCW, 132);
    }
    
    RSPublishingProjectCaseFirstButton * addPic = [[RSPublishingProjectCaseFirstButton alloc]initWithFrame:CGRectMake(12, 12,SCW/2 - 16, 108)];
    [addPic setImage:[UIImage imageNamed:@"添加个人版"] forState:UIControlStateNormal];
    [addPic setTitle:@"添加" forState:UIControlStateNormal];
    addPic.titleLabel.font = [UIFont systemFontOfSize:12];
    [addPic addTarget:self action:@selector(addPictureAction:) forControlEvents:UIControlEventTouchUpInside];
    addPic.layer.cornerRadius = 5;
    [addPic setBackgroundColor:[UIColor colorWithHexColorStr:@"#F9F9F9"]];
    addPic.layer.borderColor = [UIColor colorWithHexColorStr:@"#E8E8E8"].CGColor;
    addPic.layer.borderWidth = 1;
    [addPic setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    [self.contentPictureView addSubview:addPic];
    self.addPic = addPic;
    
    
   
    
    
    [self reloadPictureNewData];
    
    
    
    
    
}


//这边是获取
- (void)reloadPictureNewData{
    
    //URL_LOADPICTURE_IOS
    //库存类型    stockType    String    SL大板 BL荒料
    //物料名称    mtlName    String
    //荒料号    blockNo    String
    //匝号    turnsNo    String
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.stockType forKey:@"stockType"];
    //[dict setObject:self.mtlName forKey:@"mtlName"];
    [dict setObject:self.blockNo forKey:@"blockNo"];
    [dict setObject:self.turnsNo forKey:@"turnsNo"];
    [phoneDict setObject:dict forKey:@"pwmsMtlImgs"];
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_LOADPICTURE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"] boolValue];
            if (isresult) {
                [_imageArray removeAllObjects];
                NSMutableArray * array = [NSMutableArray array];
                array = json[@"data"];
                for (int i = 0; i < array.count; i++) {
                    RSPwmsMtlImgsModel * pwmsMtlImagesmodel = [[RSPwmsMtlImgsModel alloc]init];
                    pwmsMtlImagesmodel.blockNo = [[array objectAtIndex:i]objectForKey:@"blockNo"];
                    
                    pwmsMtlImagesmodel.createTime = [[array objectAtIndex:i]objectForKey:@"createTime"];
                    pwmsMtlImagesmodel.fileName = [[array objectAtIndex:i]objectForKey:@"fileName"];
                    pwmsMtlImagesmodel.mtlName = [[array objectAtIndex:i]objectForKey:@"mtlName"];
                    
                    pwmsMtlImagesmodel.path = [[array objectAtIndex:i]objectForKey:@"path"];
                    
                     pwmsMtlImagesmodel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                    pwmsMtlImagesmodel.stockType = [[array objectAtIndex:i]objectForKey:@"stockType"];
                    
                    pwmsMtlImagesmodel.createUser = [[[array objectAtIndex:i]objectForKey:@"createUser"] integerValue];
                     pwmsMtlImagesmodel.PwmsMtlImgsId = [[[array objectAtIndex:i]objectForKey:@"id"] integerValue];
                    
                    pwmsMtlImagesmodel.pwmsUserId = [[[array objectAtIndex:i]objectForKey:@"pwmsUserId"] integerValue];
                     pwmsMtlImagesmodel.status = [[[array objectAtIndex:i]objectForKey:@"status"] integerValue];
                    [_imageArray addObject:pwmsMtlImagesmodel];
                }
                [weakSelf nineGrid];
            }else{
                [SVProgressHUD showInfoWithStatus:@"添加失败"];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"添加失败"];
        }

    }];
}



- (void)UpdatePictureNewDataImage:(UIImage *)image{
    
    [SVProgressHUD showWithStatus:@"正在上传中....."];
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [phoneDict setObject:@"add" forKey:@"type"];
    [dict setObject:self.stockType forKey:@"stockType"];
    [dict setObject:self.mtlName forKey:@"mtlName"];
    [dict setObject:self.blockNo forKey:@"blockNo"];
    [dict setObject:self.turnsNo forKey:@"turnsNo"];
    [phoneDict setObject:dict forKey:@"pwmsMtlImgs"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //POST参数
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key": [NSString get_uuid] , @"Data" : dataStr, @"VerifyKey" : verifykey, @"VerifyCode" : [NSString get_verifyCode],@"erpId":applegate.ERPID};
    NSArray *avatarArray = [NSArray arrayWithObject:image];
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSData *imageData;
    for (UIImage *avatar in avatarArray)
    {
        imageData = UIImageJPEGRepresentation(avatar, 1);
        [dataArray addObject:imageData];
    }
    RSWeakself
    XLAFNetworkingBlock * netWork = [[XLAFNetworkingBlock alloc]init];
    [netWork getImageDataWithUrlString:URL_STOCKPICTURE_IOS withParameters:parameters andDataArray:dataArray withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL isresult = [json[@"success"] boolValue];
            if (isresult) {
                [SVProgressHUD dismiss];
                [weakSelf reloadPictureNewData];
            }else{
                //[SVProgressHUD showInfoWithStatus:@"上传失败"];
                [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@",json[@"msg"]]];
            }
        }else{
             [SVProgressHUD showInfoWithStatus:@"上传失败"];
        }
    }];
}


- (void)deletePictureNewData:(NSInteger)pwmsMtlImagesId{
    
    
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"确定是否删除图片" message:nil preferredStyle:UIAlertControllerStyleAlert];
                         UIAlertAction * alert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                         }];
                         [alertView addAction:alert];
                         
                         UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                                            
                             
                             NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                             NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
                             NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
                             NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                             [dict setObject:[NSNumber numberWithInteger:pwmsMtlImagesId] forKey:@"id"];
                             [phoneDict setObject:dict forKey:@"pwmsMtlImgs"];
                             [phoneDict setObject:@"delete" forKey:@"type"];
                             NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
                             NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                             AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                             NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
                             RSWeakself
                             XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
                             [network getDataWithUrlString:URL_STOCKPICTURE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                                 if (success) {
                                     BOOL isresult = [json[@"success"] boolValue];
                                     if (isresult) {
                                         [SVProgressHUD dismiss];
                                         [weakSelf reloadPictureNewData];
                                     }else{
                                         [SVProgressHUD showInfoWithStatus:@"删除失败"];
                                     }
                                 }else{
                                     [SVProgressHUD showInfoWithStatus:@"删除失败"];
                                 }
                             
                             }];
                             
                         }];
                         [alertView addAction:alert1];
                         
                         if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                             alertView.modalPresentationStyle = UIModalPresentationFullScreen;
                         }
                         [self presentViewController:alertView animated:YES completion:nil];
                         
                         
                         
               
    
    
    
//
//    [JHSysAlertUtil presentAlertViewWithTitle:@"确定是否删除图片" message:nil cancelTitle:@"确定" defaultTitle:@"取消" distinct:YES cancel:^{
//        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//        NSString * verifyKey = [user objectForKey:@"VERIFYKEY"];
//        NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
//        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//        [dict setObject:[NSNumber numberWithInteger:pwmsMtlImagesId] forKey:@"id"];
//        [phoneDict setObject:dict forKey:@"pwmsMtlImgs"];
//        [phoneDict setObject:@"delete" forKey:@"type"];
//        NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
//        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//        NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifyKey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
//        RSWeakself
//        XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
//        [network getDataWithUrlString:URL_STOCKPICTURE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
//            if (success) {
//                BOOL isresult = [json[@"success"] boolValue];
//                if (isresult) {
//                    [SVProgressHUD dismiss];
//                    [weakSelf reloadPictureNewData];
//                }else{
//                    [SVProgressHUD showInfoWithStatus:@"删除失败"];
//                }
//            }else{
//                [SVProgressHUD showInfoWithStatus:@"删除失败"];
//            }
//        }];
//    } confirm:^{
//
//
//    }];
                             
}


- (void)addPictureAction:(UIButton *)addPicBtn{
    RSWeakself
    TZImagePickerController * tzimagepicker = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
    tzimagepicker.allowPickingVideo = NO;
    tzimagepicker.allowTakePicture = YES;
    [tzimagepicker setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                       {
                           for (int i=0; i<photos.count; i++)
                           {
                               UIImage * tempImg = photos[i];
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    //[weakSelf nineGrid];
                                    [weakSelf UpdatePictureNewDataImage:tempImg];
                                });
                           }
                       });
    }];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        tzimagepicker.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:tzimagepicker animated:YES completion:nil];
    
}


//- (void)saveAction:(UIButton *)saveBtn{
//    NSLog(@"保存");
//}




- (void)nineGrid
{
    //这边要判断是图片还是视频
        //图片
        for (UIImageView *imgv in self.contentPictureView.subviews)
        {
            if ([imgv isKindOfClass:[UIImageView class]]) {
                [imgv removeFromSuperview];
            }
        }
        CGFloat width = SCW/2 - 20;
        CGFloat height = 108;
        CGFloat widthSpace = 12;
        CGFloat heightSpace = 12;
        NSInteger count = _imageArray.count;
        _imageArray.count > 6 ? (count = 6) : (count = _imageArray.count);
    
    if (_imageArray.count > 0) {
        for (int i=0; i<count; i++)
        {
            
            NSInteger row = i / 2;
            NSInteger colom = i % 2;
            CGFloat imageX =  colom * (12 + width) + 12;
            CGFloat imageY =  row * (12 + height) + 12;
            UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, width, 108)];
            RSPwmsMtlImgsModel * pwmsMtlImagesmodel = _imageArray[i];
            
            NSString * urlstr = [URL_HEADER_TEXT_IOS substringToIndex:[URL_HEADER_TEXT_IOS length] - 1];
            
            [imgv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@",urlstr,pwmsMtlImagesmodel.path,pwmsMtlImagesmodel.fileName]] placeholderImage:[UIImage imageNamed:@"512"]];
            imgv.contentMode = UIViewContentModeScaleAspectFill;
            imgv.clipsToBounds = YES;
            //imgv.image
            imgv.userInteractionEnabled = YES;
            [self.contentPictureView addSubview:imgv];
            //添加手势
            imgv.tag = 10000+i;
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture:)];
            [imgv addGestureRecognizer:tap];
            tap.view.tag = 10000+i;
            
            UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
            delete.frame = CGRectMake(width - 16, 0, 16, 16);
            //        delete.backgroundColor = [UIColor greenColor];
            [delete setImage:[UIImage imageNamed:@"现货删除"] forState:UIControlStateNormal];
            [delete addTarget:self action:@selector(deleteEvent:) forControlEvents:UIControlEventTouchUpInside];
            delete.tag = 10+i;
            [imgv addSubview:delete];
            if (i == _imageArray.count - 1)
            {
                
                if (_imageArray.count % 2 == 0) {
                    _addPic.frame = CGRectMake(15, CGRectGetMaxY(imgv.frame) + heightSpace, width, 108);
                    
                } else {
                    _addPic.frame = CGRectMake(CGRectGetMaxX(imgv.frame) + widthSpace, CGRectGetMinY(imgv.frame), width, 108);
                }
                // _editv.frame = CGRectMake(0, 64, SCW, CGRectGetMaxY(_addPic.frame)+20);
                if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
                    self.contentPictureView.frame = CGRectMake(0, 64, SCW, CGRectGetMaxY(_addPic.frame) + 12);
                }else{
                    self.contentPictureView.frame = CGRectMake(0, 88, SCW, CGRectGetMaxY(_addPic.frame) + 12);
                }
            }
        }
    }else{
        self.addPic.frame = CGRectMake(12, 12,SCW/2 - 16, 108);
        if (iPhone4 || iPhone5 || iPhone6 || iPhone6p) {
            self.contentPictureView.frame = CGRectMake(0, 64, SCW, CGRectGetMaxY(self.addPic.frame) + 12);
        }else{
            self.contentPictureView.frame = CGRectMake(0, 88, SCW, CGRectGetMaxY(self.addPic.frame) + 12);
        }
    }
}


- (void)showPicture:(UITapGestureRecognizer *)tap{
    RSPwmsMtlImgsModel * rspwmsMtlImagesmodel = _imageArray[tap.view.tag - 10000];
    NSMutableArray * array = [NSMutableArray array];
    
    NSString * urlstr = [URL_HEADER_TEXT_IOS substringToIndex:[URL_HEADER_TEXT_IOS length] - 1];
    NSString * str = [NSString stringWithFormat:@"%@%@%@",urlstr,rspwmsMtlImagesmodel.path,rspwmsMtlImagesmodel.fileName];
    [array addObject:str];
    [XLPhotoBrowser showPhotoBrowserWithImages:array currentImageIndex:0 andContentStr:nil];
}


- (void)deleteEvent:(UIButton *)deleteBtn{
    RSPwmsMtlImgsModel * pwmsMtlImagesmodel = _imageArray[deleteBtn.tag - 10];
    [self deletePictureNewData:pwmsMtlImagesmodel.PwmsMtlImgsId];
}

@end
