//
//  MADCameraCaptureController.m
//  MADDocScan
//
//  Created by 梁宪松 on 2017/10/28.
//  Copyright © 2017年 梁宪松. All rights reserved.
//

#import "MADCameraCaptureController.h"
#import "MADCropScaleController.h"
//#import "MADSnapshotButton.h"
#import "MADCameraCaptureView.h"
#import "ZZImageEditTool.h"
#import "UIImage+RSScaleImage.h"
//#import "Masonry.h"
#import "RSTemplateViewController.h"
#import "YBPopupMenu.h"
#import "RSTemplateModel.h"
//UINavigationControllerDelegate
@interface MADCameraCaptureController ()<UIGestureRecognizerDelegate,YBPopupMenuDelegate>

// 导航栏
@property (nonatomic, strong) UIView *navToolBar;
// 返回按钮
@property (nonatomic,strong) UIButton *leftBtn;
// 导航栏标题
@property (nonatomic,strong) UILabel *navTitleLabel;
// 闪光灯按钮
@property (nonatomic,strong) UIButton *flashLigthToggle;
// 拍照按钮
//@property (nonatomic, strong) MADSnapshotButton *snapshotBtn;
// 拍照视图
@property (nonatomic, strong) MADCameraCaptureView *captureCameraView;
// 聚焦指示器
@property (nonatomic, strong) UIView *focusIndicator;
// 单击手势
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
//重新拍照按钮
@property (nonatomic,strong)UIButton * takePictureBtn;

@property (nonatomic,strong)NSMutableArray * scandataArray;



@property (nonatomic,strong)void(^successAliHandler)(id result);

@property (nonatomic,strong)void(^failAliHandler) (NSError * errer);

@end

@implementation MADCameraCaptureController{
    // 默认的识别成功的回调
    void (^_successHandler)(id);
    // 默认的识别失败的回调
    void (^_failHandler)(NSError *);
}

- (NSMutableArray *)scandataArray{
    if (!_scandataArray) {
        _scandataArray = [NSMutableArray array];
    }
    return _scandataArray;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   // self.navigationController.delegate = self;
    [self initUI];
    // 设置需要更新约束
    [self.view setNeedsUpdateConstraints];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    // 关闭闪光灯
    self.captureCameraView.enableTorch = NO;
    // 停止捕获图像
    [self.captureCameraView stop];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 开始捕获图像
    [self.captureCameraView start];
}

/**
 初始化视图
 */
- (void)initUI{
    
    // 导航栏
    [self.view addSubview:self.navToolBar];
    [self.navToolBar addSubview:self.leftBtn];
    [self.navToolBar addSubview:self.flashLigthToggle];
    
    if ([self.selectType isEqualToString:@"huangliaoruku"]) {
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSInteger BL = [[user objectForKey:@"BL"] integerValue];
        for (int i = 0; i < self.templateArray.count; i++) {
            RSTemplateModel * templatemodel = self.templateArray[i];
            if (BL == templatemodel.tempID) {
                [self.flashLigthToggle setTitle:templatemodel.modelName forState:UIControlStateNormal];
                break;
            }
        }
    }else{
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        NSInteger SL = [[user objectForKey:@"SL"] integerValue];
        for (int i = 0; i < self.templateArray.count; i++) {
            RSTemplateModel * templatemodel = self.templateArray[i];
            if (SL == templatemodel.tempID) {
                [self.flashLigthToggle setTitle:templatemodel.modelName forState:UIControlStateNormal];
                break;
            }
        }
    }
    [self.navToolBar addSubview:self.navTitleLabel];
    // 拍照视图
    [self.view addSubview:self.captureCameraView];
    [self.captureCameraView setupCameraView];
    // 添加单机手势
    [self.captureCameraView addGestureRecognizer:self.tapGestureRecognizer];
    [self.tapGestureRecognizer addTarget:self action:@selector(handleTapGesture:)];
    // 拍照按钮
    //[self.view addSubview:self.snapshotBtn];
    
    [self.view addSubview:self.takePictureBtn];
    
    // 添加聚焦指示器
    [self.view addSubview:self.focusIndicator];
    // 更新导航栏标题
    [self updateTitleLabel];
    
    [self configCallback];
}

