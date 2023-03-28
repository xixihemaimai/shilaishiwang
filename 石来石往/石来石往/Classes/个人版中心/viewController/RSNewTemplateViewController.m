//
//  RSNewTemplateViewController.m
//  石来石往
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "RSNewTemplateViewController.h"
#import "RSPublishingProjectCaseFirstButton.h"
@interface RSNewTemplateViewController ()<UITextFieldDelegate,TZImagePickerControllerDelegate>
{
    UITextField * _nameTextfield;
    UIButton * _submissionBtn;
    RSPublishingProjectCaseFirstButton * _selectImageBtn;
}

@property (nonatomic,strong)UIImage * btnCurrentImage;

@property (nonatomic,strong) UIButton * currentBtn;


@end

@implementation RSNewTemplateViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *verifyKey = [user objectForKey:@"VERIFYKEY"];
    [RSLoginValidity LoginValiditWithVerifyKey:verifyKey andViewController:self];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat Y = 0.0;
    if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
        Y = 88;
    }else{
        Y = 64;
    }
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#ffffff"];
    
    UILabel * modelType = [[UILabel alloc]init];
    modelType.frame = CGRectMake(12, Y + 10, SCW - 24 , 23);
    modelType.text = @"模板类型";
    modelType.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    modelType.font = [UIFont systemFontOfSize:16];
    modelType.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:modelType];
    
    UIButton * BlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    BlBtn.frame = CGRectMake(12, CGRectGetMaxY(modelType.frame) + 8, 106, 36);
    
    [BlBtn setTitle:@"荒料" forState:UIControlStateNormal];
    BlBtn.layer.cornerRadius = 2;
    BlBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [BlBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [BlBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#E4E4E4"]];
    [BlBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    [self.view addSubview:BlBtn];
    [BlBtn addTarget:self action:@selector(chioceModelAction:) forControlEvents:UIControlEventTouchUpInside];
   
    
    
    UIButton * SlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    SlBtn.frame = CGRectMake(CGRectGetMaxX(BlBtn.frame) + 13, CGRectGetMaxY(modelType.frame) + 8, 106, 36);
    [SlBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [SlBtn setTitle:@"大板" forState:UIControlStateNormal];
    [SlBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#E4E4E4"]];
    [SlBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
    SlBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    SlBtn.layer.cornerRadius = 2;
    [self.view addSubview:SlBtn];
    [SlBtn addTarget:self action:@selector(chioceModelAction:) forControlEvents:UIControlEventTouchUpInside];
    

    
    

    UILabel * modelNameLabel = [[UILabel alloc]init];
    modelNameLabel.frame = CGRectMake(12, CGRectGetMaxY(BlBtn.frame) + 15, SCW - 24 , 23);
    modelNameLabel.text = @"模板名字";
    modelNameLabel.textColor = [UIColor colorWithHexColorStr:@"#333333"];
    modelNameLabel.font = [UIFont systemFontOfSize:16];
    modelNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:modelNameLabel];
    
    
    
    
    UITextField * nameTextfield = [[UITextField alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(modelNameLabel.frame) + 10, SCW - 24, 50)];
    nameTextfield.placeholder = @"模版名字";
    nameTextfield.textAlignment = NSTextAlignmentLeft;
    nameTextfield.textColor = [UIColor colorWithHexColorStr:@"#999999"];
    nameTextfield.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:nameTextfield];
     nameTextfield.returnKeyType = UIReturnKeyDone;
   // [nameTextfield addTarget:self action:@selector(inputModelContent:) forControlEvents:UIControlEventEditingChanged];
    nameTextfield.delegate = self;
    _nameTextfield = nameTextfield;
    
    
    UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(nameTextfield.frame), SCW - 12, 1)];
    midView.backgroundColor = [UIColor colorWithHexColorStr:@"#F0F0F0"];
    [self.view addSubview:midView];
    
    
    
    
    RSPublishingProjectCaseFirstButton * selectImageBtn = [[RSPublishingProjectCaseFirstButton alloc]initWithFrame:CGRectMake(12, CGRectGetMaxY(midView.frame) + 19, SCW - 24, 173)];
    [selectImageBtn setImage:[UIImage imageNamed:@"添加个人版"] forState:UIControlStateNormal];
    [selectImageBtn setTitle:@"添加码单模版照片" forState:UIControlStateNormal];
    [selectImageBtn addTarget:self action:@selector(addPictureAction:) forControlEvents:UIControlEventTouchUpInside];
    [selectImageBtn setTitleColor:[UIColor colorWithHexColorStr:@"#999999"] forState:UIControlStateNormal];
    [self.view addSubview:selectImageBtn];
    
    _selectImageBtn = selectImageBtn;
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.bounds = CGRectMake(0, 0, selectImageBtn.yj_width, selectImageBtn.yj_height);//虚线框的大小
    borderLayer.position = CGPointMake(CGRectGetMidX(selectImageBtn.bounds),CGRectGetMidY(selectImageBtn.bounds));//虚线框锚点
    borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;//矩形路径
    borderLayer.lineWidth = 1. / [[UIScreen mainScreen] scale];//虚线宽度
    //虚线边框
    borderLayer.lineDashPattern = @[@5, @5];
    //实线边框
    //    borderLayer.lineDashPattern = nil;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = [UIColor colorWithHexColorStr:@"#D8D8D8"].CGColor;
    [selectImageBtn.layer addSublayer:borderLayer];
    //[addSelectView setupAutoHeightWithBottomView:selectImageBtn bottomMargin:8];
    
    
    
    UIButton * submissionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submissionBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submissionBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
    [submissionBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
    submissionBtn.frame = CGRectMake(12, CGRectGetMaxY(selectImageBtn.frame) + 47, SCW - 24, 38);
    submissionBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:submissionBtn];
    submissionBtn.layer.cornerRadius = 19;
    [submissionBtn addTarget:self action:@selector(addModelAction:) forControlEvents:UIControlEventTouchUpInside];
    _submissionBtn = submissionBtn;
    
    
    if ([self.ismodifyStr isEqualToString:@"new"]) {
        
        //新建
        BlBtn.selected = YES;
        self.currentBtn = BlBtn;
        [BlBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle 2 + Shape Mask"] forState:UIControlStateNormal];
        [BlBtn setTitleColor:[UIColor colorWithHexColorStr:@"#108EE9"] forState:UIControlStateNormal];
        
        
        //[SlBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
       // [SlBtn setTitle:@"大板" forState:UIControlStateNormal];
       // [SlBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        self.title = @"新建模板";
        [submissionBtn setTitle:@"保存" forState:UIControlStateNormal];
    }else{
        self.title = @"修改模板";
        //修改
        //self.templatemodel
        
        
        
        NSString * urlstr = [URL_HEADER_TEXT_IOS substringToIndex:[URL_HEADER_TEXT_IOS length] - 1];
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",urlstr,self.templatemodel.image]]];
        
        //http://117.29.162.206:8888
        //personalWkVc.webStr = [NSString stringWithFormat:@"%@slsw/pwms/codeList.html",URL_HEADER_TEXT_IOS];
      //  NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://192.168.1.48:8888%@",self.templatemodel.image]]];
        UIImage * image = [UIImage imageWithData:data];
        [_selectImageBtn setImage:image forState:UIControlStateNormal];
        _nameTextfield.text = self.templatemodel.modelName;
        
        
        
         [selectImageBtn setTitle:@"" forState:UIControlStateNormal];
        self.btnCurrentImage = image;
        
        
        _selectImageBtn.imageView.sd_layout
        .widthIs(_selectImageBtn.yj_width)
        .heightIs(_selectImageBtn.yj_height)
        .topSpaceToView(_selectImageBtn, 0)
        .rightSpaceToView(_selectImageBtn, 0);
        
        if ([self.templatemodel.modelType isEqualToString:@"SL"]) {
            SlBtn.selected = YES;
            self.currentBtn = SlBtn;
            [SlBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle 2 + Shape Mask"] forState:UIControlStateNormal];
            [SlBtn setTitleColor:[UIColor colorWithHexColorStr:@"#108EE9"] forState:UIControlStateNormal];
        }else{
            BlBtn.selected = YES;
            self.currentBtn = BlBtn;
            [BlBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle 2 + Shape Mask"] forState:UIControlStateNormal];
            [BlBtn setTitleColor:[UIColor colorWithHexColorStr:@"#108EE9"] forState:UIControlStateNormal];
        }
          [submissionBtn setTitle:@"修改" forState:UIControlStateNormal];
    }
}


//选择的模式
- (void)chioceModelAction:(UIButton *)btn{
    [btn setBackgroundImage:[UIImage imageNamed:@"Rectangle 2 + Shape Mask"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexColorStr:@"#108EE9"] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithHexColorStr:@""]];
  
    if (!btn.isSelected) {
        self.currentBtn.selected = !self.currentBtn.selected;
        btn.selected = !btn.selected;
        [self.currentBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#E4E4E4"]];
        [self.currentBtn setTitleColor:[UIColor colorWithHexColorStr:@"#333333"] forState:UIControlStateNormal];
        [self.currentBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.currentBtn = btn;
    }
}



- (void)addPictureAction:(UIButton *)addPictureBtn{
    [_nameTextfield resignFirstResponder];
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
                                   [_selectImageBtn setImage:tempImg forState:UIControlStateNormal];
                                   [_selectImageBtn setTitle:@"" forState:UIControlStateNormal];
                                   _selectImageBtn.imageView.sd_layout
                                   .widthIs(_selectImageBtn.yj_width)
                                   .heightIs(_selectImageBtn.yj_height)
                                   .topSpaceToView(_selectImageBtn, 0)
                                   .rightSpaceToView(_selectImageBtn, 0);
                               });
                           }
                       });
    }];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        tzimagepicker.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:tzimagepicker animated:YES completion:nil];
    
    
    
