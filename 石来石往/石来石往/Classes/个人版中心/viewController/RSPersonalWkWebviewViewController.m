//
//  RSPersonalWkWebviewViewController.m
//  石来石往
//
//  Created by mac on 2019/5/15.
//  Copyright © 2019 mac. All rights reserved.
//

#import "RSPersonalWkWebviewViewController.h"
/**显示进度条*/
#import "RSViewProgressLine.h"
#import "AppDelegate.h"
#import "RSCodeSheetModel.h"
#import "RSWeChatShareTool.h"
#import "LXActivity.h"
#import "RSReportFormShareBLModel.h"
#import "RSReportFormShareSLModel.h"
#import "RSReportFormShareSLPiecesModel.h"

@interface RSPersonalWkWebviewViewController ()<WKNavigationDelegate,UINavigationControllerDelegate,WKScriptMessageHandler,LXActivityDelegate>
{
    NSString * shareStr;
}

@property (nonatomic,strong)RSViewProgressLine * progressLineview;

@property (nonatomic,strong)UIView * htmlView;

@property (nonatomic,strong)WKWebView * webView;

@end

@implementation RSPersonalWkWebviewViewController

- (NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = true;
    [self setNewOrientation:NO];
    
    if ([[[UIDevice currentDevice]systemVersion]intValue ] >= 9.0) {
        NSArray * types =@[WKWebsiteDataTypeMemoryCache,WKWebsiteDataTypeDiskCache]; // 9.0之后才有的
        NSSet *websiteDataTypes = [NSSet setWithArray:types];
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
        }];
    }else{
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask,YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSLog(@"%@", cookiesFolderPath);
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
    //self.navigationItem.leftBarButtonItem.customView.hidden = YES;

    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 50);
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(outH5WebviewAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    self.view.backgroundColor = [UIColor colorWithHexColorStr:@"#f9f9f9"];
    self.htmlView = [[UIView alloc]init];
    self.htmlView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.htmlView];
    self.progressLineview = [[RSViewProgressLine alloc] init];
    self.progressLineview.lineColor = [UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1.0];
    [self.htmlView addSubview:self.progressLineview];
    WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc]init];
    WKUserContentController * userContent = [[WKUserContentController alloc]init];
    [userContent addScriptMessageHandler:self name:@"tixing"];
    [userContent addScriptMessageHandler:self name:@"load"];
    [userContent addScriptMessageHandler:self name:@"cancel"];
    [userContent addScriptMessageHandler:self name:@"share"];
    [userContent addScriptMessageHandler:self name:@"getIOSBlockType"];
    config.userContentController = userContent;
    WKWebView * webview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 1, self.htmlView.bounds.size.width, self.htmlView.bounds.size.height) configuration:config];
    _webView = webview;
    _webView.navigationDelegate = self;
    _webView.userInteractionEnabled = YES;
    //@"http://192.168.1.191:8080/"
    //http://192.168.1.152:8888/slsw/pwms/reportList.html
    NSString * stoneUrlStr = [NSString string];
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0){
        stoneUrlStr = [self.ulrStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        [NSCharacterSet URLQueryAllowedCharacterSet];
    }else{
        stoneUrlStr= [self.ulrStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    
    NSURL * urlStr = [[NSURL alloc]initWithString:stoneUrlStr];
    NSMutableURLRequest *requst = [[NSMutableURLRequest alloc]initWithURL:urlStr];
    [_webView loadRequest:requst];
    [self.htmlView addSubview:webview];
    self.htmlView.sd_layout
    .leftSpaceToView(self.view, 0)
    .rightSpaceToView(self.view, 0)
    .bottomSpaceToView(self.view, 0)
    .topSpaceToView(self.view, 0);
    self.progressLineview.sd_layout
    .leftSpaceToView(self.htmlView, 0)
    .rightSpaceToView(self.htmlView, 0)
    .topSpaceToView(self.htmlView, 0)
    .heightIs(1);
    self.webView.sd_layout
    .leftSpaceToView(self.htmlView, 0)
    .rightSpaceToView(self.htmlView, 0)
    .topSpaceToView(self.progressLineview, 0)
    .bottomSpaceToView(self.htmlView, 0);
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:(UIBarButtonItemStyleDone) target:self action:@selector(shareAction)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)outH5WebviewAction{
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = false;//关闭横屏仅允许竖屏
    [self setNewOrientation:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:@"tixing"]) {
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%@",message.body]];
    }
    if ([message.name isEqualToString:@"load"]) {
        [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"%@",message.body]];
    }
    if ([message.name isEqualToString:@"cancel"]) {
        [SVProgressHUD dismiss];
    }
    if ([message.name isEqualToString:@"share"]) {
        //NSLog(@"===================%@",message.body);
        shareStr = message.body;
    }
    if ([message.name isEqualToString:@"getIOSBlockType"]) {
//        NSLog(@"-------------------%@",message.body);
        if ([message.body isEqualToString:@"1"]) {
            NSMutableArray * strArray = [NSMutableArray array];
            for (int i = 0; i < self.selectArray.count; i++) {
                RSReportFormShareBLModel * reportFormShareBLmodel = self.selectArray[i];
                NSString * str = [NSString stringWithFormat:@"{\"did\":\"%ld\",\"deaName\":\"%@\",\"deacode\":\"%@\",\"msid\":\"%@\",\"csid\":\"%@\",\"mtlname\":\"%@\",\"materialtype\":\"%@\",\"mtlcode\":\"%@\",\"lenght\":\"%ld\",\"width\":\"%ld\",\"height\":\"%ld\",\"volume\":\"%@\",\"weight\":\"%@\",\"whsname\":\"%@\",\"storeareaname\":\"%@\",\"locationname\":\"%@\",\"qty\":\"%ld\",\"n\":\"%ld\"}",reportFormShareBLmodel.did,reportFormShareBLmodel.deaName,reportFormShareBLmodel.deacode,reportFormShareBLmodel.msid,reportFormShareBLmodel.csid,reportFormShareBLmodel.mtlname,reportFormShareBLmodel.materialtype,reportFormShareBLmodel.mtlcode,reportFormShareBLmodel.lenght,reportFormShareBLmodel.width,reportFormShareBLmodel.height,reportFormShareBLmodel.volume,reportFormShareBLmodel.weight,reportFormShareBLmodel.whsname,reportFormShareBLmodel.storeareaname,reportFormShareBLmodel.locationname,reportFormShareBLmodel.qty,reportFormShareBLmodel.n];
                [strArray addObject:str];
            }
//      NSData *data = [NSJSONSerialization dataWithJSONObject:strArray options:NSJSONWritingPrettyPrinted error:nil];
//      NSString * jsonStr =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSString * data = [self objArrayToJSON:strArray];
            NSString * ss = [NSString stringWithFormat:@"codeListDataIOS('%@')",data];
            [self.webView evaluateJavaScript:ss completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            }];
        }else if ([message.body isEqualToString:@"2"]){
            NSMutableArray * strArray = [NSMutableArray array];
            for (int i = 0; i < self.selectArray.count; i++){
                RSReportFormShareSLModel * reportFormShareSLmodel = self.selectArray[i];
                NSMutableArray * pieces = [NSMutableArray array];
                for (int j = 0; j < reportFormShareSLmodel.pieces.count; j++) {
                    RSReportFormShareSLPiecesModel * reportFormShareSLPiecesmodel = reportFormShareSLmodel.pieces[j];
                    NSString * piecesStr = [NSString stringWithFormat:@"{\"did\":\"%ld\",\"deaName\":\"%@\",\"msid\":\"%@\",\"csid\":\"%@\",\"mtlname\":\"%@\",\"materialtype\":\"%@\",\"lenght\":\"%ld\",\"width\":\"%ld\",\"height\":\"%ld\",\"area\":\"%@\",\"dedarea\":\"%@\",\"prearea\":\"%@\",\"ded_length_one\":\"%@\",\"ded_wide_one\":\"%@\",\"ded_length_two\":\"%@\",\"ded_wide_two\":\"%@\",\"ded_length_three\":\"%@\",\"ded_wide_three\":\"%@\",\"ded_length_four\":\"%@\",\"ded_wide_four\":\"%@\",\"turnsno\":\"%@\",\"slno\":\"%@\",\"whsname\":\"%@\",\"storeareaname\":\"%@\",\"locationname\":\"%@\",\"qty\":\"%ld\",\"n\":\"%ld\"}",reportFormShareSLPiecesmodel.did,reportFormShareSLPiecesmodel.deaName,reportFormShareSLPiecesmodel.msid,reportFormShareSLPiecesmodel.csid,reportFormShareSLPiecesmodel.mtlname,reportFormShareSLPiecesmodel.materialtype,reportFormShareSLPiecesmodel.lenght,reportFormShareSLPiecesmodel.width,reportFormShareSLPiecesmodel.height,reportFormShareSLPiecesmodel.area,reportFormShareSLPiecesmodel.dedarea,reportFormShareSLPiecesmodel.prearea,reportFormShareSLPiecesmodel.ded_length_one,reportFormShareSLPiecesmodel.ded_wide_one,reportFormShareSLPiecesmodel.ded_length_two,reportFormShareSLPiecesmodel.ded_wide_two,reportFormShareSLPiecesmodel.ded_length_three,reportFormShareSLPiecesmodel.ded_wide_three,reportFormShareSLPiecesmodel.ded_length_four,reportFormShareSLPiecesmodel.ded_wide_four,reportFormShareSLPiecesmodel.turnsno,reportFormShareSLPiecesmodel.slno,reportFormShareSLPiecesmodel.whsname,reportFormShareSLPiecesmodel.storeareaname,reportFormShareSLPiecesmodel.locationname,reportFormShareSLPiecesmodel.qty,reportFormShareSLPiecesmodel.n];
                    //NSString * data = [self objArrayToJSON:strArray];
                    [pieces addObject:piecesStr];
                }
                NSString * piecesStr = [self objArrayToJSON:pieces];
                NSString * str = [NSString stringWithFormat:@"{\"deaName\":\"%@\",\"msid\":\"%@\",\"csid\":\"%@\",\"mtlname\":\"%@\",\"materialtype\":\"%@\",\"qty\":\"%ld\",\"turnsno\":\"%@\",\"area\":\"%@\",\"n\":\"%ld\",\"pieces\":%@}",reportFormShareSLmodel.deaName,reportFormShareSLmodel.msid,reportFormShareSLmodel.csid,reportFormShareSLmodel.mtlname,reportFormShareSLmodel.materialtype,reportFormShareSLmodel.qty,reportFormShareSLmodel.turnsno,reportFormShareSLmodel.area,reportFormShareSLmodel.n,piecesStr];
                [strArray addObject:str];
            }
            NSString * data = [self objArrayToJSON:strArray];
            NSString * ss = [NSString stringWithFormat:@"codeListDataIOS('%@')",data];
//            NSLog(@"==================%@",ss);
            [self.webView evaluateJavaScript:ss completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            }];
        }
    }
}