//#pragma mark - UINavigationBarDelegate
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    if (viewController == self) {
//        [self.navigationController setNavigationBarHidden:YES animated:NO];
//        [[UIApplication sharedApplication] setStatusBarHidden:YES];
//    }else
//    {
//        [self.navigationController setNavigationBarHidden:NO animated:NO];
//        [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    }
//}

#pragma mark - Getter
- (UIView *)navToolBar
{
    if (!_navToolBar) {
        _navToolBar = [[UIView alloc] init];
        _navToolBar.backgroundColor = kBaseColor;
    }
    return _navToolBar;
}

- (UIView *)focusIndicator
{
    if (!_focusIndicator) {
        _focusIndicator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _focusIndicator.layer.borderWidth = 5.0f;
        _focusIndicator.layer.borderColor = kWhiteColor.CGColor;
        _focusIndicator.alpha = 0;
    }
    return _focusIndicator;
}



- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0, 0, 40, 40);
        [_leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
//        [_leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [_leftBtn setTitle:@"  " forState:UIControlStateNormal];
        _leftBtn.adjustsImageWhenHighlighted = NO;
        [_leftBtn addTarget:self action:@selector(popSelf) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UILabel *)navTitleLabel
{
    if (!_navTitleLabel) {
        _navTitleLabel = [[UILabel alloc] init];
        _navTitleLabel.textAlignment = NSTextAlignmentCenter;
        _navTitleLabel.font = [UIFont systemFontOfSize:17];
        _navTitleLabel.textColor = kWhiteColor;
    }
    return _navTitleLabel;
}

- (UIButton *)flashLigthToggle
{
    if (!_flashLigthToggle) {
        _flashLigthToggle = [UIButton buttonWithType:UIButtonTypeCustom];
        _flashLigthToggle.frame = CGRectMake(0, 0, 70, 40);
        //[_flashLigthToggle setImage:[UIImage imageNamed:@"闪光"] forState:UIControlStateNormal];
        //[_flashLigthToggle setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [_flashLigthToggle setTitle:@"模板" forState:UIControlStateNormal];
        _flashLigthToggle.titleLabel.font = [UIFont systemFontOfSize:17];
        _flashLigthToggle.adjustsImageWhenHighlighted = NO;
        [_flashLigthToggle addTarget:self action:@selector(onFlashLigthToggle:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flashLigthToggle;
}



- (UIButton *)takePictureBtn{
    if (!_takePictureBtn) {
        _takePictureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_takePictureBtn setBackgroundColor:[UIColor colorWithHexColorStr:@"#3385ff"]];
        [_takePictureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_takePictureBtn setTitleColor:[UIColor colorWithHexColorStr:@"#ffffff"] forState:UIControlStateNormal];
         [_takePictureBtn addTarget:self action:@selector(onSnapshotBtn:) forControlEvents:UIControlEventTouchUpInside];
        _takePictureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    
    return _takePictureBtn;
}

//- (MADSnapshotButton *)snapshotBtn
//{
//    if (!_snapshotBtn) {
//        _snapshotBtn = [[MADSnapshotButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
//        [_snapshotBtn addTarget:self action:@selector(onSnapshotBtn:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _snapshotBtn;
//}

- (MADCameraCaptureView *)captureCameraView
{
    if (!_captureCameraView) {
        
        CGFloat H = 0.0;
        if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
            H = 88;
        }else{
            H = 64;
        }
        _captureCameraView = [[MADCameraCaptureView alloc] initWithFrame:CGRectMake(0, H, SCREEN_WIDTH, SCH - H - 50)];
        //打开边缘检测
        [_captureCameraView setEnableBorderDetection:NO];
        _captureCameraView.backgroundColor = kBlackColor;
    }
    return _captureCameraView;
}

- (UITapGestureRecognizer *)tapGestureRecognizer
{
    if (!_tapGestureRecognizer) {
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
//        _tapGestureRecognizer.delegate = self;
        
    }
    return _tapGestureRecognizer;
}

#pragma mark - engine
- (void)onFlashLigthToggle:(UIButton *)flashLigthToggle{
    //这边显示模板选择
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < self.templateArray.count; i++) {
        RSTemplateModel * templatemodel = self.templateArray[i];
        [array addObject:templatemodel.modelName];
    }
    [YBPopupMenu showRelyOnView:flashLigthToggle titles:array icons:nil menuWidth:120 andTag:1 delegate:self];
    

}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu
{
    if ([self.selectType isEqualToString:@"huangliaoruku"]) {
        RSTemplateModel * templatemodel = self.templateArray[index];
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:[NSNumber numberWithInteger:templatemodel.tempID] forKey:@"BL"];
        [user synchronize];
        self.modelId = templatemodel.tempID;
        [self.flashLigthToggle setTitle:templatemodel.modelName forState:UIControlStateNormal];
    }else{
        RSTemplateModel * templatemodel = self.templateArray[index];
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        [user setObject:[NSNumber numberWithInteger:templatemodel.tempID] forKey:@"SL"];
        [user synchronize];
        self.modelId = templatemodel.tempID;
        [self.flashLigthToggle setTitle:templatemodel.modelName forState:UIControlStateNormal];
    }
}


- (void)configCallback {
    __weak typeof(self) weakSelf = self;
    // 这是默认的识别成功的回调
    _successHandler = ^(id result){
     
     //   NSLog(@"%@", result);
      
        //NSString *title = @"识别结果";
//        NSMutableString *message = [NSMutableString string];
//        if(result[@"words_result"]){
//            if([result[@"words_result"] isKindOfClass:[NSDictionary class]]){
//                [result[@"words_result"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//                    if([obj isKindOfClass:[NSDictionary class]] && [obj objectForKey:@"words"]){
//                        [message appendFormat:@"%@: %@\n", key, obj[@"words"]];
//                    }else{
//                        [message appendFormat:@"%@: %@\n", key, obj];
//                    }
//                }];
//            }else if([result[@"words_result"] isKindOfClass:[NSArray class]]){
//                for(NSDictionary *obj in result[@"words_result"]){
//                    if([obj isKindOfClass:[NSDictionary class]] && [obj objectForKey:@"words"]){
//                        [message appendFormat:@"%@\n", obj[@"words"]];
//                    }else{
//                        [message appendFormat:@"%@\n", obj];
//                    }
//
//                }
//            }
//        }else{
//            [message appendFormat:@"%@", result];
//        }
//
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            
              [weakSelf scanPictureData:result];
            
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alertView show];
        }];
    };
    
    _failHandler = ^(NSError *error){
           [SVProgressHUD dismiss];
        NSLog(@"%@", error);
        NSString *msg = [NSString stringWithFormat:@"%li:%@", (long)[error code], [error localizedDescription]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[[UIAlertView alloc] initWithTitle:@"识别失败" message:msg delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        }];
    };
    
    
    
    self.successAliHandler = ^(id result) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [weakSelf scanPictureData:result];
        }];
    };
    
    self.failAliHandler = ^(NSError *errer) {
        [SVProgressHUD dismiss];
        NSLog(@"%@", errer);
        NSString *msg = [NSString stringWithFormat:@"%li:%@", (long)[errer code], [errer localizedDescription]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[[UIAlertView alloc] initWithTitle:@"识别失败" message:msg delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        }];
    };
    
}