//    RSSelectNeedImageTool * selectTool = [[RSSelectNeedImageTool alloc]init];
//    [selectTool openPhotoAlbumAndOpenCameraViewController:self];
//    selectTool.returnData = ^(XPhotoUploaderContentEntity * _Nonnull photoEntityWillUpload) {
//        _photoEntityWillUpload = photoEntityWillUpload;
//        //上传图片
//        //[self uploadUserHead];
//        [_selectImageBtn setImage:_photoEntityWillUpload.image forState:UIControlStateNormal];
//
//        _selectImageBtn.imageView.sd_layout
//        .widthIs(_selectImageBtn.yj_width)
//        .heightIs(_selectImageBtn.yj_height)
//        .topSpaceToView(_selectImageBtn, 0)
//        .rightSpaceToView(_selectImageBtn, 0);
//    };
}

//提交
- (void)addModelAction:(UIButton *)submissionBtn{
    [_nameTextfield resignFirstResponder];
    if ([_nameTextfield.text length] < 1) {
        [SVProgressHUD showInfoWithStatus:@"请输入模板名字"];
        return;
    }
    
    if (_selectImageBtn.currentImage == nil) {
        [SVProgressHUD showInfoWithStatus:@"请选择图片"];
        return;
    }
    
    NSString * str = [NSString string];
    if ([self.currentBtn.currentTitle isEqualToString:@"荒料"]) {
        str = @"BL";
    }else{
        str = @"SL";
    }
    
    NSData * imagedata = UIImageJPEGRepresentation(_selectImageBtn.currentImage,1);
    NSUInteger length = [imagedata length]/1024;
    UIImage * image = [[UIImage alloc]init];
    if (length * 1024.f> 4000.f * 1024.f) {
        //这边就要压缩
       image = [self compressImage:_selectImageBtn.currentImage toByte:3500.f *1024.f];
    }else{
       image = _selectImageBtn.currentImage;
    }
    
    if ([self.ismodifyStr isEqualToString:@"new"]) {
        [SVProgressHUD showWithStatus:@"正在上传中....."];
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSMutableDictionary * modeldict = [NSMutableDictionary dictionary];
        [modeldict setObject:_nameTextfield.text forKey:@"modelName"];
        [modeldict setObject:str forKey:@"modelType"];
        [dict setObject:modeldict forKey:@"tableModel"];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        //POST参数
        AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        NSDictionary *parameters = @{@"key": [NSString get_uuid] , @"Data" : dataStr, @"VerifyKey" : verifykey, @"VerifyCode" : [NSString get_verifyCode],@"erpId":applegate.ERPID};
        //_photoEntityWillUpload.image
      //  NSArray *avatarArray = [NSArray arrayWithObject:_selectImageBtn.currentImage];
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
        [netWork getImageDataWithUrlString:URL_ADDMODEL_IOS withParameters:parameters andDataArray:dataArray withBlock:^(id json, BOOL success) {
            if (success) {
                BOOL isresult = [json[@"success"]boolValue];
                if (isresult) {
                    [SVProgressHUD dismiss];
                        [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                    if (weakSelf.reload) {
                        weakSelf.reload(true);
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }
                }else{
                    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",json[@"msg"]]];
                }
            }
            else{
                [SVProgressHUD showErrorWithStatus:@"上传失败"];
            }
        }];
    }else{
        if ([self.templatemodel.status integerValue] == 1) {
            
            
            if ([_selectImageBtn.currentImage isEqual:self.btnCurrentImage]) {
                
               
                    [SVProgressHUD showWithStatus:@"正在修改中....."];
                    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
                    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                    NSMutableDictionary * modeldict = [NSMutableDictionary dictionary];
                    [modeldict setObject:_nameTextfield.text forKey:@"modelName"];
                    [modeldict setObject:str forKey:@"modelType"];
                    [dict setObject:modeldict forKey:@"tableModel"];
                    [modeldict setObject:[NSNumber numberWithInteger:self.templatemodel.tempID] forKey:@"id"];
                    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
                    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                    //POST参数
                    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    NSDictionary *parameters = @{@"key": [NSString get_uuid] , @"Data" : dataStr, @"VerifyKey" : verifykey, @"VerifyCode" : [NSString get_verifyCode],@"erpId":applegate.ERPID};
                    RSWeakself
                     XLAFNetworkingBlock * netWork = [[XLAFNetworkingBlock alloc]init];
                    [netWork getDataWithUrlString:URL_UPDATEMODEL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                        if (success) {
                            BOOL isresult = [json[@"success"]boolValue];
                            if (isresult) {
                                [SVProgressHUD dismiss];
                                //                        if ([weakSelf.ismodifyStr isEqualToString:@"new"]) {
                                //                            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                                //                        }else{
                                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                                //                        }
                                if (weakSelf.reload) {
                                    weakSelf.reload(true);
                                    [weakSelf.navigationController popViewControllerAnimated:YES];
                                }
                            }else{
                                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",json[@"msg"]]];
                            }
                        }
                        else{
                            [SVProgressHUD showErrorWithStatus:@"修改失败"];
                        }
                    }];
            }else{
                //该模板已审核通过，修改需要重新审核，是否确定修改
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"该模板已审核通过，修改需要重新审核，是否确定修改" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [SVProgressHUD showWithStatus:@"正在修改中....."];
                    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
                    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                    NSMutableDictionary * modeldict = [NSMutableDictionary dictionary];
                    [modeldict setObject:_nameTextfield.text forKey:@"modelName"];
                    [modeldict setObject:str forKey:@"modelType"];
                    [dict setObject:modeldict forKey:@"tableModel"];
                    [modeldict setObject:[NSNumber numberWithInteger:self.templatemodel.tempID] forKey:@"id"];
                    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
                    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                    //POST参数
                    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    NSDictionary *parameters = @{@"key": [NSString get_uuid] , @"Data" : dataStr, @"VerifyKey" : verifykey, @"VerifyCode" : [NSString get_verifyCode],@"erpId":applegate.ERPID};
                    //_photoEntityWillUpload.image
                    //NSArray *avatarArray = [NSArray arrayWithObject:_selectImageBtn.currentImage];
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
                    [netWork getImageDataWithUrlString:URL_UPDATEMODEL_IOS withParameters:parameters andDataArray:dataArray withBlock:^(id json, BOOL success) {
                        if (success) {
                            BOOL isresult = [json[@"success"]boolValue];
                            if (isresult) {
                                [SVProgressHUD dismiss];
                                //                        if ([weakSelf.ismodifyStr isEqualToString:@"new"]) {
                                //                            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                                //                        }else{
                                [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                                //                        }
                                if (weakSelf.reload) {
                                    weakSelf.reload(true);
                                    [weakSelf.navigationController popViewControllerAnimated:YES];
                                }
                            }else{
                                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",json[@"msg"]]];
                            }
                        }
                        else{
                            [SVProgressHUD showErrorWithStatus:@"修改失败"];
                        }
                    }];
                }];
                [alert addAction:sure];
                UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
                    alert.modalPresentationStyle = UIModalPresentationFullScreen;
                }
                [self presentViewController:alert animated:YES completion:nil];
               
            }
        }else{
            if ([_selectImageBtn.currentImage isEqual:self.btnCurrentImage]) {   
                [SVProgressHUD showWithStatus:@"正在修改中....."];
                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                NSMutableDictionary * modeldict = [NSMutableDictionary dictionary];
                [modeldict setObject:_nameTextfield.text forKey:@"modelName"];
                [modeldict setObject:str forKey:@"modelType"];
                [dict setObject:modeldict forKey:@"tableModel"];
                [modeldict setObject:[NSNumber numberWithInteger:self.templatemodel.tempID] forKey:@"id"];
                NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
                NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                //POST参数
                AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                NSDictionary *parameters = @{@"key": [NSString get_uuid] , @"Data" : dataStr, @"VerifyKey" : verifykey, @"VerifyCode" : [NSString get_verifyCode],@"erpId":applegate.ERPID};
                RSWeakself
                XLAFNetworkingBlock * netWork = [[XLAFNetworkingBlock alloc]init];
                [netWork getDataWithUrlString:URL_UPDATEMODEL_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
                    if (success) {
                        BOOL isresult = [json[@"success"]boolValue];
                        if (isresult) {
                            [SVProgressHUD dismiss];
                            //                        if ([weakSelf.ismodifyStr isEqualToString:@"new"]) {
                            //                            [SVProgressHUD showSuccessWithStatus:@"上传成功"];
                            //                        }else{
                            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                            //                        }
                            if (weakSelf.reload) {
                                weakSelf.reload(true);
                                [weakSelf.navigationController popViewControllerAnimated:YES];
                            }
                        }else{
                            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",json[@"msg"]]];
                        }
                    }
                    else{
                        [SVProgressHUD showErrorWithStatus:@"修改失败"];
                    }
                }];
                
            }else{
                
                [SVProgressHUD showWithStatus:@"正在修改中....."];
                NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
                NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                NSMutableDictionary * modeldict = [NSMutableDictionary dictionary];
                [modeldict setObject:_nameTextfield.text forKey:@"modelName"];
                [modeldict setObject:str forKey:@"modelType"];
                [dict setObject:modeldict forKey:@"tableModel"];
                [modeldict setObject:[NSNumber numberWithInteger:self.templatemodel.tempID] forKey:@"id"];
                NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
                NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                //POST参数
                AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                NSDictionary *parameters = @{@"key": [NSString get_uuid] , @"Data" : dataStr, @"VerifyKey" : verifykey, @"VerifyCode" : [NSString get_verifyCode],@"erpId":applegate.ERPID};
                //_photoEntityWillUpload.image
                //NSArray *avatarArray = [NSArray arrayWithObject:_selectImageBtn.currentImage];
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
                [netWork getImageDataWithUrlString:URL_UPDATEMODEL_IOS withParameters:parameters andDataArray:dataArray withBlock:^(id json, BOOL success) {
                    if (success) {
                        BOOL isresult = [json[@"success"]boolValue];
                        if (isresult) {
                            [SVProgressHUD dismiss];
                            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
                            if (weakSelf.reload) {
                                weakSelf.reload(true);
                                [weakSelf.navigationController popViewControllerAnimated:YES];
                            }
                        }else{
                            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",json[@"msg"]]];
                        }
                    }
                    else{
                        [SVProgressHUD showErrorWithStatus:@"修改失败"];
                    }
                }];
            }
                
        }
    }
    
    //修改和提交