- (NSString *)objArrayToJSON:(NSMutableArray *)array {
    NSString *jsonStr = @"[";
    for (NSInteger i = 0; i < array.count; ++i) {
        if (i != 0) {
            jsonStr = [jsonStr stringByAppendingString:@","];
        }
        jsonStr = [jsonStr stringByAppendingString:array[i]];
    }
    jsonStr = [jsonStr stringByAppendingString:@"]"];
    return jsonStr;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [self.progressLineview startLoadingAnimation];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.progressLineview endLoadingAnimation];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [self.progressLineview endLoadingAnimation];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [SVProgressHUD dismiss];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"xiaoxin"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"load"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"cancel"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"share"];
    [_webView.configuration.userContentController removeScriptMessageHandlerForName:@"getIOSBlockType"];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
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
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];
        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;  //支持横向
}

//设置为允许旋转
- (BOOL) shouldAutorotate {
    return YES;
}

#pragma mark -- 分享
- (void)shareAction{
    RSWeakself
//    [JHSysAlertUtil presentAlertViewWithTitle:@"确定是否分享该数据" message:nil cancelTitle:@"取消" defaultTitle:@"确定" distinct:YES cancel:^{
//    } confirm:^{
//
//    }];
    UIAlertController * alertView = [UIAlertController alertControllerWithTitle:@"确定是否分享该数据" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertView addAction:alert];
    UIAlertAction * alert1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //这边是确定的东西
        [weakSelf shareReloadNetworkString:shareStr];
    }];
    [alertView addAction:alert1];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 13.0) {
        alertView.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:alertView animated:YES completion:nil];
}