- (NSString *)imageToString:(UIImage *)image {
    NSData *imagedata = UIImagePNGRepresentation(image);
    NSString *image64 = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return image64;
}

- (void)aliYunNewData:(UIImage *)image{
    //UIImage * image1 =  [image scaleImage:image toKb:300];
    NSData * imagedata = [image compressWithLengthLimit:300.f * 1024.f];
    UIImage * image1 = [UIImage imageWithData:imagedata];
    //NSString *appcode = @"243cdd2b6bd447fa892b47615e1074ec";
    NSString * appcode = @"14283a6e903446b1807bd7d7877bea8c";
    NSString *host = @"http://form.market.alicloudapi.com";
    NSString *path = @"/api/predict/ocr_table_parse";
    NSString *method = @"POST";
    NSString *querys = @"";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
   // NSString *bodys = @"{\"image\":\"图片二进制数据的base64编码\",\"configure\":\"{\\\"format\\\":\\\"html\\\",\\\"finance\\\":false,\\\"dir_assure\\\":false}\"}";
    NSString * bodys = [NSString stringWithFormat:@"{\"image\":\"%@\",\"configure\":\"{\\\"format\\\":\\\"json\\\",\\\"finance\\\":false,\\\"dir_assure\\\":false}\"}",[self imageToString:image1]];
    //configure字段参数说明：1.format输出格式：html/json/xlsx;2.finance是否使用财务报表模型:true/false;3.dir_assure图片方向是否确定是正向的:true(确定)/false(不确定)";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    //根据API的要求，定义相对应的Content-Type
    RSWeakself
    [request addValue: @"application/json; charset=UTF-8" forHTTPHeaderField: @"Content-Type"];
    NSData *data = [bodys dataUsingEncoding: NSUTF8StringEncoding];
    [request setHTTPBody: data];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                      // NSLog(@"Response object: %@" , response);
                                                       NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                                       if (error) {
                                                           if (weakSelf.failAliHandler) {
                                                               weakSelf.failAliHandler(error);
                                                           }
                                                            weakSelf.tapGestureRecognizer.enabled = YES;
                                                       }else{
                                                           if (weakSelf.successAliHandler) {
                                                               weakSelf.successAliHandler(bodyString);
                                                           }
                                                       }
                                                       //打印应答中的body
                                                      // NSLog(@"Response body: %@" , bodyString);
                                                   }];
    [task resume];
}