//    [SVProgressHUD showWithStatus:@"正在上传中....."];
//    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
//    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    NSMutableDictionary * modeldict = [NSMutableDictionary dictionary];
//    [modeldict setObject:_nameTextfield.text forKey:@"modelName"];
//    [modeldict setObject:str forKey:@"modelType"];
//    [dict setObject:modeldict forKey:@"tableModel"];
//    NSString * type = [NSString string];
//    if ([self.ismodifyStr isEqualToString:@"new"]) {
//        type = URL_ADDMODEL_IOS;
//    }else{
//        type = URL_UPDATEMODEL_IOS;
//        [modeldict setObject:[NSNumber numberWithInteger:self.templatemodel.tempID] forKey:@"id"];
//    }
//    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
//    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    //POST参数
//    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSDictionary *parameters = @{@"key": [NSString get_uuid] , @"Data" : dataStr, @"VerifyKey" : verifykey, @"VerifyCode" : [NSString get_verifyCode],@"erpId":applegate.ERPID};
//    //_photoEntityWillUpload.image
//    //NSArray *avatarArray = [NSArray arrayWithObject:_selectImageBtn.currentImage];
//    NSArray *avatarArray = [NSArray arrayWithObject:image];
//    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
//    NSData *imageData;
//    for (UIImage *avatar in avatarArray)
//    {
//        imageData = UIImageJPEGRepresentation(avatar, 1);
//        [dataArray addObject:imageData];
//    }
//    RSWeakself
//    XLAFNetworkingBlock * netWork = [[XLAFNetworkingBlock alloc]init];
//    [netWork getImageDataWithUrlString:type withParameters:parameters andDataArray:dataArray withBlock:^(id json, BOOL success) {
//        if (success) {
//            BOOL isresult = [json[@"success"]boolValue];
//            if (isresult) {
//                [SVProgressHUD dismiss];
//                if ([weakSelf.ismodifyStr isEqualToString:@"new"]) {
//                      [SVProgressHUD showSuccessWithStatus:@"上传成功"];
//                }else{
//                      [SVProgressHUD showSuccessWithStatus:@"修改成功"];
//                }
//                if (weakSelf.reload) {
//                    weakSelf.reload(true);
//                    [weakSelf.navigationController popViewControllerAnimated:YES];
//                }
//            }else{
//                if ([weakSelf.ismodifyStr isEqualToString:@"new"]) {
//
//                      [SVProgressHUD showErrorWithStatus:@"上传失败"];
//
//                }else{
//
//                      [SVProgressHUD showErrorWithStatus:@"修改失败"];
//                }
//            }
//        }
//        else{
//            if ([weakSelf.ismodifyStr isEqualToString:@"new"]) {
//
//                  [SVProgressHUD showErrorWithStatus:@"上传失败"];
//            }else{
//                  [SVProgressHUD showErrorWithStatus:@"修改失败"];
//            }
//        }
//    }];
}













- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    temp = [self delSpaceAndNewline:temp];
    if ([temp length] > 0) {
        _nameTextfield.text = temp;
    }else{
        _nameTextfield.text = @"";
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];//取消第一响应者
    
    return YES;
}




//- (void)inputModelContent:(UITextField *)textField{
//    NSString *temp = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//
//    temp = [self delSpaceAndNewline:temp];
//    if ([temp length] > 0) {
//        _nameTextfield.text = temp;
//    }else{
//        _nameTextfield.text = @"";
//    }
//}


- (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}


- (NSString *)delSpaceAndNewline:(NSString *)string{
    NSMutableString *mutStr = [NSMutableString stringWithString:string];
    NSRange range = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}

@end