//FIXME:这边要把从H5页面上面拿到的值，发送到后台去，然后在返回一个URL网址进行分享
- (void)shareReloadNetworkString:(NSString *)shareStr{
    /**
     分享标题    title    String    默认填（码单分享）
     分享页面    content    String    存页面
     分享描述    describe    String    默认填（码单分享）
     分享类别    shareType    String    默认填（码单分享）
     石种名称    proName    String    石种名称（用户返回默认图，不传返回石来石往默认图标）
     */
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * verifykey = [user objectForKey:@"VERIFYKEY"];
    NSMutableDictionary *phoneDict = [NSMutableDictionary dictionary];
    [phoneDict setObject:shareStr forKey:@"content"];
    if (self.showT == 1) {
        self.typeStr = @"码单分享";
    }
    [phoneDict setObject:self.typeStr forKey:@"title"];
    [phoneDict setObject:self.typeStr forKey:@"describe"];
    [phoneDict setObject:self.typeStr forKey:@"shareType"];
    //二进制数
    NSData *data = [NSJSONSerialization dataWithJSONObject:phoneDict options:0 error:nil];
    NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    AppDelegate * applegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSDictionary *parameters = @{@"key":[NSString get_uuid] ,@"Data":dataStr,@"VerifyKey":verifykey,@"VerifyCode":[NSString get_verifyCode],@"erpId":applegate.ERPID};
    RSWeakself
    XLAFNetworkingBlock * network = [[XLAFNetworkingBlock alloc]init];
    NSString * str = [NSString string];
    if (self.showT == 1) {
//        str = [NSString stringWithFormat:@"%@slsw/reportList.html",URL_HEADER_TEXT_IOS];
        str = URL_SHAREPAGES_IOS;
    }else{
        str = URL_ADDPWMSUSRSHARE_IOS;
    }
    [network getDataWithUrlString:str withParameters:parameters withBlock:^(id json, BOOL success) {
        if (success) {
            BOOL Result = false;
            if (weakSelf.showT == 1) {
               Result = [json[@"Result"] boolValue];
            }else{
               Result = [json[@"success"] boolValue];
            }
            if (Result) {
                RSCodeSheetModel * codeSheetmodel = [[RSCodeSheetModel alloc]init];
                if (weakSelf.showT == 1) {
                    codeSheetmodel.img = json[@"Data"][@"img"];
                    codeSheetmodel.url = json[@"Data"][@"url"];
                }else{
                    codeSheetmodel.img = json[@"data"][@"imgUrl"];
                    codeSheetmodel.url = json[@"data"][@"shareUrl"];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf showChoiceShareView:codeSheetmodel];
                });
            }
            else{
                // [SVProgressHUD showErrorWithStatus:@"分享失败"];
            }
        }else{
            // [SVProgressHUD showErrorWithStatus:@"分享失败"];
        }
    }];
}