- (void)scanPictureData:(id)result{

    //URL_OCRPARSE_IOS
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifkey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:@"BAIDU" forKey:@"parseType"];
    [phoneDict setObject:result forKey:@"ocrJsonStr"];
    [phoneDict setObject:[NSNumber numberWithInteger:self.modelId] forKey:@"modelId"];
    
    //二进制数
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifkey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock *network = [[XLAFNetworkingBlock alloc]init];
    [network getDataWithUrlString:URL_OCRPARSE_IOS withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            int isResult = [json[@"success"] boolValue];
            if (isResult ) {
                //NSMutableArray * array = [NSMutableArray array];
                RSOcrBlockJsonModel * ocrblockjsonmodel = [[RSOcrBlockJsonModel alloc]init];
                //ocrblockjsonmodel.noteTitle = json[@"data"][@"noteTitle"];
                //ocrblockjsonmodel.noteType = json[@"data"][@"noteType"];
                //ocrblockjsonmodel.customer = json[@"data"][@"customer"];
                //ocrblockjsonmodel.supplier = json[@"data"][@"supplier"];
                //ocrblockjsonmodel.noteDate = json[@"data"][@"noteDate"];
                //ocrblockjsonmodel.noteNo = json[@"data"][@"noteNo"];
                //ocrblockjsonmodel.dtlCount = [json[@"data"][@"dtlCount"] intValue];
                NSMutableArray * array = [NSMutableArray array];
                //array = json[@"data"][@"noteDtl"];
                array = json[@"data"][@"materialDetails"];
            NSMutableArray * tempArray = [NSMutableArray array];
                for (int i = 0 ; i < array.count; i++) {
                    
                    /**
                   1  dedVaqty = 0;
                   1  height = 0;
                   1  length = 0;
                    1 preVaqty = 0;
                   1  qty = 0;
                   1  slNo = "";
                  1   stoneName = "891739:<unk><unk>d2144\U53f761\U68ee\U53bf\U8d3e1-8:\U5408\U7aef_8010618H:\U5408\U517d\U9ed1\U7c73\U96f6\U4e09\U53f7\U601d";
                   1  stoneNo = "891739:<unk><unk>d2144\U53f761\U68ee\U53bf\U8d3e1-8:\U5408\U7aef_8010618H:\U5408\U517d\U9ed1\U7c73\U96f6\U4e09\U53f7\U601d";
                   1  stoneType = "";
                   1  turnsNo = "";
                   1  vaqty = 0;
                   1 weight = 0;
                   1  width = 0;
                        */
                    RSOcrBlockDetailModel * ocrblockdetialmodel = [[RSOcrBlockDetailModel alloc]init];
                    ocrblockdetialmodel.stoneName = [[array objectAtIndex:i]objectForKey:@"stoneName"];
                    ocrblockdetialmodel.originalStoneName = [[array objectAtIndex:i]objectForKey:@"stoneName"];
                    ocrblockdetialmodel.stoneType = [[array objectAtIndex:i]objectForKey:@"stoneType"];
                    ocrblockdetialmodel.originalStoneType = [[array objectAtIndex:i]objectForKey:@"stoneType"];
                    ocrblockdetialmodel.stoneNo = [[array objectAtIndex:i]objectForKey:@"stoneNo"];
                    ocrblockdetialmodel.originalStoneNo = [[array objectAtIndex:i]objectForKey:@"stoneNo"];
                    ocrblockdetialmodel.turnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                    ocrblockdetialmodel.originalTurnsNo = [[array objectAtIndex:i]objectForKey:@"turnsNo"];
                    ocrblockdetialmodel.slNo = [[array objectAtIndex:i]objectForKey:@"slNo"];
                    ocrblockdetialmodel.originalSlNo = [[array objectAtIndex:i]objectForKey:@"slNo"];
                    ocrblockdetialmodel.length = [[[array objectAtIndex:i]objectForKey:@"length"] doubleValue];
                    ocrblockdetialmodel.originalLength = [[[array objectAtIndex:i]objectForKey:@"length"] doubleValue];
                    ocrblockdetialmodel.width = [[[array objectAtIndex:i]objectForKey:@"width"] doubleValue];
                    ocrblockdetialmodel.originalWidth = [[[array objectAtIndex:i]objectForKey:@"width"] doubleValue];
                    ocrblockdetialmodel.height = [[[array objectAtIndex:i]objectForKey:@"height"] doubleValue];
                    ocrblockdetialmodel.originalHeight = [[[array objectAtIndex:i]objectForKey:@"height"] doubleValue];
                    ocrblockdetialmodel.qty = [[[array objectAtIndex:i]objectForKey:@"qty"] doubleValue];
                    ocrblockdetialmodel.originalQty = [[[array objectAtIndex:i]objectForKey:@"qty"] doubleValue];
                    ocrblockdetialmodel.preVaqty = [[[array objectAtIndex:i]objectForKey:@"preVaqty"] doubleValue];
                    ocrblockdetialmodel.originalPreVaqty = [[[array objectAtIndex:i]objectForKey:@"preVaqty"] doubleValue];
                    ocrblockdetialmodel.dedVaqty = [[[array objectAtIndex:i]objectForKey:@"dedVaqty"] doubleValue];
                    ocrblockdetialmodel.originalDedVaqty = [[[array objectAtIndex:i]objectForKey:@"dedVaqty"] doubleValue];
                    ocrblockdetialmodel.vaqty = [[[array objectAtIndex:i]objectForKey:@"vaqty"] doubleValue];
                    ocrblockdetialmodel.originalVaqty = [[[array objectAtIndex:i]objectForKey:@"vaqty"] doubleValue];
                    ocrblockdetialmodel.weight = [[[array objectAtIndex:i]objectForKey:@"weight"] doubleValue];
                    ocrblockdetialmodel.originalWeight = [[[array objectAtIndex:i]objectForKey:@"weight"] doubleValue];
                    [ocrblockjsonmodel.noteDtl addObject:ocrblockdetialmodel];
                    
                    [tempArray addObject:ocrblockdetialmodel];
                }
                if (self.scanSuccess) {
                    self.scanSuccess(ocrblockjsonmodel);
                }
               [SVProgressHUD dismiss];
               if (self.scanHuangLuSuccess) {
                self.scanHuangLuSuccess(tempArray);
                }
                weakSelf.tapGestureRecognizer.enabled = YES;
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else{
                //[SVProgressHUD dismiss];
                weakSelf.tapGestureRecognizer.enabled = YES;
                [SVProgressHUD showErrorWithStatus:@"扫描失败，请重新扫描码单"];
            }
        }else{
           // [SVProgressHUD dismiss];
            weakSelf.tapGestureRecognizer.enabled = YES;
            [SVProgressHUD showErrorWithStatus:@"扫描失败，请重新扫描码单"];
        }
    }];
    
}






- (void)onSnapshotBtn:(id)sender {
   // __weak typeof(self) weakSelf = self;
    [self.captureCameraView captureImageWithCompletionHandler:^(UIImage *data, CIRectangleFeature *borderDetectFeature) {
        //__strong typeof(self) strongSelf = weakSelf;
        ZZImageEditTool *tool = [ZZImageEditTool showViewWithImg:data andSelectClipRatio:0];
        tool.cancelBlock = ^{
            self.tapGestureRecognizer.enabled = YES;
        // 重拍
        };
        tool.finishBlock = ^(UIImage *image) {
            
            self.tapGestureRecognizer.enabled = NO;
            [SVProgressHUD showWithStatus:@"正在获取中....."];
            //[SVProgressHUD setMaximumDismissTimeInterval:MAXFLOAT];
            [self aliYunNewData:image];
           // NSDictionary *options = @{@"templateSign": @"bb02151a52da4bce7a12f72669843667"};
           // [[AipOcrService shardService]iOCRRecognitionFromImage:image withOptions:options successHandler:_successHandler failHandler:_failHandler];
        };
    }];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateRecognized)
    {
        CGPoint location = [sender locationInView:self.view];
        [self.captureCameraView focusAtPoint:location completionHandler:^
         {
             [self focusIndicatorAnimateToPoint:location];
         }];
        [self focusIndicatorAnimateToPoint:location];
    }
}