- (void)showChoiceShareView:(RSCodeSheetModel *)codeSheetmodel{
    NSArray *shareButtonTitleArray = nil;
    NSArray *shareButtonImageNameArray = nil;
    shareButtonTitleArray = @[@"微信",@"微信朋友圈"];
    shareButtonImageNameArray = @[@"微信",@"微信朋友圈"];
    LXActivity * lxActivity= [[LXActivity alloc]initWithTitle:@"分享到社交平台" delegate:self cancelButtonTitle:@"取消分享" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray andRSCodeSheetModel:codeSheetmodel];
    [lxActivity showInView:self.view];
}

- (void)didClickOnImageIndex:(NSInteger *)imageIndex andRSCodeSheetModel:(RSCodeSheetModel *)codeSheetModel{
    [RSWeChatShareTool codeSheetweChatShareStyleShareStrImageIndex:imageIndex andRSCodeSheetModel:codeSheetModel andShareStr:shareStr andTypeStr:self.typeStr];
}

-(void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation{
    UIDevice *device = [UIDevice currentDevice] ;
    switch (device.orientation) {
        case UIDeviceOrientationFaceUp:
            //NSLog(@"屏幕朝上平躺");
            break;
        case UIDeviceOrientationFaceDown:
            //NSLog(@"屏幕朝下平躺");
            break;
        case UIDeviceOrientationUnknown:
            //NSLog(@"未知方向");
            break;
        case UIDeviceOrientationLandscapeLeft:
            //NSLog(@"屏幕向左");
            break;
        case UIDeviceOrientationLandscapeRight:
            //NSLog(@"屏幕向右");
            break;
        case UIDeviceOrientationPortrait:
            //NSLog(@"屏幕向上");
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            //NSLog(@"屏幕向下");
            break;
    }
}

@end