- (void)focusIndicatorAnimateToPoint:(CGPoint)targetPoint
{
    [self.focusIndicator setCenter:targetPoint];
    self.focusIndicator.alpha = 0.0;
    self.focusIndicator.hidden = NO;
    
    [UIView animateWithDuration:0.4 animations:^
     {
         self.focusIndicator.alpha = 1.0;
     }
                     completion:^(BOOL finished)
     {
         [UIView animateWithDuration:0.4 animations:^
          {
              self.focusIndicator.alpha = 0.0;
          }];
     }];
}

- (void)popSelf
{
    //[[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.navigationController popViewControllerAnimated:YES];;
}


// 更新
- (void)updateTitleLabel
{
    CATransition *animation = [CATransition animation];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    animation.duration = 0.5;
    [self.navTitleLabel.layer addAnimation:animation forKey:@"kCATransitionFade"];
    //self.navTitleLabel.text = self.captureCameraView.isTorchEnabled ? @"闪光灯 开" : @"闪光灯 关";
    self.navTitleLabel.text = @"扫描";
}

#pragma mark - Contraints
- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [_navToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if (iphonex || iPhoneXR || iPhoneXS || iPhoneXSMax) {
            
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(88);
            
        }else{
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(NAV_HEIGHT + 10);
        }
    }];
    
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        //make.centerY.mas_equalTo(_navToolBar);
        make.top.mas_equalTo(_navToolBar).offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [_flashLigthToggle mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(0);
        //make.centerY.mas_equalTo(_navToolBar);
        make.top.mas_equalTo(_navToolBar).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 40));
    }];
    
    [_navTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(_navToolBar);
    }];
    
    
    [_takePictureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    
//    [_snapshotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.right.bottom.mas_equalTo(self.view);
//        make.height.mas_equalTo(65);
//        //make.size.mas_equalTo(CGSizeMake(65, 65));
//       // make.bottom.mas_equalTo(-25);
//        //make.centerX.mas_equalTo(self.view);
//    }];
    
    [_captureCameraView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(_navToolBar.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
}
@end
